class CreateMenuDishes < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_dishes do |t|
      t.integer :menu_id
      t.integer :dish_id
      t.string :price
      t.timestamps
    end
  end
end
