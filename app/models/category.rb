# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  is_active     :boolean          default(TRUE)
#  name          :string
#  position      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :integer          not null
#
# Indexes
#
#  index_categories_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  restaurant_id  (restaurant_id => restaurants.id)
#
class Category < ApplicationRecord
  default_scope -> { order('categories.position IS NULL, categories.position ASC, created_at DESC') }

  belongs_to :restaurant
  has_many :category_dishes, dependent: :destroy
  has_many :dishes, through: :category_dishes
end
