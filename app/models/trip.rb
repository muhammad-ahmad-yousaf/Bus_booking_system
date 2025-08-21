class Trip < ApplicationRecord

  has_many :bookings, dependent: :destroy
  belongs_to :bus
  belongs_to :route
  validates :departure_time, presence: true
  validate :departure_cannot_be_in_past
  validate :arrival_after_departure

  private

  def departure_cannot_be_in_past
    if departure_time.present? && departure_time < Time.current
      errors.add(:departure_time, "cannot be in the past")
    end
  end

  def arrival_after_departure
    if departure_time.present? && arrival_time.present? && arrival_time <= departure_time
      errors.add(:arrival_time, "must be after the departure time")
    end
  end

end
