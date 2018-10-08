class RemoveAppointmentTypeFromAppointmentHistory < ActiveRecord::Migration[5.2]
  def change
    remove_column :appointment_histories, :appointment_type
  end
end
