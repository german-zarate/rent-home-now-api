require 'rails_helper'

RSpec.describe Image, type: :model do
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
    @image = Image.new(source: 'https://example.com/image.png', property: @property)
  end

  it 'is valid with a source and a property' do
    expect(@image).to be_valid
  end

  it 'is not valid without a source' do
    image = Image.new(property: @property)
    expect(image).to_not be_valid
  end
  it 'is not valid without a property' do
    image = Image.new(source: 'https://example.com/image.png')
    expect(image).to_not be_valid
  end
end
