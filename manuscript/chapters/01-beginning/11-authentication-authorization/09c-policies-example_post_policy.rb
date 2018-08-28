class ExamplePostPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    #@user.present? ? @user.has_role?(:admin) : false
    if @user.present?
      @user.has_role? :admin
    else
      false
    end
  end
  
  def create?
    if @user.present?
      @user.has_role? :admin
    else
      false
    end
  end
  
  def update?
    if @user.present?
      @user.has_role? :admin
    else
      false
    end
  end

  def destroy?
    if @user.present?
      @user.has_role? :admin
    else
      false
    end
  end
  
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
