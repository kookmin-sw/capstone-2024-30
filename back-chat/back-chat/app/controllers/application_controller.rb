class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from StandardError, with: :handle_standard_error
  rescue_from JWT::DecodeError, with: :handle_jwt_error

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

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    @decoded = JsonWebToken.decode(header)
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
end
