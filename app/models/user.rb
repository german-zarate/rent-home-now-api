class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, confirmation: true
  validates :name, presence: true
  validates :avatar, presence: true
  validates :role, inclusion: { in: %w[user admin] }
end
