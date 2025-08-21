json.extract! booking, :id, :user_id, :trip_id, :seat_number, :status, :created_at, :updated_at
json.url booking_url(booking, format: :json)
