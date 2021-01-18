# frozen_string_literal: true

json.extract! dish, :id, :name, :price, :image, :created_at, :updated_at
json.url dish_url(dish, format: :json)
