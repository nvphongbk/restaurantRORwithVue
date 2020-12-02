# == Schema Information
#
# Table name: dishes
#
#  id         :integer          not null, primary key
#  image      :string
#  name       :string
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Dish < ApplicationRecord
    has_many :category_dishes
    has_many :categories, through: :category_dishes

    validates :name, :price, presence: true
end
