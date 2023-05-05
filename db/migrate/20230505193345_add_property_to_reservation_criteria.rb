class AddPropertyToReservationCriteria < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservation_criteria, :property, null: false, foreign_key: true
  end
end
