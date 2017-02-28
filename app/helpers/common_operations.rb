module CommonOperations

  def initialize_response_params
    {:include => {}, :except => timestamps, :methods => []}
  end

  def validate_http_request(request)
    request.body.rewind
    body = request.body.read
    JSON.parse (body.present? ? body : '{}')
  end

  def get_limit_offset(params)
    limit = (params[:limit] || 10).to_i
    page = [params[:page].to_i, 1].max
    offset = (page-1)*limit
    [limit, page, offset]
  end

  def generate_search_response(entity, search_response, offset, limit, total, response_params = {})
    params = {entity => search_response, :offset => offset, :limit => limit, :count => search_response.size, :total => total}
    generate_custom_response(params, response_params)
  end

  def generate_custom_response(params = {}, response_params = {}, http_status = 200)
    extra = response_params.delete :extra
    render json: {
        "status": "success",
        "data": params.as_json(response_params).merge(extra || {})
    }, status: http_status
  end

  def generate_error_response(params, http_status = 400)
    Rails.logger.debug "RESPONSE : #{http_status} - #{params.as_json}"
    halt http_status, params.to_json
  end

  def true?(flag)
    %w(True true Yes yes).include? flag.to_s
  end

  def false?(flag)
    %w(False false No no).include? flag.to_s
  end

  def timestamps
    [:created_at, :updated_at]
  end
end