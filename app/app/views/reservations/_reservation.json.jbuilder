json.extract! reservation, :id, :start_at, :end_at, :amount, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
