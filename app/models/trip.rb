class Trip < ApplicationRecord

  has_many :bookings, dependent: :destroy
  belongs_to :bus
  belongs_to :route

  validates :departure_time, presence: true
  validates :arrival_time, presence: true
  validates :fare, numericality: { only_integer: true }
  validates :avail_seats, numericality: { only_integer: true }

  validate :departure_cannot_be_in_past
  validate :arrival_after_departure

  scope :upcoming, -> { where("departure_time >= ?", Time.current) }

  def self.search(params)
    trips = includes(:bus, :route).upcoming

    if params[:date].present?
      date = Date.parse(params[:date]) rescue nil
      trips = trips.where(departure_time: date.beginning_of_day..date.end_of_day) if date
    end

    if params[:start_location].present? && params[:end_location].present?
      trips = trips.joins(:route).where(routes: { start_location: params[:start_location], end_location: params[:end_location] })
    end

    trips
  end

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
