class AddReferenceRestaurantToDish < ActiveRecord::Migration[6.0]
  def change
    add_reference :dishes, :restaurant, index: true
  end
end
