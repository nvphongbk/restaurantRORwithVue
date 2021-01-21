class AddColumnToDish < ActiveRecord::Migration[6.0]
  def change
    add_column :dishes, :quantity, :float, default: 0
    add_column :dishes, :unit, :string
    add_column :dishes, :cooking_method_id, :integer, index: true
    add_column :dishes, :main_ingredient_id, :integer, index: true
  end
end
