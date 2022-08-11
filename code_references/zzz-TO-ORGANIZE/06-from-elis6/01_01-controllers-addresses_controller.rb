class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
    @address.addressable_id = params[:last_front_id]
    @address.addressable_type = params[:last_front_controller].singularize.classify
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to url_for(view_context.h_params_path(path: "/#{params[:last_front_controller]}/#{params[:last_front_id]}", related: params[:last_front_related], page: params[:last_front_page], search: params[:last_front_search])), notice: 'Contact was successfully created..' }
        #format.html { redirect_to @address, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        #format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.html do
          manage_favorite # private action
          redirect_to url_for(view_context.h_params_path(path: "/#{params[:last_front_controller]}/#{params[:last_front_id]}", related: params[:last_front_related], page: params[:last_front_page], search: params[:last_front_search])), notice: 'Address was successfully updated..' 
        end
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    manage_favorite_destroy # private action
    @address.destroy
    respond_to do |format|
      format.html { redirect_to url_for(view_context.h_params_path(path: "/#{params[:last_front_controller]}/#{params[:last_front_id]}", related: params[:last_front_related], page: params[:last_front_page], search: params[:last_front_search])), notice: 'Address was successfully destroyed..' }
      #format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:addressable_id, :addressable_type, :title, :full_address, :latitude, :longitude, :address_tag, :favorite_id, :favorite_cb)
    end

    def manage_favorite
      #raise "->#{@address.favorite_cb}" # questo prende il valore dal database
      #raise "->#{params[:address][:favorite_cb]}" # questo prende il valore dalla view
      if params[:address][:favorite_cb] == "0"  # if combo-box-favorite is OFF
        if @address.favorite_id.blank?
          #raise "don't do anything"
        else
          #raise "delete favorite"
          Favorite.find(@address.favorite_id).destroy
          @address.update(favorite_id: nil)
        end
      else  # if combo-box-favorite is ON
        if @address.favorite_id.blank?
          #raise "crea nuovo favorite"
          # devo capire di quale entità è l'indirizzo e questo me lo dice il polimorfico addressable.
          f = @address.addressable.favorites.new(copy_normal: "#{@address.title} - #{@address.address_tag}", copy_bold: "#{@address.full_address}", copy_table: "addresses", copy_table_id: @address.id)
          f.save
          @address.update(favorite_id: f.id)
        else
          #raise "aggiorna favorite esistente"
          f = Favorite.find(@address.favorite_id)
          f.update(copy_normal: "#{@address.title} - #{@address.address_tag}", copy_bold: "#{@address.full_address}", copy_table: "addresses", copy_table_id: @address.id)
          f.save
        end
      end
    end

    def manage_favorite_destroy
      # se il record @address ha un favorito lo elimino prima di eliminare il record.
      Favorite.find(@address.favorite_id).destroy unless @address.favorite_id.blank?
      #@address.favoritable.destroy unless @address.favorite_id.blank?
    end
end
