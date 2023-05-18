require 'rails_helper'
require 'faker'

RSpec.describe Api::V1::PropertiesController, type: :controller do
  before do
    User.delete_all
    @user1 = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'password',
                          password_confirmation: 'password', avatar: Faker::LoremFlickr.image)
    @user2 = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'password',
                          password_confirmation: 'password', avatar: Faker::LoremFlickr.image)

    @category = Category.create!(name: Faker::Lorem.word)
    @category2 = Category.create!(name: Faker::Lorem.word)

    @property1 = Property.create!(name: Faker::Lorem.word, description: Faker::Lorem.sentence, no_bedrooms: 2,
                                  no_baths: 2, no_beds: 2, area: 100.0, user: @user1, category: @category)
    @property2 = Property.create!(name: Faker::Lorem.word, description: Faker::Lorem.sentence, no_bedrooms: 3,
                                  no_baths: 2, no_beds: 3, area: 150.0, user: @user2, category: @category2)
    @reservation_criteria = ReservationCriteria.create!(
      time_period: Faker::Lorem.word,
      others_fee: 100,
      rate: 10,
      min_time_period: 3,
      max_guest: 10,
      property: @property1
    )
  end

  describe 'GET #index' do
    before do
      get :index
    end
    it 'returns a list of properties(that have reservation criteria)' do
      # Check that the response has a successful status code
      expect(response).to have_http_status(:ok)

      # Check that the response includes the created property's name
      expect(response.body).to include(@property1.name)
      expect(response.body).not_to include(@property2.name)
    end
    it 'includes the correct information for each property' do
      # Check that the response includes the correct information for each property
      expect(response.body).to include(@property1.description)
      expect(response.body).to include(@property1.area.to_s)
      expect(response.body).to include(@user1.id.to_s)
      expect(response.body).to include(@category.id.to_s)
    end
    it "it doesn't include list of property if they hainformation for each property" do
      expect(response.body).not_to include(@property2.description)
      expect(response.body).not_to include(@property2.area.to_s)
      expect(response.body).not_to include(@user2.id.to_s)
    end
  end

  describe 'GET #show' do
    it 'returns the correct information for a single property' do
      # Make a GET request to the show action for the first property
      get :show, params: { id: @property1.id }

      # Check that the response includes the correct information for the property
      expect(response.body).to include(@property1.name)
      expect(response.body).to include(@property1.description)
      expect(response.body).to include(@property1.area.to_s)
      expect(response.body).to include(@property1.user.name)
      expect(response.body).to include(@property1.category.name)

      expect(response.body).not_to include(@property2.name)
      expect(response.body).not_to include(@property2.description)
      expect(response.body).not_to include(@property2.area.to_s)
      expect(response.body).not_to include(@property2.user.name)
      # expect(response.body).not_to include(@property2.category.name)
    end
    it 'returns a 404 error if the property is not found' do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
    end
  end
  describe 'POST #create' do
    before do
      sign_in(@user1)
    end
    context 'with valid parameters' do
      it 'creates a new property and returns the property in JSON format' do
        post :create, params: {
          property: {
            name: Faker::Lorem.word,
            description: Faker::Lorem.sentence,
            no_bedrooms: 2,
            no_baths: 2,
            no_beds: 2,
            area: 100.0,
            user_id: @user1.id,
            category_id: @category.id
          }
        }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to include('name')
        expect(response.body).to include('description')
        expect(response.body).to include('no_bedrooms')
        expect(response.body).to include('no_baths')
        expect(response.body).to include('no_beds')
        expect(response.body).to include('area')
        expect(response.body).to include('user')
        expect(response.body).to include('category')
      end
    end

    context 'with invalid parameters' do
      it 'returns the errors in JSON format' do
        post :create, params: {
          property: {
            name: '',
            description: '',
            no_bedrooms: 0,
            no_baths: 0,
            no_beds: 0,
            area: 0.0,
            category_id: ''
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"],
                                                  'description' => ["can't be blank"],
                                                  'no_bedrooms' => ['must be greater than or equal to 1'],
                                                  'no_baths' => ['must be greater than or equal to 1'],
                                                  'no_beds' => ['must be greater than or equal to 1'],
                                                  'area' => ['must be greater than or equal to 1'],
                                                  'category' => ['must exist']
                                                })
      end
    end
  end
  describe 'PUT #update' do
    before do
      sign_in(@user1)
    end
    context 'with valid parameters' do
      it 'updates the property and returns the updated property in JSON format' do
        put :update, params: { id: @property1.id, property: { name: 'Updated Name' } }
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to include('Updated Name')
      end
    end

    context 'with invalid parameters' do
      it 'returns the errors in JSON format' do
        put :update, params: { id: @property1.id, property: {
          name: '',
          description: '',
          no_bedrooms: 0,
          no_baths: 0,
          no_beds: 0,
          area: 0.0,
          category_id: ''
        } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => ["can't be blank"],
                                                  'description' => ["can't be blank"],
                                                  'no_bedrooms' => ['must be greater than or equal to 1'],
                                                  'no_baths' => ['must be greater than or equal to 1'],
                                                  'no_beds' => ['must be greater than or equal to 1'],
                                                  'area' => ['must be greater than or equal to 1'],
                                                  'category' => ['must exist']
                                                })
      end
    end
  end
  describe 'DELETE #destroy' do
    before do
      sign_in(@user1)
    end
    context 'when the property exists' do
      it 'deletes the property and returns a success response' do
        expect do
          delete :destroy, params: { id: @property1.id }
        end.to change(Property, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the property does not exist' do
      it 'returns a not found response' do
        delete :destroy, params: { id: 1 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
