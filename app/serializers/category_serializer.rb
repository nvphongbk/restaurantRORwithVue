# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  name          :string
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
class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :dishes, serializer: DishSerializer

end
