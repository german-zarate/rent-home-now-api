require 'rails_helper'

RSpec.describe Category, type: :model do
  subject do
    @category = Category.create!(name: 'Mansion')
  end

  before { subject.save }

  describe 'Testing Category validations' do
    it 'Should be invalid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Should be valid with the correct values' do
      expect(subject).to be_valid
    end
  end
end
