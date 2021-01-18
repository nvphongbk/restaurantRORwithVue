# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  image_name :string
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dish_id    :integer
#
# Indexes
#
#  index_images_on_dish_id  (dish_id)
#
class ImageSerializer < ActiveModel::Serializer
  attributes :id, :url, :image_name
end
