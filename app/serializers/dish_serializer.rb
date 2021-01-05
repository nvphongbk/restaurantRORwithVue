# == Schema Information
#
# Table name: dishes
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :category_ids, :images_attributes, :image_ids
end
