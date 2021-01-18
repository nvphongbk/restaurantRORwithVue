# frozen_string_literal: true

class AddSlugToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :slug, :string
    add_index :restaurants, :slug, unique: true
  end
end
