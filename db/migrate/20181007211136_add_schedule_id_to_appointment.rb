class AddScheduleIdToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :matching_schedule_id, :uuid
  end
end
