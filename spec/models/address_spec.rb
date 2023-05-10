require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:category) { Category.create(name: 'Apartment') }
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password', role: 'user', avatar: 'https://randomuser.me/api/portraits/men/1.jpg') }
  let(:property) do
    Property.create(name: 'Cozy Apartment', description: 'A cozy apartment in the heart of the city', no_bedrooms: 1,
                    no_baths: 1, no_beds: 2, area: 50.0, user: :user, category: :category)
  end
  let(:valid_attributes) do
    {
      house_number: '123',
      street: 'Main St.',
      city: 'New York',
      state: 'NY',
      country: 'USA',
      zip_code: '10001',
      property:
    }
  end

  before do
    @address = Address.new(valid_attributes)
  end

  it 'is valid with valid attributes' do
    expect(@address).to be_valid
  end

  it 'is not valid without a house number' do
    @address.house_number = nil
    expect(@address).to_not be_valid
  end

  it 'is not valid without a street' do
    @address.street = nil
    expect(@address).to_not be_valid
  end

  it 'is not valid without a city' do
    @address.city = nil
    expect(@address).to_not be_valid
  end

  it 'is not valid without a state' do
    @address.state = nil
    expect(@address).to_not be_valid
  end

  it 'is not valid without a country' do
    @address.country = nil
    expect(@address).to_not be_valid
  end

  it 'is not valid without a zip code' do
    @address.zip_code = nil
    expect(@address).to_not be_valid
  end

  it 'is not valid without a property' do
    @address.property = nil
    expect(@address).to_not be_valid
  end
end
