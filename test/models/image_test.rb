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
require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
