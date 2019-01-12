  class PostPolicy < ApplicationPolicy
  
    def index?
      true
    end
  
    def show?
      #true
      if @user.present?
        #@user.has_role? :admin or @user.has_role? :moderator, @record or @user.has_role? :author, @record
        #@user.has_role? :admin
        #@user.has_role? :moderator, Post
        @user.has_role? :author, @record
      else
        false
      end
    end
    
    def create?
      #@user.present? ? @user.has_role?(:admin) : false
      @user.present?
    end
    
    def update?
      if @user.present?
        @user.has_role? :admin or @user.has_role? :author, @record
        #@user == @record.user # con relazione uno-a-molti
        #@user == @record.user or @record.published
      else
        false
      end
    end
  
    def destroy?
      if @user.present?
        #@user.has_role? :admin or @user.has_role? :moderator, Post or @user.has_role? :author, @record
         @user.has_role? :admin or @user.has_role? :moderator, @record or @user.has_role? :author, @record
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
