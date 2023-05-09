class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user, except: :create
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy

    render json: { message: 'User deleted successfully' }, status: :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def user_not_found
    render json: { error: "No user with id #{params[:id]}" }, status: :not_found
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :role)
  end
end
