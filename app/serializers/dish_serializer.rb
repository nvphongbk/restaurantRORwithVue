# frozen_string_literal: true

# == Schema Information
#
# Table name: dishes
#
#  id                 :integer          not null, primary key
#  dish_code          :string
#  is_active          :boolean          default(TRUE)
#  name               :string
#  position           :integer
#  quantity           :float            default(0.0)
#  unit               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  cooking_method_id  :integer
#  main_ingredient_id :integer
#
class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :category_ids, :images_attributes,
             :image_ids, :position, :is_active, :dish_code
  belongs_to :categories, serializer: CategorySerializer
end
