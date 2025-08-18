class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  enum :booking_status, [ :pending , :confirmed, :cancelled ]
  validates :seat_number, presence: true
  validate :seat_not_already_booked


  private

  def seat_not_already_booked
    if Booking.exists?(trip_id: trip_id, seat_number: seat_number)
      errors.add(:seat_number, "is already booked for this trip")
    end
  end
end
