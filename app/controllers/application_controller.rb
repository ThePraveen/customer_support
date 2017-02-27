class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :image, :confirm_success_url)}
  end

end
