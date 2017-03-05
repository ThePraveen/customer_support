class Api::V1::UsersController < ApplicationController

  # before_action :authenticate_user!

  def index
    users = User.all
    render json: {
        status: "success",
        message: "Users found",
        data: { users: users.as_json(:methods => [:roles_array])}
    }, status: :ok and return
  end

  def show
    user = User.find(params[:id])
    render json: {
                  status: "success",
                  message: "User found",
                  data: { users: user}
                 }, status: :ok and return
  rescue ActiveRecord::RecordNotFound => e
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))
    render json: {status: "error", message: e.message}, status: :not_found
  end
end
