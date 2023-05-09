class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :name,               null: false
      t.string :role,               null: false, default: "user"
      t.string :avatar,             null: false
      t.string :password_digest

      t.timestamps
    end
  end
end
