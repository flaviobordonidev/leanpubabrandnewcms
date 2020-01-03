class EgUsersController < ApplicationController
  before_action :set_eg_user, only: [:show, :edit, :update, :destroy]

  # GET /eg_users
  # GET /eg_users.json
  def index
    @eg_users = EgUser.all
  end

  # GET /eg_users/1
  # GET /eg_users/1.json
  def show
  end

  # GET /eg_users/new
  def new
    @eg_user = EgUser.new
  end

  # GET /eg_users/1/edit
  def edit
  end

  # POST /eg_users
  # POST /eg_users.json
  def create
    @eg_user = EgUser.new(eg_user_params)

    respond_to do |format|
      if @eg_user.save
        format.html { redirect_to @eg_user, notice: 'Eg user was successfully created.' }
        format.json { render :show, status: :created, location: @eg_user }
      else
        format.html { render :new }
        format.json { render json: @eg_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eg_users/1
  # PATCH/PUT /eg_users/1.json
  def update
    respond_to do |format|
      if @eg_user.update(eg_user_params)
        format.html { redirect_to @eg_user, notice: 'Eg user was successfully updated.' }
        format.json { render :show, status: :ok, location: @eg_user }
      else
        format.html { render :edit }
        format.json { render json: @eg_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eg_users/1
  # DELETE /eg_users/1.json
  def destroy
    @eg_user.destroy
    respond_to do |format|
      format.html { redirect_to eg_users_url, notice: 'Eg user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eg_user
      @eg_user = EgUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def eg_user_params
      params.require(:eg_user).permit(:name, :email, :encrypted_password)
    end
end
