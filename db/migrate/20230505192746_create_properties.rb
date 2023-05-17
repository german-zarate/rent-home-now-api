class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.integer :no_bedrooms
      t.integer :no_baths
      t.integer :no_beds
      t.float :area
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :category, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
