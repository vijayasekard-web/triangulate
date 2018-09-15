class CreateProfessionals < ActiveRecord::Migration[5.2]
  def up
    create_table :professionals, id: :uuid do |t|
      t.references :profession_type, type: :uuid, index: true, foreign_key: true
      t.references :user, type: :uuid, index: true, foreign_key: true
      t.string :license_id
      t.boolean :is_licensed
      t.boolean :is_active
      t.string :postal_code
      t.integer :radius

      t.timestamps
    end
  end

  def down
    drop_table :professionals
  end
end
