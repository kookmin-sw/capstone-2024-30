class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from StandardError, with: :handle_standard_error
  rescue_from JWT::DecodeError, with: :handle_jwt_error
  rescue_from JWT::ExpiredSignature, with: :handle_jwt_error
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  rescue_from ActionController::RoutingError, with: :handle_not_found
  rescue_from ActionController::MethodNotAllowed, with: :handle_method_not_allowed
  rescue_from ActionController::ParameterMissing, with: :handle_missing_param

  def render_success(success: true, data: {}, message: nil, status: :ok)
    render json: {
      success: success,
      response: data,
      message: message
    }, status: status
  end

  def render_fail(success: false, message: nil, status: nil)
    render json: {
      success: success,
      message: message,
    }, status: status
  end

  private
  def authorize_request
    @decoded = request.headers['x-user-id']
  end

  def handle_not_found(exception)
    render_fail(message: "Resource not found: #{exception.message}", status: :not_found)
  end

  def handle_standard_error(exception)
    render_fail(message: "Internal server error: #{exception.message}", status: :internal_server_error)
  end

  def handle_jwt_error(exception)
    render_fail(message: "JWT Invalid", status: :unauthorized)
  end

  def handle_method_not_allowed(exception)
    render_fail(message: "Method Not Allowed: #{exception.message}", status: :method_not_allowed)
  end

  def handle_record_invalid(exception)
    render_fail(message: "Record invalid: #{exception.message}", status: :bad_request)
  end

  def handle_missing_param(exception)
    render_fail(message: "Invalid Input", status: :bad_request)
  end
end
