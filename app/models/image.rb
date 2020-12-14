# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dish_id    :integer
#
# Indexes
#
#  index_images_on_dish_id  (dish_id)
#
class Image < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :dish, optional: true

  def url
    photo.url
  end
end
