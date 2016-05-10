json.array!(@bookings.includes(:show, user: [:picture])) do |booking|
  json.merge! booking.attributes
  json.user_picture_url booking.user.picture.image.url(:thumb)
  json.user_full_name booking.user.full_name
  json.show_title booking.show.title
  json.show_url url_for(booking.show)
  json.start booking.date.to_date
end
