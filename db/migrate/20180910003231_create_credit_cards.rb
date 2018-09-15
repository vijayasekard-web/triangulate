class CreateCreditCards < ActiveRecord::Migration[5.2]
  def up
    create_table :credit_cards, id: :uuid do |t|
      t.references :client, type: :uuid, index: true, foreign_key: true
      t.string :name_on_card
      t.string :card_type
      t.string :card_number
      t.date :expiry
      t.integer :ccv

      t.timestamps
    end
  end

  def down
    drop_table :credit_cards
  end
end
