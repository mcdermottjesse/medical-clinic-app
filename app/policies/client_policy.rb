class ClientPolicy < ApplicationPolicy
  def index?
    valid_user?
  end

  def show?
    valid_user?
  end

  def new?
    mid_level_authorized_user?
  end

  def create?
    mid_level_authorized_user?
  end

  def edit?
    mid_level_authorized_user?
  end

  def update?
    mid_level_authorized_user?
  end

  def destroy?
    authorized_user?
  end
end