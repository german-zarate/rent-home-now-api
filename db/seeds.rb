# remove all existing records
# Property.delete_all
# Address.delete_all
# Category.delete_all
# ReservationCriteria.delete_all
# Image.delete_all
User.delete_all


# resets the primary key sequence
ActiveRecord::Base.connection.reset_pk_sequence!('users')
# ActiveRecord::Base.connection.reset_pk_sequence!('properties')
# ActiveRecord::Base.connection.reset_pk_sequence!('addresses')
# ActiveRecord::Base.connection.reset_pk_sequence!('categories')
# ActiveRecord::Base.connection.reset_pk_sequence!('reservation_criteria')
# ActiveRecord::Base.connection.reset_pk_sequence!('images')


# Create first user as admin
User.create!(
  name: "Shahadat Hossain",
  email: "shahadat3669@gmail.com",
  role: 'admin',
  avatar: Faker::LoremFlickr.image,
  password: "password",
  password_confirmation: 'password'
)

# Create 20 regular users
20.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    avatar: Faker::LoremFlickr.image,
    password: "password",
    password_confirmation: 'password'
  )
end

# # Create categories
# apartment = Category.create(name: "Apartment")
# house = Category.create(name: "House")
# villa = Category.create(name: "Villa")
# condo = Category.create(name: "Condo")

# # Create properties
# categories = [apartment, house, villa, condo]
# User.where(role: 'user').each do |user|
#   rand(1..5).times do
#     property = Property.create(
#       name: Faker::Address.community,
#       description: Faker::Lorem.paragraph,
#       no_bedrooms: rand(1..5),
#       no_baths: rand(1..3),
#       no_beds: rand(1..10),
#       area: rand(50.0..300.0),
#       user: user,
#       category: categories.sample
#     )

#     # Create address
#     Address.create(
#       house_number: Faker::Address.building_number,
#       street: Faker::Address.street_name,
#       city: Faker::Address.city,
#       state: Faker::Address.state,
#       country: Faker::Address.country,
#       zip_code: Faker::Address.zip_code,
#       property: property
#     )

#     # Create reservation criteria
#     ReservationCriteria.create(
#       time_period: ["daily", "weekly", "monthly"].sample,
#       others_fee: rand(10..100),
#       min_time_period: rand(1..7),
#       max_guest: rand(1..10),
#       rate: rand(50..500),
#       property: property
#     )

#     # Create images
#     rand(1..3).times do
#       Image.create(
#         source: Faker::LoremFlickr.image(size: "512x512", search_terms: ['interior', 'exterior']),
#         property: property
#       )
#     end
#   end
# end

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
cozy_apartment = Property.create(name: "Cozy Apartment", description: "A cozy apartment in the heart of the city", no_bedrooms: 1, no_baths: 1, no_beds: 2, area: 50.0, user: john, category: 2)
luxury_villa = Property.create(name: "Luxury Villa", description: "A luxurious villa with a pool and ocean views", no_bedrooms: 3, no_baths: 3, no_beds: 6, area: 200.0, user: jane, category: 1)
spacious_house = Property.create(name: "Spacious House", description: "A spacious house with a large backyard", no_bedrooms: 4, no_baths: 2, no_beds: 5, area: 150.0, user: john, category: 3)

# Create some addresses
cozy_apartment_address = Address.create(house_number: "123", street: "Main St", city: "New York", state: "NY", country: "USA", zip_code: "10001", property: cozy_apartment)
luxury_villa_address = Address.create(house_number: "456", street: "Broadway", city: "Los Angeles", state: "CA", country: "USA", zip_code: "90001", property: luxury_villa)
spacious_house_address = Address.create(house_number: "789", street: "Maple St", city: "Chicago", state: "IL", country: "USA", zip_code: "60601", property: spacious_house)

# Create some images
cozy_apartment_image = Image.create(source: "https://unsplash.com/photos/bWUOlkf1mhw", property: cozy_apartment)
luxury_villa_image = Image.create(source: "https://unsplash.com/photos/3E2qD3x9sYM", property: luxury_villa)
spacious_house_image = Image.create(source: "https://unsplash.com/photos/CwkiN6_qpDI", property: spacious_house)

# Create some reservation criteria
cozy_apartment_reservation_criteria = ReservationCriteria.create(time_period: "1 week", others_fee: 50.0, min_time_period: 3, max_guest: 4, rate: 100.0, property: cozy_apartment)
luxury_villa_reservation_criteria = ReservationCriteria.create(time_period: "1 month", others_fee: 100.0, min_time_period: 7, max_guest: 6, rate: 200.0, property: luxury_villa)
spacious_house_reservation_criteria = ReservationCriteria.create(time_period: "2 weeks", others_fee: 75.0, min_time_period:7, max_guest: 7, rate: 300.0, property: spacious_house)


puts "Seeds summary"
tp [  
  { name: 'Admin', count: User.where(role: 'admin').count },
  { name: 'Users', count: User.where(role: 'user').count },
  { name: 'Properties', count: Property.count },
  { name: 'Addresses', count: Address.count },
  { name: 'Categories', count: Category.count },
  { name: 'Reservation Criteria', count: ReservationCriteria.count },
  { name: 'Images', count: Image.count }]
