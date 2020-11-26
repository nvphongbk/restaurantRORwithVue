class Category < ApplicationRecord
  belongs_to :restaurant
  has_many :categories_dishes
  has_many :dishes, through: :categories_dishes

  validates :name, precence: true
end
