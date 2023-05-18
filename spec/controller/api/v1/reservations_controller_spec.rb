require 'rails_helper'
require 'faker'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  before do
    User.delete_all
    Property.delete_all
    ReservationCriteria.delete_all
    Reservation.delete_all

    @user1 = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'password',
                          password_confirmation: 'password', avatar: Faker::LoremFlickr.image)
    @category1 = Category.create!(name: Faker::Lorem.word)
    @property1 = Property.create!(name: Faker::Lorem.word, description: Faker::Lorem.sentence, no_bedrooms: 2,
                                  no_baths: 2, no_beds: 2, area: 100.0, user: @user1, category: @category1)
    @criteria = ReservationCriteria.create!(time_period: 'weekly', others_fee: 100, rate: 10, min_time_period: 3,
                                            max_guest: 10, property: @property1)
    @overlapping_reservation = Reservation.create!(start_date: Date.today + 11, end_date: Date.today + 15, guests: 5,
                                                   user: @user1, property: @property1)
  end

  describe 'POST #create' do
    context 'when user is authenticated with valid parameters' do
      before do
        sign_in(@user1)
      end

      let(:valid_params) do
        {
          reservation: {
            start_date: '2023-05-20',
            end_date: '2023-05-25',
            guests: 2,
            property_id: @property1.id
          }
        }
      end

      it 'creates a new reservation' do
        expect do
          post :create, params: valid_params
        end.to change(Reservation, :count).by(1)
      end

      it 'returns a success response with the created reservation' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)

        reservation = Reservation.last
        expect(response.body).to eq(reservation.to_json)
      end
    end

    context 'when user is authenticated with invalid parameters' do
      before do
        sign_in(@user1)
      end

      let(:invalid_params) do
        {
          reservation: {
            start_date: '2023-05-18',
            end_date: '2023-05-15',
            guests: -1,
            property_id: nil
          }
        }
      end

      it 'does not create a new reservation' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Reservation, :count)
      end

      it 'returns an unprocessable_entity response with the reservation errors' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)

        errors = JSON.parse(response.body)
        expect(errors.keys).to contain_exactly('property', 'end_date')
      end
    end

    context 'when user is not authenticated' do
      it 'returns an unauthorized response' do
        post :create, params: { reservation: {} }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
