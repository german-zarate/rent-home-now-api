class CreateReservationCriteria < ActiveRecord::Migration[7.0]
  def change
    create_table :reservation_criteria do |t|
      t.text :time_period
      t.float :others_fee
      t.integer :min_time_period
      t.integer :max_guest
      t.float :rate

      t.timestamps
    end
  end
end
