class Destination < ApplicationRecord
  validates :city_name, uniqueness: true
  has_many :temperature_notes
end
