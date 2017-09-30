json.extract! rental, :id, :car_id, :customer_id, :start_time, :end_time, :created_at, :updated_at
json.url rental_url(rental, format: :json)
