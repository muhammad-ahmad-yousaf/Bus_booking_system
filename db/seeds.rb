# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data (optional in dev)
# Clear existing data (optional in dev)
Booking.destroy_all
Trip.destroy_all
Route.destroy_all
Bus.destroy_all
User.destroy_all

# Create Users
users = []
5.times do |i|
  users << User.create!(
    name: "User#{i+1}",
    phone: "+923039854#{i+1}",
    email: "user#{i + 1}@example.com",
    password: "password",
    password_confirmation: "password"
  )
end
users << User.create!(
    name: "Ahmad",
    phone: "+9230398549",
    email: "admin@example.com",
    role: 1, # This is my Admin
    password: "password",
    password_confirmation: "password"
  )



# Create Buses
buses = [
  Bus.create!(bus_num: "BUS101", capacity: 40, bus_type: "Luxury"),
  Bus.create!(bus_num: "BUS102", capacity: 35, bus_type: "Standard"),
  Bus.create!(bus_num: "BUS103", capacity: 50, bus_type: "Mini")
]

# Create Routes
routes = [
  Route.create!(start_location: "Karachi", end_location: "Lahore"),
  Route.create!(start_location: "Islamabad", end_location: "Multan"),
  Route.create!(start_location: "Peshawar", end_location: "Quetta")
]

# Create Trips
trips = [
  Trip.create!(
    bus: buses[0],
    route: routes[0],
    departure_time: DateTime.now + 1.day + 8.hours,
    arrival_time: DateTime.now + 1.day + 18.hours,
    avail_seats: 40,
    fare: 2500.0
  ),
  Trip.create!(
    bus: buses[1],
    route: routes[1],
    departure_time: DateTime.now + 2.days + 7.hours,
    arrival_time: DateTime.now + 2.days + 15.hours,
    avail_seats: 35,
    fare: 1800.0
  ),
  Trip.create!(
    bus: buses[2],
    route: routes[2],
    departure_time: DateTime.now + 3.days + 9.hours,
    arrival_time: DateTime.now + 3.days + 19.hours,
    avail_seats: 50,
    fare: 3000.0
  )
]
