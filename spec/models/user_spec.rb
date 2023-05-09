require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    User.delete_all
  end

  describe 'validations' do
    it 'is not valid without an email' do
      user = User.create(name: 'Shahadat Hossain', password: 'password', avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')

      expect(user).not_to be_valid
    end

    it 'is not valid without a name' do
      user = User.create(email: 'shahadat3669@gmail.com', password: 'password', avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')

      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create(name: 'Shahadat Hossain', email: 'shahadat3669@gmail.com', password: 'password', avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
      user = User.create(name: 'Shahadat Hossain', email: 'shahadat3669@gmail.com', password: 'password', avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')

      expect(user).not_to be_valid
    end

    it 'is not valid with an invalid email format' do
      user = User.create(name: 'Shahadat Hossain', email: 'shahadat3669', password: 'password', avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')

      expect(user).not_to be_valid
    end

    it 'is not valid without an avatar' do
      user = User.create(name: 'Shahadat Hossain', email: 'shahadat3669@gmail.com', password: 'password', avatar: '')

      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = User.create(name: 'Shahadat Hossain', email: 'shahadat3669@gmail.com', avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')

      expect(user).not_to be_valid
    end

    it "is not valid without a role of 'other'" do
      user = User.create(name: 'Shahadat Hossain', email: 'shahadat3669@gmail.com', password: 'password', role: 'other',
                         avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')

      expect(user).not_to be_valid
    end

    it "is valid with a role of 'user'" do
      user = User.create(name: 'Shahadat Hossain', email: 'shahadat3669@gmail.com', password: 'password', role: 'user',
                         avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')

      expect(user.role).to eq('user')
    end

    it "is valid with a role of 'admin'" do
      user = User.create(name: 'Shahadat Hossain', email: 'shahadat3669@gmail.com', password: 'password', role: 'admin',
                         avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')

      expect(user.role).to eq('admin')
    end

    it 'is valid with valid attributes' do
      user = User.create(name: 'Shahadat Hossain', email: 'shahadat3669@gmail.com', password: 'password',
                         password_confirmation: 'password', role: 'admin',
                         avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')
      expect(user).to be_valid
    end
  end

  describe 'defaults' do
    user = User.create(name: 'Shahadat Hossain', email: 'shahadat3669@gmail.com', password: 'password',
                       password_confirmation: 'password', avatar: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640')

    it "has a default role of 'user'" do
      expect(user.role).to eq('user')
      expect(user).to be_valid
    end
  end
end
