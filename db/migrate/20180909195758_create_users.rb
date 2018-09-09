class CreateUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :dob
      t.string :gender

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
