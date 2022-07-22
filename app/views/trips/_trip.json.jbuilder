json.extract! trip, :id, :user_id, :name, :trip_day, :created_at, :updated_at
json.url trip_url(trip, format: :json)
