class MedicationPolicy < ApplicationPolicy
  def index?
    valid_user?
  end

  def new?
    mid_level_authorized_user?
  end

  def create?
    mid_level_authorized_user?
  end

  def destroy?
    mid_level_authorized_user?
  end
end