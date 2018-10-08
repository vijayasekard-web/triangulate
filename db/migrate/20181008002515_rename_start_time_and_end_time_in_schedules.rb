class RenameStartTimeAndEndTimeInSchedules < ActiveRecord::Migration[5.2]
  def up
    rename_column :schedules, :start_time, :start_at
    rename_column :schedules, :end_time, :end_at
  end

  def down
    rename_column :schedules, :start_at, :start_time
    rename_column :schedules, :end_at, :end_time
  end
end
