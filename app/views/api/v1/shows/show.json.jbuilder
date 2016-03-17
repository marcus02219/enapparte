json.merge! @show.attributes

json.pictures @show.pictures do |picture|
  json.id picture.id
  json.src picture.src
end

json.cover_picture do
  json.id @show.cover_picture.try(:id)
  json.src @show.cover_picture.try(:src)
end
