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

# Create some users
john = User.create(name: "John Doe", email: "john@example.com", password: "password", role: "user", avatar: "https://randomuser.me/api/portraits/men/1.jpg")
jane = User.create(name: "Jane Doe", email: "jane@example.com", password: "password", role: "admin", avatar: "https://randomuser.me/api/portraits/women/1.jpg")

# Create some properties
cozy_apartment = Property.create(name: "Cozy Apartment", description: "A cozy apartment in the heart of the city", no_bedrooms: 1, no_baths: 1, no_beds: 2, area: 50.0, user: john, category: apartment)
luxury_villa = Property.create(name: "Luxury Villa", description: "A luxurious villa with a pool and ocean views", no_bedrooms: 3, no_baths: 3, no_beds: 6, area: 200.0, user: jane, category: villa)
spacious_house = Property.create(name: "Spacious House", description: "A spacious house with a large backyard", no_bedrooms: 4, no_baths: 2, no_beds: 5, area: 150.0, user: john, category: house)

# Create some addresses
cozy_apartment_address = Address.create(house_number: "123", street: "Main St", city: "New York", state: "NY", country: "USA", zip_code: "10001", property: cozy_apartment)
luxury_villa_address = Address.create(house_number: "456", street: "Broadway", city: "Los Angeles", state: "CA", country: "USA", zip_code: "90001", property: luxury_villa)
spacious_house_address = Address.create(house_number: "789", street: "Maple St", city: "Chicago", state: "IL", country: "USA", zip_code: "60601", property: spacious_house)

# Create some images
cozy_apartment_image = Image.create(source: "https://unsplash.com/photos/bWUOlkf1mhw", property: cozy_apartment)
luxury_villa_image = Image.create(source: "https://unsplash.com/photos/3E2qD3x9sYM", property: luxury_villa)
spacious_house_image = Image.create(source: "https://unsplash.com/photos/CwkiN6_qpDI", property: spacious_house)

# Create some reservation criteria
cozy_apartment_reservation_criteria = ReservationCriteria.create(time_period: "week", others_fee: 50.0, min_time_period: 3, max_guest: 4, rate: 100.0, property: cozy_apartment)
luxury_villa_reservation_criteria = ReservationCriteria.create(time_period: "month", others_fee: 100.0, min_time_period: 7, max_guest: 6, rate: 200.0, property: luxury_villa)
spacious_house_reservation_criteria = ReservationCriteria.create(time_period: "weeks", others_fee: 75.0, min_time_period:7, max_guest: 7, rate: 300.0, property: spacious_house)
