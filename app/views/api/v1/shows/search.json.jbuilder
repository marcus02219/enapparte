json.array!(@shows) do |show|
  json.merge! show.attributes
  json.user_picture_url show.user.picture.try(:image).try(:url, :thumb)
  json.cover_picture_url show.cover_picture.try(:image).try(:url, :medium)
end
