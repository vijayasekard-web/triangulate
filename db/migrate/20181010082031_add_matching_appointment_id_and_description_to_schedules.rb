class AddMatchingAppointmentIdAndDescriptionToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :matching_appointment_id, :uuid
    add_column :schedules, :description, :string
  end
end
