if @appointment.is_a?(ActiveRecord::Relation)
  json.array! @appointment, :id, :professional_id, :client_id, :address_id, :appointment_type,
      :status, :rating, :profession_type_id, :fees, :start_at, :end_at
else
  json.extract! @appointment, :id, :professional_id, :client_id, :address_id, :appointment_type,
      :status, :rating, :profession_type_id, :fees, :start_at, :end_at
end
