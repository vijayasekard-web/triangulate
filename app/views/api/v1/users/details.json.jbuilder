if @professional.present?
  json.professional @professional, :id, :profession_type_id, :user_id, :license_id,
    :postal_code, :radius, :created_at, :updated_at
end
if @client.present?
  json.client @client, :id, :client_type, :user_id, :facility,
    :health_card, :created_at, :updated_at
  json.address @user.addresses, :id, :user_id, :address_1, :address_2,
    :city, :province, :postal_code, :favorite, :created_at, :updated_at
end
