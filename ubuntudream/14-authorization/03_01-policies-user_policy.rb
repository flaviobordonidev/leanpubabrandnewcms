class UserPolicy < ApplicationPolicy
  def index?
    @user.admin?
  end

  def show?
    @user.admin? or @user == @record
  end

  def create?
    @user.admin?
  end

  def update?
    @user.admin? or @user == @record
  end

  def destroy?
    @user.admin?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
