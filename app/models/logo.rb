# == Schema Information
#
# Table name: logos
#
#  id            :integer          not null, primary key
#  photo         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :integer
#
# Indexes
#
#  index_logos_on_restaurant_id  (restaurant_id)
#
class Logo < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :restaurant, optional: true
end
