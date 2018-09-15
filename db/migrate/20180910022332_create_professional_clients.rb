class CreateProfessionalClients < ActiveRecord::Migration[5.2]
  def up
    create_table :professional_clients do |t|
      t.uuid :professional_id
      t.uuid :client_id
      t.datetime :first_visit
      t.datetime :last_visit
      t.integer :total_visits
      t.integer :cancelled_visits
      t.boolean :is_blocked_by_client
      t.boolean :is_blocked_by_pro

      t.timestamps
    end
    add_index :professional_clients, :professional_id
    add_index :professional_clients, :client_id
    add_index :professional_clients, [:professional_id, :client_id], :unique => true
  end

  def down
    drop_table :professional_clients
  end
end
