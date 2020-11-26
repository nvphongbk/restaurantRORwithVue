class Dish < ApplicationRecord
    has_many :categories_dishes
    has_many :categories, through: :categories_dishes

    validates :name, :price, presence: true
end
