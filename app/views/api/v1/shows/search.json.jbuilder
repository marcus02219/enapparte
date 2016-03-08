json.array!(@shows) do |show|
  json.merge! show.attributes
  json.user_picture_url show.try(:user).try(:picture).try(:image).try(:url, :thumb)
  json.cover_picture do
    picture = show.cover_picture
    if picture
      json.id picture.id
      json.url_thumb picture.image.url(:thumb)
      json.url_medium picture.image.url(:medium)
    end
  end

  json.pictures show.pictures do |picture|
    json.id picture.id
    json.url_thumb picture.image.url(:thumb)
    json.url_medium picture.image.url(:medium)
  end

  json.user do
    json.merge! show.user.try(:attributes)
    json.full_name show.user.try(:full_name)
  end
end
