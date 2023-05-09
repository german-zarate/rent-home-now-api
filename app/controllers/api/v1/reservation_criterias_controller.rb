class Api::V1::ReservationCriteriasController < ApplicationController
  def index
    @reservation_criterias = ReservationCriteria.all
    render json: @reservation_criterias
  end

  def show
    @reservation_criteria = ReservationCriteria.find(params[:id])
    render json: @reservation_criteria
  end

  def create
    @reservation_criteria = ReservationCriteria.new(reservation_criteria_params)
    if @reservation_criteria.save
      render json: @reservation_criteria, status: :created
    else
      render json: @reservation_criteria.errors, status: :unprocessable_entity
    end
  end

  def update
    @reservation_criteria = ReservationCriteria.find(params[:id])
    if @reservation_criteria.update(reservation_criteria_params)
      render json: @reservation_criteria
    else
      render json: @reservation_criteria.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation_criteria = ReservationCriteria.find(params[:id])
    @reservation_criteria.destroy
    head :no_content
  end

  private

  def reservation_criteria_params
    params.permit(:time_period, :others_fee, :min_time_period, :max_guest, :rate, :property_id)
  end
end
