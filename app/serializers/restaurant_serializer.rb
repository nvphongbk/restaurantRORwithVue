# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  address    :string
#  name       :string
#  pass_wifi  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_restaurants_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :pass_wifi, :user_id, :address, :created_at, :categories
  # has_many :categories, serializer: CategorySerializer

  def categories
    object.categories.map do |category|
      CategorySerializer.new(category, restaurant: object)
    end
  end
end
