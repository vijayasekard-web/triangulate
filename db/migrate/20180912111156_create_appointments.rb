class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments, id: :uuid do |t|
      t.references :professional, type: :uuid, index: true, foreign_key: true
      t.references :client, type: :uuid, index: true, foreign_key: true
      t.string :appointment_type
      t.boolean :client_status
      t.boolean :professional_status
      t.jsonb :metadata
      t.integer :rating
      t.decimal :fees
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
    add_index :appointments, [:professional_id, :client_id], :unique => true
  end
end
