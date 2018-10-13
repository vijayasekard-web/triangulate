class AddFavouriteToAddressesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :favorite, :string, null: true, default: nil
  end
end
