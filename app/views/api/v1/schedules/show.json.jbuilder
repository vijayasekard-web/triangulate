if @schedule.is_a?(ActiveRecord::Relation)
  json.array! @schedule, :id, :professional_id, :work_date, :created_at,
      :updated_at, :start_at, :end_at, :matching_appointment_id, :description
else
  json.extract! @schedule, :id, :professional_id, :work_date, :created_at,
      :updated_at, :start_at, :end_at, :matching_appointment_id, :description
end

