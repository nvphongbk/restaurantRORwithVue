class AddDefaultRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :default_restaurant_id, :integer
    remove_column :dishes, :restaurant_id, :integer
  end
end
