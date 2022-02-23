class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    #@user.present? ? @user.admin? : false
    if @user.present?
      @user.admin? or @user == @record
    else
      false
    end
  end

  def create?
    if @user.present?
      @user.admin?
    else
      false
    end
  end

  def update?
    if @user.present?
      @user.admin?
    else
      false
    end
  end

  def destroy?
    if @user.present?
      @user.admin?
    else
      false
    end
  end
  
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
