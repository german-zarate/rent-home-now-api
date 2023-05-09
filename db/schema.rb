# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_05_193345) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "house_number"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip_code"
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_addresses_on_property_id"
  end

  create_table "categories", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "source"
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_images_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "no_bedrooms"
    t.integer "no_baths"
    t.integer "no_beds"
    t.float "area"
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_properties_on_category_id"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "reservation_criteria", force: :cascade do |t|
    t.text "time_period"
    t.float "others_fee"
    t.integer "min_time_period"
    t.integer "max_guest"
    t.float "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "property_id", null: false
    t.index ["property_id"], name: "index_reservation_criteria_on_property_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", null: false
    t.string "role", default: "user", null: false
    t.string "avatar", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "properties"
  add_foreign_key "images", "properties"
  add_foreign_key "properties", "categories"
  add_foreign_key "properties", "users"
  add_foreign_key "reservation_criteria", "properties"
end
