json.merge! @show.attributes

json.pictures @show.pictures do |picture|
  json.id picture.id
  json.src picture.src
end
