class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :category_ids, :images_attributes, :image_ids
end
