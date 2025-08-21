class Route < ApplicationRecord
  has_many :trips
  validates :start_location, presence: true
  validates :end_location, presence: true
  validate :start_and_end_cannot_be_same
  validate :route_cannot_be_duplicate

  private

  def start_and_end_cannot_be_same
    if start_location.present? && end_location.present? && start_location.strip.downcase == end_location.strip.downcase
      errors.add(:end_location, "cannot be the same as start location")
    end
  end

  def route_cannot_be_duplicate
    return if start_location.blank? || end_location.blank?

    existing_route = Route.where(
      "LOWER(TRIM(start_location)) = ? AND LOWER(TRIM(end_location)) = ?",
      start_location.strip.downcase,
      end_location.strip.downcase
    ).where.not(id: id).exists?

    if existing_route
      errors.add(:base, "This route already exists")
    end
  end
end
