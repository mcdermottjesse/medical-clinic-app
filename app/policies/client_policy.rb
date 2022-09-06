class ClientPolicy < ApplicationPolicy
  def index?
    valid_user?
  end

  def show?
    authorized_user?
  end

  def new?
    authorized_user?
  end

  def create?
    authorized_user?
  end

  def edit?
    authorized_user?
  end

  def update?
    authorized_user?
  end

  def destroy?
    authorized_user?
  end
end