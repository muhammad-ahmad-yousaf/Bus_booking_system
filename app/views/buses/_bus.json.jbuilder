json.extract! bus, :id, :bus_num, :capacity, :bus_type, :created_at, :updated_at
json.url bus_url(bus, format: :json)
