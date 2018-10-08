class ModifyIndexOnSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_index :schedules, [:professional_id, :work_date]
    add_index :schedules, [:professional_id, :work_date]
  end
end
