require 'rails_helper'

RSpec.describe Property, type: :model do
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
  end

  it 'is valid with valid attributes' do
    expect(@property).to be_valid
  end

  it 'is not valid without a name' do
    @property.name = nil
    expect(@property).to_not be_valid
  end

  it 'is not valid without a description' do
    @property.description = nil
    expect(@property).to_not be_valid
  end

  it 'is not valid without a user' do
    @property.user = nil
    expect(@property).to_not be_valid
  end

  it 'is not valid without a category' do
    @property.category = nil
    expect(@property).to_not be_valid
  end
end
