class Admin::UserPolicy < ApplicationPolicy
  def edit?
    user.account_type == "Doctor"
  end
end
