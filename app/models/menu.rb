# == Schema Information
#
# Table name: menus
#
#  id            :integer          not null, primary key
#  is_active     :boolean
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :integer
#
# Indexes
#
#  index_menus_on_restaurant_id  (restaurant_id)
#
class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :menu_dishes, dependent: :destroy
  has_many :dishes, through: :menu_dishes
end
