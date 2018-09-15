class CreateAppointmentHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_histories, id: :uuid do |t|
      t.references :appointment, type: :uuid, index: true, foreign_key: true
      t.string :appointment_status
      t.string :appointment_type
      t.jsonb :metadata

      t.timestamps
    end
  end
end
