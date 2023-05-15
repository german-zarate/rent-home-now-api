require 'rails_helper'

RSpec.describe Reservation, type: :model do
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

  describe 'validations' do
    it 'is valid with valid attributes' do
      reservation = Reservation.new(
        start_date: Date.today,
        end_date: Date.today + 2,
        guests: @criteria.max_guest - 1,
        user: @user1,
        property: @property1
      )

      expect(reservation).to be_valid
    end

    it 'is not valid without a start date' do
      reservation = Reservation.new(start_date: nil)

      expect(reservation).not_to be_valid
      expect(reservation.errors[:start_date]).to include("can't be blank")
    end

    it 'is not valid without an end date' do
      reservation = Reservation.new(end_date: nil)

      expect(reservation).not_to be_valid
      expect(reservation.errors[:end_date]).to include("can't be blank")
    end

    it 'is not valid if end date is before start date' do
      reservation = Reservation.new(start_date: Date.today, end_date: Date.today - 1)

      expect(reservation).not_to be_valid
      expect(reservation.errors[:end_date]).to include('End date must be after Start date')
    end

    it 'is not valid if start date is before today' do
      reservation = Reservation.new(start_date: Date.today - 1, end_date: Date.today + 2)

      expect(reservation).not_to be_valid
      expect(reservation.errors[:start_date]).to include('Start date must be greater than Today')
    end

    it 'is not valid if end date is same as start date' do
      reservation = Reservation.new(start_date: Date.today, end_date: Date.today)

      expect(reservation).not_to be_valid
      expect(reservation.errors[:end_date]).to include('End date must be after Start date')
    end

    it 'is not valid if guests exceed property maximum capacity' do
      reservation = Reservation.new(start_date: Date.today, end_date: Date.today + 2,
                                    guests: @criteria.max_guest + 1, property: @property1)

      expect(reservation).not_to be_valid
      expect(reservation.errors[:max_guest]).to include('Guests number exceeded the maximum allowed')
    end

    context 'property available on reservation dates' do
      before do
        @reservation = Reservation.new(
          start_date: @overlapping_reservation.start_date,
          end_date: @overlapping_reservation.end_date,
          guests: 3,
          user: @user1,
          property: @property1
        )
      end

      it 'is not valid if start_date is same for a existing reservation of the property' do
        expect(@reservation).not_to be_valid
        expect(@reservation.errors[:base]).to include('Property is already reserved for the selected dates')
      end

      it 'is not valid if end_date is same for a existing reservation of the property' do
        @reservation.start_date = @overlapping_reservation.start_date - 1

        expect(@reservation).not_to be_valid
        expect(@reservation.errors[:base]).to include('Property is already reserved for the selected dates')
      end

      it 'is not valid if start_date and end_date is same for a existing reservation of the property' do
        @reservation.start_date = @overlapping_reservation.start_date
        @reservation.end_date = @overlapping_reservation.end_date

        expect(@reservation).not_to be_valid
        expect(@reservation.errors[:base]).to include('Property is already reserved for the selected dates')
      end

      it 'is not valid if start_date and end_date is inside of a existing reservation for the property' do
        @reservation.start_date = @overlapping_reservation.start_date + 1
        @reservation.end_date = @overlapping_reservation.end_date - 1

        expect(@reservation).not_to be_valid
        expect(@reservation.errors[:base]).to include('Property is already reserved for the selected dates')
      end
    end
  end

  describe 'before_save callback' do
    it 'sets the reservation price based on property attributes' do
      reservation = Reservation.new(
        start_date: Date.today,
        end_date: Date.today + 2,
        guests: @criteria.max_guest - 1,
        user: @user1,
        property: @property1
      )
      reservation.save
      calculated_price = ((reservation.end_date - reservation.start_date) * @criteria.rate) + @criteria.others_fee

      expect(reservation.price).to eq(calculated_price)
    end
  end
end
