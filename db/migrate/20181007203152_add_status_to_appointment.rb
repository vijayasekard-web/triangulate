class AddStatusToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :status, :integer, null: false, default: 0
  end
end
