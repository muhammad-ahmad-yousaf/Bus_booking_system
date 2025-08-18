class Trip < ApplicationRecord

  has_many :bookings, dependent: :destroy
  belongs_to :bus
  belongs_to :route

end
