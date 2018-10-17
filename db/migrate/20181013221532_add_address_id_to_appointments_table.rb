class AddAddressIdToAppointmentsTable < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointments, :address, type: :uuid, index: true, foreign_key: false
  end
end
