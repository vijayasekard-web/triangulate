class ModifyIndexOnAppointments < ActiveRecord::Migration[5.2]
  def change
    remove_index :appointments, [:professional_id, :client_id]
    add_index :appointments, [:professional_id, :client_id], :unique => false
  end
end
