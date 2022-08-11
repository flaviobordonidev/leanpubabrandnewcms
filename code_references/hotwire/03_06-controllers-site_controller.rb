class SiteController < ApplicationController
  def first; end

  def second; end

  def third 
    redirect_to site_second_path
  end
end
