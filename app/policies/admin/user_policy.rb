class Admin::UserPolicy < ApplicationPolicy
  def index?
    valid_user?
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
