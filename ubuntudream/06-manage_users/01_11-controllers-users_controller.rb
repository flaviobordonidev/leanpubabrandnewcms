class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  #before_action :set_user, only: [:show, :edit, :update]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /eg_users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :location, :bio, :phone_number, :email, :password, :password_confirmation, :encrypted_password)
    end
end
