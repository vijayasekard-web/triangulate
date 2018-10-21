json.extract! @client, :id, :client_type, :user_id, :facility,
       :health_card, :created_at, :updated_at
json.address @client.user.addresses, :id, :user_id, :address_1, :address_2,
  :city, :province, :postal_code, :favorite, :created_at, :updated_at
