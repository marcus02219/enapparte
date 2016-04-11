json.merge! @user.attributes
json.gender @user.gender

json.picture do
  json.id @user.picture.try(:id)
  json.src @user.picture.try(:src)
end

json.addresses @user.addresses do |address|
  json.merge! address.attributes
  json.full_address address.full_address
end

json.reviews @user.reviews do |review|
  json.merge! review.attributes
  json.userImageUrl review.try(:booking).try(:user).try(:picture).try(:image).try(:url, :thumb)
  json.bookingUserFullName review.try(:booking).try(:user).try(:full_name)
  json.bookingUserRating review.try(:booking).try(:user).try(:rating)
end

json.sent_reviews @user.sent_reviews do |review|
  json.merge! review.attributes
  json.userImageUrl review.try(:booking).try(:user).try(:picture).try(:image).try(:url, :thumb)
  json.bookingUserFullName review.try(:booking).try(:user).try(:full_name)
  json.bookingUserRating review.try(:booking).try(:user).try(:rating)
end

json.payment_methods @user.payment_methods do |payment_method|
  json.merge! payment_method.attributes
end
