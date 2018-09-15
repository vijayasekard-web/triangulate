class Client < ApplicationRecord
  has_many :credit_cards
  has_many :appointments
end
