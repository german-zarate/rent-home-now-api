require 'rails_helper'
RSpec.describe Address, type: :model do
  let(:category) { Category.create(name: 'Apartment') }
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password', role: 'user', avatar: 'https://randomuser.me/api/portraits/men/1.jpg') }

  before do
    @property = Property.new(
      name: 'Cozy Apartment',
      description: 'A cozy apartment in the heart of the city',
      no_bedrooms: 1,
      no_baths: 1,
      no_beds: 2,
      area: 50.0,
      user:,
      category:
    )
    @address = Address.new(
      city: 'New York',
      state: 'NY',
      street: 'Main St',
      house_number: '123',
      country: 'USA',
      zip_code: '10001',
      property: @property
    )
  end
  context 'when all attributes are present' do
    it 'is valid' do
      expect(@address).to be_valid
    end
  end

  context 'when the street is not present' do
    it 'is invalid' do
      @address.street = nil
      expect(@address).to_not be_valid
    end
  end
  context 'when the zip code is not present' do
    it 'is invalid' do
      @address.zip_code = nil
      expect(@address).to_not be_valid
    end
  end

  context 'when the country is not present' do
    it 'is invalid' do
      @address.country = nil
      expect(@address).to_not be_valid
    end
  end

  context 'when the property is not present' do
    it 'is invalid' do
      @address.property = nil
      expect(@address).to_not be_valid
    end
  end
end
