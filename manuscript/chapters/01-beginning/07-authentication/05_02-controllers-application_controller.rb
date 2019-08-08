class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource_or_scope)
    current_user
    #users_path #goes to users/index
  end

end