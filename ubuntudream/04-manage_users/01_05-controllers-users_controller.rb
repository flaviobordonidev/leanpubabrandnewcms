class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]
  #before_action :set_user, only: [:show]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /eg_users/1 or /eg_users/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
