# frozen_string_literal: true

json.array! @cooking_methods do |method|
  json.id method.id
  json.name method.name
  json.position method.position
  json.is_active method.is_active
  json.restaurant_id method.restaurant&.id
end
