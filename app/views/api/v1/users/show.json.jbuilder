json.extract! @user, :id, :first_name, :last_name, :email, :dob, :gender, :time_zone, :created_at, :updated_at
json.addresses @user.addresses do |address|
  json.id address.id
  json.user_id address.user_id
  json.address_1 address.address_1
  json.address_2 address.address_2
  json.city address.city
  json.province address.province
  json.postal_code address.postal_code
  json.favorite address.favorite
end
