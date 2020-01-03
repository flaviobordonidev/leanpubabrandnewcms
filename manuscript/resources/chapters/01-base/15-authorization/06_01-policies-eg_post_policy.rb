class EgPostPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    @user.present?
  end
  
  def create?
    if @user.present?
      @user.author? or @user.moderator? or @user.admin?
    else
      false
    end
  end
  
  def update?
    if @user.present?
      @user.id == @record.user_id or @user.admin?
    else
      false
    end
  end

  def destroy?
    if @user.present?
      @user.id == @record.user_id or @user.moderator? or @user.admin?
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
