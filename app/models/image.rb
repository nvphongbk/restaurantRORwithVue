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
class Image < ApplicationRecord
  after_create :save_image_name
  mount_uploader :photo, PhotoUploader
  belongs_to :dish, optional: true

  def url
    photo.url
  end

  def save_image_name
    update_attribute(:image_name, photo.identifier)
  end
end
