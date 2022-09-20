class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_action :set_user, only: %i[ show edit update destroy ]
 
  # GET /users or /users.json
  def index
    #@users = User.all
    @pagy, @users = pagy(User.all.order(created_at: "DESC"), items: 3)
    authorize @users
  end

  # GET /users/1 or /eg_users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    authorize @user
  end
  
  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    authorize @user

    respond_to do |format|
      if @user.save
        #format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.html { redirect_to user_url(@user), notice: t(".notice") } # notice: "User was successfully created."
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        #format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.html { redirect_to user_url(@user), notice: t(".notice") } # notice: "User was successfully updated."
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy unless @user == current_user
    respond_to do |format|
      format.html do
        #redirect_to users_url, notice: "User was successfully destroyed." unless @user == current_user
        #redirect_to users_url, notice: "The logged in user cannot be destroyed." if @user == current_user
        redirect_to users_url, notice: t(".notice") unless @user == current_user # notice: "User was successfully destroyed."
        redirect_to users_url, notice: t(".notice_logged_in") if @user == current_user #  notice: "The logged in user cannot be destroyed."
      end
      format.json { head :no_content }
    end
  end

  def delete_image_attachment
    @image_to_delete = ActiveStorage::Attachment.find(params[:id])
    @image_to_delete.purge
    redirect_back(fallback_location: request.referer)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      authorize @user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      if params[:user][:password].blank?
        params.require(:user).permit(:username, :email, :language, :role, :profile_image, :first_name, :last_name, :location, :bio, :phone_number)
      else
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :language, :role, :profile_image, :first_name, :last_name, :location, :bio, :phone_number)
      end
    end
end