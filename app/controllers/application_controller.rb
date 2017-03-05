class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ApplicationHelper

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :image, :confirm_success_url)}
  end

  before_action do
    body = request.body.read
    request.body.rewind
    logger.debug "Received request with method= #{request.env['REQUEST_METHOD']}" +
                     " and url = #{request.env['REQUEST_URI']}"+
                     " and body = #{body}" +
                     " and header = #{request.headers}"
  end

  after_action do
    Rails.logger.debug "Response :- Status Code: #{response.status}"
    Rails.logger.debug "Response :- Body #{response.body}"
    Rails.logger.debug "Response :- Header #{response.headers}"
  end

end
