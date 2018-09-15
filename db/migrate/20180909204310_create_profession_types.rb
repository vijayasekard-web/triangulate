class CreateProfessionTypes < ActiveRecord::Migration[5.2]
  def up
    create_table :profession_types, id: :uuid do |t|
      t.string :name
      t.boolean :license_required
      t.string :state
      t.string :country

      t.timestamps
    end
  end

  def down
    drop_table :profession_types
  end
end
