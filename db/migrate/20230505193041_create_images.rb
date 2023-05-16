class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :source
      t.references :property, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
