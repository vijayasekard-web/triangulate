module ApiHelper
  def api_validation_errors(errors)
    hash = {}
    errors.each do |attribute, messages|
      hash[attribute] = [messages].flatten.map{|message_key| { type: message_key, message: I18n.t(message_key, :scope => "errors") } }
    end
    return hash
  end

  def respond_with_validation_errors(errors, status = :bad_request)
    render json: { errors: api_validation_errors(errors) }, status: status
  end


  def respond_with_resource_not_found(klass)
    render json: { errors: api_resource_not_found_error(klass)}, :status => :not_found
  end
end
