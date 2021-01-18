# frozen_string_literal: true

# == Schema Information
#
# Table name: dishes
#
#  id         :integer          not null, primary key
#  dish_code  :string
#  is_active  :boolean          default(TRUE)
#  name       :string
#  position   :integer
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :category_ids, :images_attributes,
             :image_ids, :position, :is_active, :dish_code
  belongs_to :categories, serializer: CategorySerializer
end
