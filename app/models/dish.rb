# frozen_string_literal: true

# == Schema Information
#
# Table name: dishes
#
#  id                 :integer          not null, primary key
#  dish_code          :string
#  is_active          :boolean          default(TRUE)
#  name               :string
#  position           :integer
#  quantity           :float            default(0.0)
#  unit               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  cooking_method_id  :integer
#  main_ingredient_id :integer
#
class Dish < ApplicationRecord
  before_validation :format_character, on: %i[create update]
  IMPORT_COLUMNS = { name: 'name', image: 'image', category: 'category',
                     cooking_method: 'cooking_method', main_ingredient: 'main_ingredient', unit: 'unit', quantity:
                       'quantity', price: 'price', menu: 'menu' }.freeze
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :category_dishes, dependent: :destroy
  has_many :categories, through: :category_dishes
  belongs_to :main_ingredient, optional: true
  belongs_to :cooking_method, optional: true
  has_many :menu_dishes, dependent: :destroy
  accepts_nested_attributes_for :menu_dishes, allow_destroy: true
  has_many :menus, through: :menu_dishes

  validates :name, presence: false

  def category_ids
    self.categories&.pluck(:id)
  end

  def images_ids
    images&.pluck(:id)
  end

  def images_attributes
    images.map { |i| { id: i.id, url: i.photo.url, uid: i.id, name: i.photo_identifier } }
  end

  def format_character
    self.name = name.strip&.downcase
  end
end
