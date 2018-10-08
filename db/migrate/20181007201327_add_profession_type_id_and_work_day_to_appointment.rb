class AddProfessionTypeIdAndWorkDayToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointments, :profession_type, type: :uuid, index: true, foreign_key: true
    add_column :appointments, :work_date, :date
  end
end
