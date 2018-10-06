class AddDefaultValueToProfessionalIsActive < ActiveRecord::Migration[5.2]
  def up
    change_column :professionals, :is_active, :boolean, default: false
  end

  def down
    change_column :professionals, :is_active, :boolean, default: nil
  end
end
