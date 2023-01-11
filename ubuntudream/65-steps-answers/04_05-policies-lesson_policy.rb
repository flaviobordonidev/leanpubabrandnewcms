class LessonPolicy < ApplicationPolicy
  def index?
    if @user.present?
      case @user.role
      when 'user'
        true #all records
      when 'author'
        true #all records
      when 'moderator'
        true #all records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end

  def show?
    if @user.present?
      case @user.role
      when 'user'
        true #all records
      when 'author'
        true #all records
      when 'moderator'
        true #all records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end
  
  def create?
    if @user.present?
      case @user.role
      when 'user'
        false #no records
      when 'author'
        false #no records
      when 'moderator'
        false #no records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end
  
  def update?
    if @user.present?
      case @user.role
      when 'user'
        false #no records
      when 'author'
        false #no records
      when 'moderator'
        false #no records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end

  def destroy?
    if @user.present?
      case @user.role
      when 'user'
        false #no records
      when 'author'
        false #no records
      when 'moderator'
        false #no records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
