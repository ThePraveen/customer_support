module ApplicationHelper

  include CommonOperations

  def extract_params(params, keys)
    params = params.deep_symbolize_keys
    out = {}
    keys.each do |k|
      if k.class == Symbol || k.class == String
        out[k] = params[k] if params[k].present?
      else
        nested_key = k.keys.first
        nested_keys = k[nested_key]
        nested_params = params[nested_key]
        if nested_params.present?
          if nested_params.class == Array
            out[nested_key] = []
            nested_params.each do |nested_param|
              out[nested_key] << extract_params(nested_param, nested_keys)
            end
          else
            out[nested_key] = extract_params(nested_params, nested_keys)
          end
        end
      end
    end
    out
  rescue Exception => e
  end


  def role_level_data(user, roles = [])
    data = {}
    (roles.presence || user.roles_array).each do |role|
      data[role] = user.role_data(role)
    end
    data
  end


end
