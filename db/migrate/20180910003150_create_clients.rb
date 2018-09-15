class CreateClients < ActiveRecord::Migration[5.2]
  def up
    create_table :clients, id: :uuid do |t|
      t.string :client_type
      t.string :facility
      t.string :health_card

      t.timestamps
    end
  end

  def down
    drop_table :clients
  end
end
