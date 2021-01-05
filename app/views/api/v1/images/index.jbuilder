json.array! @images do |image|
  json.id image.id
  json.url image.photo.url
  json.name image.photo.identifier
end
