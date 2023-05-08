require 'rails_helper'

RSpec.describe 'Properties', type: :request do
  before do
    @category = Category.create(name: 'new category')
    @address = Address.create(street: '123 Main St', city: 'New York', state: 'NY', zip_code: '10001',
                              house_number: '12k32', country: 'USA')
    @reservation_criteria = ReservationCriteria.create(time_period: 'week', min_time_period: 7, others_fee: 100,
                                                       max_guest: 10, rate: 10)
    @user = User.create(name: 'John Doe', email: 'john@example.com', password: 'password', avatar: 'avatar.png')

    @property1 = Property.create(
      name: 'My Property',
      description: 'This is my property',
      no_bedrooms: 2,
      no_baths: 2,
      no_beds: 3,
      area: 150,
      user: @user,
      category: @category,
      address: @address,
      reservation_criteria: @reservation_criteria
    )
  end
  describe 'GET /api/v1/properties' do
    it 'returns a successful response' do
      get '/api/v1/properties'
      expect(response).to have_http_status(:success)
    end
    it 'returns a JSON response' do
      get '/api/v1/properties'
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
    it 'returns a list of properties' do
      get '/api/v1/properties'
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      body = JSON.parse(response.body)
      expect(body.count).to eq(1)
      expect(body[0]['name']).to eq('My Property')
      expect(body[0]['description']).to eq('This is my property')
      expect(body[0]['no_bedrooms']).to eq(2)
      expect(body[0]['no_baths']).to eq(2)
      expect(body[0]['no_beds']).to eq(3)
      expect(body[0]['area']).to eq(150)
    end
  end

  describe 'GET /api/v1/properties/:id' do
    before do
      get "/api/v1/properties/#{@property1.id}"
    end
    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end
    it 'returns the requested property' do
      body = JSON.parse(response.body)
      expect(body['id']).to eq(@property1[:id])
      expect(body['name']).to eq(@property1[:name])
      expect(body['description']).to eq(@property1[:description])
      expect(body['no_bedrooms']).to eq(@property1[:no_bedrooms])
      expect(body['no_baths']).to eq(@property1[:no_baths])
      expect(body['no_beds']).to eq(@property1[:no_beds])
    end
  end

  describe 'DELETE /api/v1/properties/:id' do
    it 'deletes the property and returns a success message' do
      expect do
        delete "/api/v1/properties/#{@property1.id}"
      end.to change(Property, :count).by(-1)
      expect(response).to have_http_status(:no_content)
      expect(response.body).to be_empty
    end
  end
end
