json.restaurants do
  json.array! @restaurants do |item|
    json.id item.id
    json.name item.name
    json.address item.address
    json.phone item.phone
    json.pass_wifi item.pass_wifi
  end
end
json.current_restaurant @current_restaurant, :id, :name, :address, :phone, :pass_wifi
