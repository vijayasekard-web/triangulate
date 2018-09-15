class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses, id: :uuid do |t|
      t.references :user, type: :uuid, index: true, foreign_key: true
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :province
      t.string :country
      t.string :postal_code

      t.timestamps
    end
  end
end
