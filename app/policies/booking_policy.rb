class BookingPolicy < ApplicationPolicy
  # Only admins can see all bookings
  def index?
    user.admin? || user.role == "user"
  end

  # Users can see their own booking; admins can see all
  def show?
    user.admin? || record.user_id == user.id
  end

  # Users can create bookings for themselves
  def create?
    user.user? || user.admin?
  end

  # Users can update their own booking; admins can update all
  def update?
    user.admin? || record.user_id == user.id
  end

  # Only admins can delete bookings
  def destroy?
    user.admin? || record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
