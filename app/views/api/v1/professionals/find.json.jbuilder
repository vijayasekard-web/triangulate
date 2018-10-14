json.extract! @professional, :id, :profession_type_id, :user_id, :license_id,
  :postal_code, :radius, :created_at, :updated_at
json.address @address, :id, :user_id, :address_1, :address_2,
  :city, :province, :postal_code, :favorite, :created_at, :updated_at
