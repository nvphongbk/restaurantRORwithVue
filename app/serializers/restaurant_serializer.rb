class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :address, :created_at
end
