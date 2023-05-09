require 'rails_helper'

RSpec.describe 'ReservationCriterias', type: :request do
  include Warden::Test::Helpers
  subject do
    @user = User.create!(name: 'Sambeck', email: 'sambeck@gmail.com', password: 'password',
                         password_confirmation: 'password', role: 'admin', avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
    login_as(@user, scope: :user)
    @category = Category.create!(name: 'House')
    @property = Property.create!(name: 'My Home', description: 'My fabolous home', no_bedrooms: 5, no_baths: 2,
                                 no_beds: 6, area: 120, user_id: @user.id, category_id: @category.id)
    ReservationCriteria.create!(time_period: 'weekly', min_time_period: 2, others_fee: 10.2, max_guest: 5, rate: 110,
                                property_id: @property.id)
  end

  before { subject.save }
  describe 'GET /index' do
    before do
      get api_v1_reservation_criterias_path
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should display only one reservation criteria' do
      response_body = JSON.parse(response.body)
      expect(response_body.length).to eq(1)
    end

    it 'time_period should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body[0]['time_period']).to eq(subject.time_period)
    end

    it 'min_time_period should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body[0]['min_time_period']).to eq(subject.min_time_period)
    end

    it 'others_fee should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body[0]['others_fee']).to eq(subject.others_fee)
    end

    it 'max_guest should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body[0]['max_guest']).to eq(subject.max_guest)
    end

    it 'rate should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body[0]['rate']).to eq(subject.rate)
    end
  end

  describe 'GET /show' do
    before do
      get api_v1_reservation_criteria_path(id: subject.id)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'time_period should be "weekly"' do
      response_body = JSON.parse(response.body)
      expect(response_body['time_period']).to eq('weekly')
    end

    it 'min_time_period should be 2' do
      response_body = JSON.parse(response.body)
      expect(response_body['min_time_period']).to eq(2)
    end

    it 'others_fee should be 10.2' do
      response_body = JSON.parse(response.body)
      expect(response_body['others_fee']).to eq(10.2)
    end

    it 'max_guest should be 5' do
      response_body = JSON.parse(response.body)
      expect(response_body['max_guest']).to eq(5)
    end

    it 'rate should be 110' do
      response_body = JSON.parse(response.body)
      expect(response_body['rate']).to eq(110)
    end
  end

  describe 'POST /create' do
    before do
      reservation_criteria_params = {
        time_period: 'monthly',
        others_fee: 20.0,
        min_time_period: 2,
        max_guest: 4,
        rate: 100.0,
        property_id: @property.id
      }
      post api_v1_reservation_criterias_path, params: reservation_criteria_params
    end
    it 'returns http success' do
      expect(response).to have_http_status(:created)
    end

    it 'time_period should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body['time_period']).to eq('monthly')
    end

    it 'min_time_period should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body['min_time_period']).to eq(2)
    end

    it 'others_fee should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body['others_fee']).to eq(20.0)
    end

    it 'max_guest should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body['max_guest']).to eq(4)
    end

    it 'rate should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body['rate']).to eq(100.0)
    end
  end

  describe 'PUT /update' do
    before do
      updated_params = {
        time_period: 'daily',
        others_fee: 200.0,
        min_time_period: 1,
        max_guest: 0,
        rate: 320,
        property_id: @property.id
      }
      put api_v1_reservation_criteria_path(id: subject.id), params: updated_params
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should be the same reservation criteria' do
      response_body = JSON.parse(response.body)
      expect(response_body['property_id']).to eq(@property.id)
    end

    it 'time_period should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body['time_period']).to eq('daily')
    end

    it 'min_time_period should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body['min_time_period']).to eq(1)
    end

    it 'others_fee should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body['others_fee']).to eq(200.0)
    end

    it 'max_guest should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body['max_guest']).to eq(0)
    end

    it 'rate should be present in the request' do
      response_body = JSON.parse(response.body)
      expect(response_body['rate']).to eq(320)
    end
  end

  describe 'DELETE /destroy' do
    it 'returns http success' do
      delete api_v1_reservation_criteria_path(id: subject.id)
      expect(response).to have_http_status(:success)
    end
  end
end
