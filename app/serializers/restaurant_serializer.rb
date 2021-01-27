# frozen_string_literal: true

# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  address    :string
#  name       :string
#  pass_wifi  :string
#  phone      :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_restaurants_on_slug     (slug) UNIQUE
#  index_restaurants_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :pass_wifi, :user_id, :address, :phone, :created_at, :categories, :slug
  # has_many :categories, serializer: CategorySerializer

  def categories
    object.categories.map do |category|
      CategorySerializer.new(category, restaurant: object)
    end
  end
end
