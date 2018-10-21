class Client < ApplicationRecord
  belongs_to :user
  has_many :credit_cards
  has_many :appointments
end
