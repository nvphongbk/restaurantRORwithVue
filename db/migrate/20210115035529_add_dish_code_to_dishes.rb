# frozen_string_literal: true

class AddDishCodeToDishes < ActiveRecord::Migration[6.0]
  def change
    add_column :dishes, :dish_code, :string
  end
end
