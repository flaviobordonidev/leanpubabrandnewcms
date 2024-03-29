class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /eg_users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if current_user.present? and current_user == @user
      raise "Current_user #{current_user.email} vuole modificare se stesso! (utente #{@user.email})"
      #qui mettiamo il codice con la modifica di saltare la validazione
    elsif current_user.present? and current_user != @user
      raise "Current_user #{current_user.email} vuole modificare utente #{@user.email}"
      #qui lasciamo il codice così com'era
    else
      raise "NON SEI LOGGATO"
      #qui non dovremmo poter arrivare perché la protezione di devise è attiva
      #comunque reinstradiamo su homepage perché è bene non lasciare "raise" in produzione
    end

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

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy unless @user == current_user

    respond_to do |format|
      format.html do 
        redirect_to users_url, notice: "User was successfully destroyed." unless @user == current_user
        redirect_to users_url, notice: "The logged in user cannot be destroyed." if @user == current_user
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      if params[:user][:password].blank?
        params.require(:user).permit(:name, :email)
      else
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
end
