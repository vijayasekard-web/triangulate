class Professional < ApplicationRecord
  belongs_to :user
  belongs_to :profession_type
  has_many :schedules
  has_many :appointments
end
