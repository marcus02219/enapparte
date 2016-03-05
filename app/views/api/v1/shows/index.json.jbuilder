json.array!(@shows) do |show|
  json.merge! show.attributes
  json.user_picture_url show.user.picture.try(:image).try(:url, :thumb)
  if show.cover_picture
    json.cover_picture_url show.cover_picture.try(:image).try(:url, :medium)
  else
    json.cover_picture_url Picture.new.image.url(:medium)
  end
end
