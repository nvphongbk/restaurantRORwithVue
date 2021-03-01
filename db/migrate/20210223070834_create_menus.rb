class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.boolean :is_active
      t.integer :restaurant_id, index: true
      t.timestamps
    end
  end
end
