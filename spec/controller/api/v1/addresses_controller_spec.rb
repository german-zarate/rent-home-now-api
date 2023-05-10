require 'rails_helper'
RSpec.describe Api::V1::AddressesController, type: :controller do
  before do
    Category.delete_all
    User.delete_all
    Address.delete_all
    @user = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'password',
                         password_confirmation: 'password', avatar: Faker::LoremFlickr.image)
    @category = Category.create!(name: Faker::Lorem.word)
    @property = Property.create!(name: Faker::Lorem.word, description: Faker::Lorem.sentence, no_bedrooms: 2,
                                 no_baths: 2, no_beds: 2, area: 100.0, user: @user, category: @category)
  end
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new address and returns the address in JSON format' do
        post :create, params: {
          address: {
            city: 'New York',
            state: 'NY',
            street: 'Main St',
            house_number: '123',
            country: 'USA',
            zip_code: '10001',
            property_id: @property.id
          }
        }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to include('house_number')
        expect(response.body).to include('street')
        expect(response.body).to include('city')
        expect(response.body).to include('state')
        expect(response.body).to include('country')
        expect(response.body).to include('zip_code')
        expect(response.body).to include('property_id')
      end
    end

    context 'with invalid parameters' do
      it 'returns the errors in JSON format' do
        post :create, params: {
          address: {
            house_number: '',
            street: '',
            city: '',
            state: '',
            country: '',
            zip_code: '',
            property_id: ''
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq({
                                                  'house_number' => ["can't be blank"],
                                                  'street' => ["can't be blank"],
                                                  'city' => ["can't be blank"],
                                                  'state' => ["can't be blank"],
                                                  'country' => ["can't be blank"],
                                                  'zip_code' => ["can't be blank"],
                                                  'property' => ['must exist']
                                                })
      end
    end
    describe 'PATCH #update' do
      before do
        @property = Property.create(
          name: 'My Property',
          description: 'This is my property',
          no_bedrooms: 2,
          no_baths: 2,
          no_beds: 3,
          area: 150,
          user: @user,
          category: @category
        )
        @address = Address.create(
          house_number: '123',
          street: 'Main St',
          city: 'New York',
          state: 'NY',
          country: 'USA',
          zip_code: '10001',
          property: @property
        )
      end

      context 'with valid parameters' do
        it 'updates the address and returns the updated address in JSON format' do
          patch :update, params: {
            id: @address.id,
            address: {
              house_number: '456',
              street: 'Elm St',
              city: 'Boston',
              state: 'MA',
              country: 'USA',
              zip_code: '02108'
            }
          }
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('application/json; charset=utf-8')
          expect(JSON.parse(response.body)).to include(
            'id' => @address.id,
            'house_number' => '456',
            'street' => 'Elm St',
            'city' => 'Boston',
            'state' => 'MA',
            'country' => 'USA',
            'zip_code' => '02108',
            'property_id' => @property.id
          )
        end
      end
    end
  end
end
