class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :guests, presence: true

  validate :check_guest_capacity

  before_save :set_reservation_price

  private

  def set_reservation_price
    num_nights = end_date - start_date
    self.price = (property.reservation_criteria.rate * num_nights) + property.reservation_criteria.others_fee
  end

  def check_guest_capacity
    property = Property.find_by(id: property_id)
    return unless property && guests > property.reservation_criteria.max_guest

    errors.add(:max_guest, 'Guests number exceeded the maximum allowed')
  end
end
