class ApplicationController < ActionController::API
  include JwtToken
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied, with: :unauthorized_user
  def not_found
    render json: { error: 'Route not found' }, status: :not_found
  end

  protected

  def authenticate_user
    header = request.headers['Authorization']
    token = header.split.last if header

    begin
      @decoded = JwtToken.verify(token)

      curr_time = Time.now
      if curr_time > @decoded[:exp]
        return render json: { success: false, error: 'Invalid token!' },
                      status: :unauthorized
      end

      @current_user = User.find(@decoded[:user_id])
      @current_user.password_digest = nil
    rescue ActiveRecord::RecordNotFound => e
      render json: { success: false, error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => _e
      render json: { success: false, error: 'Invalid token!' }, status: :unauthorized
    end
  end

  attr_reader :current_user

  def unauthorized_user(_exception)
    render json: { success: false, error: 'Unauthorize access denied!' }, status: :forbidden
  end
end
