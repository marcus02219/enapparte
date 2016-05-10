json.array!(@shows.includes(:cover_picture, user: [:picture] )) do |show|
  json.merge! show.attributes
  json.commission Show::COMMISSION

  json.user_picture_url show.user.picture.try(:image).try(:url, :thumb)
  if show.cover_picture
    json.cover_picture_url show.cover_picture.try(:image).try(:url, :medium)
  else
    json.cover_picture_url Picture.new.image.url(:medium)
  end
  json.start show.date_at || ""
end
