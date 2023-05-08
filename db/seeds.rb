# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
categories = [
  "House",
  "Apartment",
  "Room",
  "Duplex",
  "Loft",
  "Flat",
  "Studio",
  "Cottage",
  "Mansion"
]

categories.each do |category|
  Category.create!(name: category)
end

@user = User.create!(name: "John", email: "john@example.com", avatar:"asdawdwad", password: "null123456")

Property.create!(name: "myhouse", description: "my fabolous house description", no_bedrooms: 2, no_baths: 2, no_beds: 4, area: 12.4, user_id: @user.id, category_id:1)
