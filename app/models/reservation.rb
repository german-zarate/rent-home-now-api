class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :guests, presence: true

  before_save :set_reservation_price

  private

  def set_reservation_price
    num_nights = end_date - start_date
    self.price = (property.reservation_criteria.rate * num_nights) + property.reservation_criteria.others_fee
  end
end
