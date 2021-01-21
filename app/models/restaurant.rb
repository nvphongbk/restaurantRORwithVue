# frozen_string_literal: true

# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  address    :string
#  name       :string
#  pass_wifi  :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_restaurants_on_slug     (slug) UNIQUE
#  index_restaurants_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Restaurant < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :user
  has_many :categories, dependent: :destroy
  has_many :cooking_methods, dependent: :destroy
  has_many :main_ingredients, dependent: :destroy

  has_many :dishes, through: :categories, dependent: :destroy
end
