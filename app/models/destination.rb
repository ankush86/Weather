class Destination < ApplicationRecord
  validates :city_name, uniqueness: true
end
