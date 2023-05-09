class User < ApplicationRecord
  has_many :property

  validates :avatar, presence: true
  validates :name, presence: { message: "Name can't be blank" },
                   length: { maximum: 50, message: 'Name is too long (maximum is %<count>s characters)' }
  validates :email, presence: { message: "Email can't be blank" },
                    length: { maximum: 255, message: 'Email is too long (maximum is %<count>s characters)' },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Email format is invalid' },
                    uniqueness: { case_sensitive: false, message: 'Email has already been taken' }
  validates :role, inclusion: { in: %w[user admin], message: "Role must be 'user' or 'admin'" }

  has_secure_password
  validates :password, presence: { message: "Password can't be blank" }

  validate :password_confirmation_matches_password

  def password_confirmation_matches_password
    return unless password_confirmation != password

    errors.add(:password_confirmation, "Password confirmation doesn't match password")
  end
end
