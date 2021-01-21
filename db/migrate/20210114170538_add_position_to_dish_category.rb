# frozen_string_literal: true

class AddPositionToDishCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :position, :integer
    add_column :dishes, :position, :integer
    add_column :dishes, :is_active, :boolean, default: true
    add_column :categories, :is_active, :boolean, default: true
  end
end
