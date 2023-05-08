require 'rails_helper'

RSpec.describe 'ReservationCriterias', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/reservation_criterias/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/reservation_criterias/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/reservation_criterias/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/reservation_criterias/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/reservation_criterias/update'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/reservation_criterias/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
