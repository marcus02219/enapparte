json.array!(@shows) do |show|
  json.merge! show.attributes
  json.user_picture_url show.user.picture.image.url(:thumb)
end
