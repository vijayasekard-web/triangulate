json.extract! client, :id, :client_type, :facility, :health_card, :created_at, :updated_at
json.url client_url(client, format: :json)
