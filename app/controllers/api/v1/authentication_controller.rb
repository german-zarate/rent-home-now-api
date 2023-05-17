class Api::V1::AuthenticationController < ApplicationController
  before_action :authenticate_user, only: [:current_user]

  def sign_in
    unless params[:email] && params[:password]
      return render json: { success: false, error: 'Invalid request! Missing information.' },
                    status: :bad_request
    end

    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      user.password_digest = nil
      token = JwtToken.sign({ user_id: user.id })
      render json: {
        success: true,
        data: {
          user:,
          accessToken: token,
          properties: Property.where(user_id: user.id),
          reservations: Reservation.where(user_id: user.id)
        }
      }, status: :ok
    else
      render json: { success: false, error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def current_user
    @my_properties = Property.where(user_id: @current_user.id)
    @my_reservations = Reservation.where(user_id: @current_user.id)
    render json: { success: true, data: { myReservation: @my_reservations,
                                          myProperties: @my_properties, include: %i[images] } },
           status: :ok
  end
end
