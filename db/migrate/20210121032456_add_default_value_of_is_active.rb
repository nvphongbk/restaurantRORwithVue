class AddDefaultValueOfIsActive < ActiveRecord::Migration[6.0]
  def change
    change_column :cooking_methods, :is_active, :boolean, default: true
    change_column :main_ingredients, :is_active, :boolean, default: true
  end
end
