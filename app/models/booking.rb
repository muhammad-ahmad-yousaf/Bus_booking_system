class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  enum :status, [ :pending, :confirmed, :cancelled ]

  validates :seat_number, presence: true
  validate :seat_not_already_booked, if: -> { user.present? && !user.admin? }


  private

  def seat_not_already_booked
    if Booking.where(trip_id: trip_id, seat_number: seat_number).where.not(id: id).exists?
      errors.add(:seat_number, "is already taken")
    end
  end
end
