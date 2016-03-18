json.merge! @user.attributes

json.picture do
  json.id @user.picture.try(:id)
  json.src @user.picture.try(:src)
end

json.addresses @user.addresses do |address|
  json.merge! address.attributes
  json.full_address address.full_address
end

