class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :address, :created_at, :categories
  # has_many :categories, serializer: CategorySerializer

  def categories
    object.categories.map do |category|
      CategorySerializer.new(category, restaurant: object)
    end
  end
end
