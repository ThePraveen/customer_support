# see http://www.emilsoman.com/blog/2013/05/18/building-a-tested/
module Api::V1
  class SessionsController < DeviseTokenAuth::ApplicationController
    before_action :set_user_by_token, :only => [:destroy]
    after_action :reset_session, :only => [:destroy]

    def new
      render_new_error
    end


    api :POST, 'api/auth/sign_in', "Sign In"
    description "Sign in using email. Need to pass role with which you wish to login"

    param :email, String, :desc => "Payload Param : email", :required => true
    param :password, String, :desc => "Payload Param : password", :required => true
    param :role, String, :desc => "Payload Param : role with which you user want to login", :required => true

    example '

          ------- SAMPLE REQUEST and RESPONSES --------

          1. success: 201
          REQUEST
          {
            "email": "thepraveen0207@gmail.com",
            "password": "11111111",
            "role": "customer"
          }
          RESPONSE
          {
            "data": {
              "id": 2,
              "email": "thepraveen0207@gmail.com",
              "provider": "email",
              "uid": "thepraveen0207@gmail.com",
              "name": "Praveen Sah",
              "nickname": null,
              "image": "https://lh5.googleusercontent.com/-WRezx-wsjTk/AAAAAAAAAAI/AAAAAAAAEio/5HNv3juLszM/photo.jpg?sz=250",
              "roles": [
                "customer"
              ],
              "logged_in_as": "customer",
              "customer": {
                "id": 1
              }
            }
          }
          '
    def create

      unless params[:role].present?
        render_role_not_passed_error
        return
      end
      # Check
      field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first

      @resource = nil
      if field
        q_value = resource_params[field]

        if resource_class.case_insensitive_keys.include?(field)
          q_value.downcase!
        end

        q = "#{field.to_s} = ? AND provider='email'"

        if ActiveRecord::Base.connection.adapter_name.downcase.starts_with? 'mysql'
          q = "BINARY " + q
        end

        @resource = resource_class.where(q, q_value).first
      end

      unless @resource.roles_array.include? params[:role]
        render_create_error_wrong_role
        return
      end

      if @resource and valid_params?(field, q_value) and @resource.valid_password?(resource_params[:password]) and (!@resource.respond_to?(:active_for_authentication?) or @resource.active_for_authentication?)
        # create client id
        @client_id = SecureRandom.urlsafe_base64(nil, false)
        @token     = SecureRandom.urlsafe_base64(nil, false)

        @resource.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
        }
        @resource.save

        sign_in(:user, @resource, store: false, bypass: false)

        yield @resource if block_given?

        if params[:role].present? && @resource.roles_array.include?(params[:role])
          render_create_success
        else
          render_create_error_bad_credentials
        end

        # render_create_success
      elsif @resource and not (!@resource.respond_to?(:active_for_authentication?) or @resource.active_for_authentication?)
        render_create_error_not_confirmed
      else
        render_create_error_bad_credentials
      end
    end

    def destroy
      # remove auth instance variables so that after_action does not run
      user = remove_instance_variable(:@resource) if @resource
      client_id = remove_instance_variable(:@client_id) if @client_id
      remove_instance_variable(:@token) if @token

      if user and client_id and user.tokens[client_id]
        user.tokens.delete(client_id)
        user.save!

        yield user if block_given?

        render_destroy_success
      else
        render_destroy_error
      end
    end

    protected

    def valid_params?(key, val)
      resource_params[:password] && key && val
    end

    def get_auth_params
      auth_key = nil
      auth_val = nil

      # iterate thru allowed auth keys, use first found
      resource_class.authentication_keys.each do |k|
        if resource_params[k]
          auth_val = resource_params[k]
          auth_key = k
          break
        end
      end

      # honor devise configuration for case_insensitive_keys
      if resource_class.case_insensitive_keys.include?(auth_key)
        auth_val.downcase!
      end

      return {
        key: auth_key,
        val: auth_val
      }
    end

    def render_new_error
      render json: {
        errors: [ I18n.t("devise_token_auth.sessions.not_supported")]
      }, status: 405
    end

    def render_create_success
      render json: {
        data: resource_data(resource_json: @resource.token_validation_response.merge(:roles => @resource.roles.map{ |n| n.name }, :logged_in_as => params[:role]).merge(role_level_data(@resource)))
      }
    end

    def render_create_error_not_confirmed
      render json: {
        success: false,
        errors: [ I18n.t("devise_token_auth.sessions.not_confirmed", email: @resource.email) ]
      }, status: 401
    end

    def render_create_error_bad_credentials
      render json: {
        errors: [I18n.t("devise_token_auth.sessions.bad_credentials")]
      }, status: 401
    end

    def render_create_error_wrong_role
      render json: {
          errors: ["Not authorised to login as this role"]
      }, status: 401
    end

      def render_role_not_passed_error
        render json: {
            errors: ["Role not passed"]
        }, status: 400
      end

    def render_destroy_success
      render json: {
        success:true
      }, status: 200
    end

    def render_destroy_error
      render json: {
        errors: [I18n.t("devise_token_auth.sessions.user_not_found")]
      }, status: 404
    end


    private

    def resource_params
      params.permit(*params_for_resource(:sign_in))
    end

  end
end
