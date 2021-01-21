# == Schema Information
#
# Table name: main_ingredients
#
#  id            :integer          not null, primary key
#  is_active     :boolean          default(TRUE)
#  name          :string
#  position      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :integer
#
class MainIngredient < ApplicationRecord
  belongs_to :restaurant
  has_many :dishes
end
