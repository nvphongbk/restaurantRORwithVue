class CreateCookingMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :cooking_methods do |t|
      t.string :name
      t.integer :position
      t.boolean :is_active
      t.integer :restaurant_id, index: true

      t.timestamps
    end
  end
end
