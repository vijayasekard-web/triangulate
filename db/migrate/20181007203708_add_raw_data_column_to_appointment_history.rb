class AddRawDataColumnToAppointmentHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :appointment_histories, :raw_data, :jsonb
  end
end
