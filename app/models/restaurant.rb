class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :categories

  # validates :name, precence: true
end
