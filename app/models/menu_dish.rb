# == Schema Information
#
# Table name: menu_dishes
#
#  id         :integer          not null, primary key
#  price      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dish_id    :integer
#  menu_id    :integer
#
class MenuDish < ApplicationRecord
  belongs_to :menu
  belongs_to :dish
end
