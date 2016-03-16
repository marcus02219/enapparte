json.merge! @show.attributes

json.pictures @show.pictures do |picture|
  json.id picture.id
  json.src picture.src
end

if @show.cover_picture
  json.cover_picture_url @show.cover_picture.try(:image).try(:url, :medium)
else
  json.cover_picture_url Picture.new.image.url(:medium)
end
