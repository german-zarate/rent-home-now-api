require 'rails_helper'

RSpec.describe ReservationCriteria, type: :model do
  subject do
    @user = User.create!(name: 'Sambeck', email: 'sambeck@gmail.com', password: 'password',
                         password_confirmation: 'password', role: 'admin', avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
    @category = Category.create!(name: 'House')
    @property = Property.create!(name: 'My Home', description: 'My fabolous home', no_bedrooms: 5, no_baths: 2,
                                 no_beds: 6, area: 120, user_id: @user.id, category_id: @category.id)
    ReservationCriteria.create!(time_period: 'weekly', min_time_period: 2, others_fee: 10.2, max_guest: 5, rate: 110,
                                property_id: @property.id)
  end

  before { subject.save }

  describe 'Testing Reservation criteria validations' do
    it 'Should be invalid without time period' do
      subject.time_period = nil
      expect(subject).to_not be_valid
    end

    it 'Time period should be a string' do
      subject.time_period = 421
      expect(subject).to_not be_valid
    end

    it 'displays an error message if time_period is not a word' do
      subject.time_period = 12_312
      expect(subject).not_to be_valid
      expect(subject.errors[:time_period]).to include('It should be a word, try with daily, weekly or monthly')
    end

    it 'Should be invalid without others fee' do
      subject.others_fee = nil
      expect(subject).to_not be_valid
    end

    it 'Should be invalid with a negative number' do
      subject.others_fee = -5
      expect(subject).to_not be_valid
    end

    it 'Should be invalid if the value is not a number' do
      subject.others_fee = 'hi'
      expect(subject).to_not be_valid
    end

    it 'Should be invalid without rate' do
      subject.rate = nil
      expect(subject).to_not be_valid
    end

    it 'rate should not be equal than 0' do
      subject.rate = 0
      expect(subject).to_not be_valid
    end

    it 'rate should not be a negative number' do
      subject.rate = -2
      expect(subject).to_not be_valid
    end

    it 'rate should be a number' do
      subject.rate = 'john'
      expect(subject).to_not be_valid
    end

    it 'Should be invalid without min_time_period' do
      subject.min_time_period = nil
      expect(subject).to_not be_valid
    end

    it 'min_time_period should not be equal than 0' do
      subject.min_time_period = 0
      expect(subject).to_not be_valid
    end

    it 'min_time_period should not be a negative number' do
      subject.min_time_period = -2
      expect(subject).to_not be_valid
    end

    it 'min_time_period should be a number' do
      subject.min_time_period = 'john'
      expect(subject).to_not be_valid
    end

    it 'Should be invalid without max_guest' do
      subject.max_guest = nil
      expect(subject).to_not be_valid
    end

    it 'Should be invalid with a max_guest negative number' do
      subject.max_guest = -3
      expect(subject).to_not be_valid
    end

    it 'Should be invalid if the max_guest value is not a number' do
      subject.max_guest = 'hi'
      expect(subject).to_not be_valid
    end

    it 'Should be valid with the correct values' do
      expect(subject).to be_valid
    end
  end
end
