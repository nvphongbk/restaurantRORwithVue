class CreateMainIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :main_ingredients do |t|
      t.string :name
      t.boolean :is_active
      t.integer :position
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
