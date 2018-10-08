class RemoveClientAndProfessionalStatusToAppointment < ActiveRecord::Migration[5.2]
  def change
    remove_column :appointments, :client_status
    remove_column :appointments, :professional_status
  end
end
