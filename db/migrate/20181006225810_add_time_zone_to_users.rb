class AddTimeZoneToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :time_zone, :string, null: false, default: "UTC"
  end
end
