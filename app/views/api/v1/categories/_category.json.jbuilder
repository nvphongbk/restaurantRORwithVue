# frozen_string_literal: true

json.extract! category, :id, :name, :restaurant_id, :created_at, :updated_at
json.url category_url(category, format: :json)
