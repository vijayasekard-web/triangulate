if @schedule.is_a?(ActiveRecord::Relation)
  json.array! @schedule, :id, :professional_id, :work_date, :created_at,
      :updated_at, :start_at, :end_at, :description
else
  json.extract! @schedule, :id, :professional_id, :work_date, :created_at,
      :updated_at, :start_at, :end_at, :description
end

