json.merge! @show.attributes
json.user_picture_url @show.try(:user).try(:picture).try(:image).try(:url, :thumb)
json.commission Show::COMMISSION

json.pictures @show.pictures do |picture|
  json.id picture.id
  json.src picture.src
end

json.cover_picture do
  json.id @show.cover_picture.try(:id)
  json.src @show.cover_picture.try(:src)
end

json.user do
  json.merge! @show.user.try(:attributes)
  json.full_name @show.user.try(:full_name)
end
