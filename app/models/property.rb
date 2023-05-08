class Property < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :images
  has_one :address, required: true, dependent: :destroy
  has_one :reservation_criteria, required: true, dependent: :destroy
  accepts_nested_attributes_for :address, :category, :reservation_criteria

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :no_bedrooms, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :no_baths, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :no_beds, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :area, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates_associated :address, :reservation_criteria
end
