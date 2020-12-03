# == Schema Information
#
# Table name: category_dishes
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  dish_id     :integer          not null
#
# Indexes
#
#  index_category_dishes_on_category_id  (category_id)
#  index_category_dishes_on_dish_id      (dish_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  dish_id      (dish_id => dishes.id)
#
class CategoryDish < ApplicationRecord
  belongs_to :dish
  belongs_to :category
end
