class Api::V1::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    render json: @categories
  end

  def show
    @categories = Category.includes(:properties).find(params[:id])
    render json: @categories, include: %i[properties]
  end
end
