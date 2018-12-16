class UsersController < ApplicationController

  #https://www.youtube.com/watch?v=qruGD_8ry7k [48:50] (Devise authentication)
  # before_action authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /example_posts
  # GET /example_posts.json
  def index
    @users = User.all
    authorize @users
  end

  # GET /users/1
  # GET /users/1.json
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

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    authorize @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    current_user_temp = current_user
    respond_to do |format|
      if @user.update(user_params)
        #format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.html do
          # ci siamo tagliati il ramo! Logghiamoci di nuovo automaticamente bypassando le validazioni
          sign_in(@user, bypass: true) if @user == current_user_temp
          redirect_to @user, notice: 'User was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy unless @user == current_user
    respond_to do |format|
      format.html do 
        redirect_to users_url, notice: 'User was successfully destroyed.' unless @user == current_user
        redirect_to users_url, notice: 'Non posso eliminare utente loggato.' if @user == current_user
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      authorize @user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end
end
