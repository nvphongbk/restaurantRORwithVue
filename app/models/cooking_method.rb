# == Schema Information
#
# Table name: cooking_methods
#
#  id            :integer          not null, primary key
#  is_active     :boolean          default(TRUE)
#  name          :string
#  position      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :integer
#
# Indexes
#
#  index_cooking_methods_on_restaurant_id  (restaurant_id)
#
class CookingMethod < ApplicationRecord
  belongs_to :restaurant
  has_many :dishes
end
