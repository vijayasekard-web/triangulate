class RemoveMetaDataFromAppointmentHistory < ActiveRecord::Migration[5.2]
  def change
    remove_column :appointment_histories, :metadata
  end
end
