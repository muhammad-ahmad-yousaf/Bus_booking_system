require 'faker'

# === USERS ===
puts "Creating Admin..."
admin = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "Admin User"
  user.phone = "03001234567"
  user.password = "password"
  user.role = 1  # assuming 0=user, 1=admin
end

puts "Creating Users..."
50.times do
  User.create!(
    name: Faker::Name.name,
    phone: Faker::PhoneNumber.cell_phone_in_e164,
    email: Faker::Internet.unique.email,
    password: "password",
    role: 0
  )
end

users = User.where(role: 0).to_a

# === ROUTES ===
puts "Creating Routes..."
20.times do
  Route.create!(
    start_location: Faker::Address.city,
    end_location: Faker::Address.city
  )
end
routes = Route.all

# === BUSES ===
puts "Creating Buses..."
30.times do
  Bus.create!(
    bus_num: Faker::Vehicle.license_plate,
    capacity: rand(30..60),
    bus_type: ["AC", "Non-AC", "Luxury"].sample
  )
end
buses = Bus.all

# === TRIPS ===
puts "Creating Trips..."
200.times do
  route = routes.sample
  bus = buses.sample
  departure = Faker::Time.forward(days: 30, period: :morning)
  arrival = departure + rand(2..10).hours

  Trip.create!(
    bus: bus,
    route: route,
    departure_time: departure,
    arrival_time: arrival,
    avail_seats: bus.capacity,
    fare: rand(500..5000)
  )
end
trips = Trip.all

# === BOOKINGS ===
puts "Creating Bookings..."
500.times do
  trip = trips.sample
  user = users.sample
  seat_num = rand(1..trip.bus.capacity)

  # Avoid duplicate seat bookings for the same trip
  next if Booking.exists?(trip: trip, seat_number: seat_num)

  Booking.create!(
    user: user,
    trip: trip,
    seat_number: seat_num,
    status: %w[pending confirmed cancelled].sample
  )
end