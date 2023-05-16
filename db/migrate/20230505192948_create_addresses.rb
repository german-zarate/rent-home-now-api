class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :house_number
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code
      t.references :property, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
