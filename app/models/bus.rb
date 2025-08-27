class Bus < ApplicationRecord
  has_many :trips
  validates :capacity, presence: true
  validates :bus_num, presence: true
  validates :bus_type, presence: true
end
