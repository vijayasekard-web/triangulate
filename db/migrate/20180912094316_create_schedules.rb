class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules, id: :uuid do |t|
      t.references :professional, type: :uuid, index: true, foreign_key: true
      t.date :work_date
      t.jsonb :time_slots

      t.timestamps
    end
    add_index :schedules, [:professional_id, :work_date], :unique => true
  end
end
