json.array! @users do |user|
  json.id user.id
  json.firstname user.firstname
  json.surname user.surname
  json.full_name user.full_name
  json.art_id user.art_id
  json.availabilities user.availabilities do |availability|
    json.available_at availability.available_at
  end
end
