json.extract! trip, :id, :bus_id, :route_id, :departure_time, :arrival_time, :avail_seats, :fare, :created_at, :updated_at
json.url trip_url(trip, format: :json)
