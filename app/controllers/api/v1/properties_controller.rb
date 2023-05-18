class Api::V1::PropertiesController < ApplicationController
  before_action :authenticate_user, except: %i[index show]
  before_action :set_property, only: %i[show update destroy]
  before_action :set_default_response_format
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @properties = Property.joins(:reservation_criteria).distinct
    render json: @properties, include: %i[reservation_criteria category images address]
  end

  def show
    @property = Property.find(params[:id])
    render json: @property, include: %i[user category images address reservation_criteria reservation]
  end

  def create
    @property = @current_user.property.new(property_params)
    if @property.save
      if params[:images].present?
        params[:images].each do |image_source|
          @property.images.create(source: image_source)
        end
      end
      render json: @property, include: %i[user category images address reservation_criteria], status: :created
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def update
    if @property.update(property_params)
      render json: @property, include: %i[user category images address reservation_criteria]
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    head :no_content
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def property_params
    params.require(:property).permit(
      :name,
      :description,
      :no_bedrooms,
      :no_baths,
      :no_beds,
      :area,
      :category_id,
      images: []
    )
  end

  def set_default_response_format
    request.format = :json
  end

  def record_not_found
    render json: { error: 'Record not found', status: :not_found }, status: :not_found
  end
end
