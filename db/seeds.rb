require 'httparty'

# remove all existing records
Reservation.delete_all
Address.delete_all
ReservationCriteria.delete_all
Image.delete_all
Property.delete_all
Category.delete_all
User.delete_all

# resets the primary key sequence
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('properties')
ActiveRecord::Base.connection.reset_pk_sequence!('addresses')
ActiveRecord::Base.connection.reset_pk_sequence!('categories')
ActiveRecord::Base.connection.reset_pk_sequence!('reservation_criteria')
ActiveRecord::Base.connection.reset_pk_sequence!('images')
ActiveRecord::Base.connection.reset_pk_sequence!('reservations')

images = [
  'https://http2.mlstatic.com/D_NQ_NP_984527-MLM69100018396_042023-O.webp',
  'https://http2.mlstatic.com/D_NQ_NP_801166-MLM54794174821_042023-O.webp',
  'https://http2.mlstatic.com/D_NQ_NP_807878-MLM54082439202_022023-O.webp',
  'https://http2.mlstatic.com/D_NQ_NP_650325-MLM68903332277_042023-O.webp',
  'https://http2.mlstatic.com/D_NQ_NP_929936-MLM53951617983_022023-O.webp',
  'https://www.bienesonline.com/mexico/photos/lujosa-casa-en-cabo-san-lucas-4-rec-45-banos-con-vista-al-mar-sm-14848810571.jpg',
  'https://http2.mlstatic.com/D_NQ_NP_862819-MLM69289573960_052023-O.webp',
  'https://http2.mlstatic.com/D_NQ_NP_907492-MLM54849435987_042023-O.jpg',
  'https://img.vivanuncios.com.mx/api/v1/mx-pt10-ads/images/2e/2ecd2c47-e110-4b2c-bade-7bf9d2f4b72b?rule=s-I72.auto',
  'https://assets.easybroker.com/property_images/2722153/42958222/EB-JL2153.jpg?version=1643073075',
  'https://http2.mlstatic.com/D_NQ_NP_985410-MLM53679704387_022023-O.webp',
  'https://img10.naventcdn.com/avisos/18/00/66/61/38/53/720x532/364409872.jpg',
  'https://http2.mlstatic.com/D_NQ_NP_601837-MLM54365635396_032023-O.jpg',
  'https://img10.naventcdn.com/avisos/18/00/66/54/10/71/720x532/363105139.jpg',
  'https://http2.mlstatic.com/D_NQ_NP_752775-MLM54696226898_032023-O.jpg',
  'https://img10.naventcdn.com/avisos/18/00/66/73/46/34/720x532/366567690.jpg',
  'https://img10.naventcdn.com/avisos/18/00/66/66/98/45/720x532/365401461.jpg',
  'https://img10.naventcdn.com/avisos/18/00/65/73/07/76/720x532/347784228.jpg',
  'https://http2.mlstatic.com/D_NQ_NP_921210-MLM69081601061_042023-O.webp',
  'https://http2.mlstatic.com/D_NQ_NP_781247-MLM69126075073_042023-O.webp',
]


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

# Create categories
apartment = Category.create(name: "Apartment")
house = Category.create(name: "House")
villa = Category.create(name: "Villa")
condo = Category.create(name: "Condo")

# Create properties
categories = [apartment, house, villa, condo]
User.where(role: 'user').each do |user|
  rand(1..5).times do
    property = Property.create(
      name: Faker::Address.community,
      description: Faker::Lorem.paragraph,
      no_bedrooms: rand(1..5),
      no_baths: rand(1..3),
      no_beds: rand(1..10),
      area: rand(50.0..300.0),
      user: user,
      category: categories.sample
    )

    # Create address
    Address.create(
      house_number: Faker::Address.building_number,
      street: Faker::Address.street_name,
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country,
      zip_code: Faker::Address.zip_code,
      property: property
    )

    # Create reservation criteria
    ReservationCriteria.create(
      time_period: ["daily", "weekly", "monthly"].sample,
      others_fee: rand(10..100),
      min_time_period: rand(1..7),
      max_guest: rand(1..10),
      rate: rand(50..500),
      property: property
    )

    # Create images
    rand(1..3).times do
      Image.create(
        source: images.sample,
        property: property
      )
    end
  end
end

# Create reservations
User.where(role: 'user').each do |user|
  Property.where.not(user_id: user.id).each do |property|
    next unless rand(0..1) == 1

    start_date = Faker::Date.between(from: Date.today, to: Date.today + 90)
    end_date = start_date + rand(1..7).days

    Reservation.create(
      start_date: start_date,
      end_date: end_date,
      guests: rand(1..property.reservation_criteria.max_guest),
      user: user,
      property: property
    )
  end
end


 puts "Seeds summary"
 tp [
   { name: 'Admin', count: User.where(role: 'admin').count },
   { name: 'Users', count: User.where(role: 'user').count },
   { name: 'Properties', count: Property.count },
   { name: 'Addresses', count: Address.count },
   { name: 'Categories', count: Category.count },
   { name: 'Reservation Criteria', count: ReservationCriteria.count },
   { name: 'Images', count: Image.count },
   { name: 'Reservation', count: Reservation.count }]
