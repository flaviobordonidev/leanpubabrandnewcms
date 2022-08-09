class SiteController < ApplicationController
  def first; end

  def second; end

  def third 
    @name, @email, @age = params[:person].values_at(:name, :email, :age)
  end
end
