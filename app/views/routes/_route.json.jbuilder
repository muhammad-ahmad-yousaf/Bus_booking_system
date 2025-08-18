json.extract! route, :id, :start_location, :end_location, :created_at, :updated_at
json.url route_url(route, format: :json)
