# frozen_string_literal: true

json.array! @restaurants do |restaurant|
  json.id restaurant.id
  json.name restaurant.name
  json.address restaurant.address
  json.user_id restaurant.user_id
  json.slug restaurant.slug
end
