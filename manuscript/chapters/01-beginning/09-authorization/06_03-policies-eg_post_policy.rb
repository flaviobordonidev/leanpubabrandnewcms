class EgPostPolicy < ApplicationPolicy

  def index?
    if @user.present?
      case @user.role
      when 'user'
        true
      when 'author'
        true
      when 'moderator'
        true
      when 'admin'
        true
      else
        false #se arrivo qui c'è un errore quindi non autorizzo
      end
    else
      true
    end
  end

  def show?
    if @user.present?
      case @user.role
      when 'user'
        true
      when 'author'
        true
      when 'moderator'
        true
      when 'admin'
        true
      else
        false #se arrivo qui c'è un errore quindi non autorizzo
      end
    else
      false
    end
  end
  
  def create?
    if @user.present?
      case @user.role
      when 'user'
        false
      when 'author'
        true
      when 'moderator'
        true
      when 'admin'
        true
      else
        false #se arrivo qui c'è un errore quindi non autorizzo
      end
    else
      false
    end
  end
  
  def update?
    if @user.present?
      case @user.role
      when 'user'
        false
      when 'author'
        @user.id == @record.user_id
      when 'moderator'
        @user.id == @record.user_id
      when 'admin'
        true
      else
        false #se arrivo qui c'è un errore quindi non autorizzo
      end
    else
      false
    end
  end

  def destroy?
    if @user.present?
      case @user.role
      when 'user'
        false
      when 'author'
        @user.id == @record.user_id
      when 'moderator'
        true
      when 'admin'
        true
      else
        false #se arrivo qui c'è un errore quindi non autorizzo
      end
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
