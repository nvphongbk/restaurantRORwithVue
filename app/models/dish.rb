# == Schema Information
#
# Table name: dishes
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Dish < ApplicationRecord
    has_many :images ,dependent: :destroy
    accepts_nested_attributes_for :images, allow_destroy: true
    has_many :category_dishes
    has_many :categories, through: :category_dishes

    validates :name, :price, presence: false

    def category_ids
        categories&.pluck(:id)
    end

    def images_ids
        images&.pluck(:id)
    end

    def images_attributes
        images.map { |i| {id: i.id, url: i.photo.url, uid: i.id, name: i.photo_identifier}}
    end
end
