class Property < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :images, dependent: :destroy
  has_one :address, dependent: :destroy
  has_one :reservation_criteria, dependent: :destroy
  has_many :reservation, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :no_bedrooms, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :no_baths, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :no_beds, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :area, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
