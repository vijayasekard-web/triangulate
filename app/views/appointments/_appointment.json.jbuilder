json.extract! appointment, :id, :professional_id, :client_id, :appointment_type, :client_status, :professional_status, :metadata, :rating, :fees, :start_at, :end_at, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
