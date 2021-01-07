class AddPassWifiToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :pass_wifi, :string
  end
end
