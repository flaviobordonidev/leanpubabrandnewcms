class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.search(params[:search]).order('updated_at DESC').page(params[:page])
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    # gestiamo l'elenco dei relateds
    #params[:related] = "people" if params[:related].blank?
    case params[:related]
    when "favorites"
      # TODO
      #@relateds = current_user.favorites.search(params[:search]).order('created_at DESC').page(params[:page]).per_page(6)
      @relateds = @company.favorites.all.page(params[:page])
      @relateds_path = "favorites"
    when "people"
      @relateds = @company.company_person_maps.search_people(params[:search]).order('created_at DESC').page(params[:page])
      @relateds_path = "company_person_maps"
    when "companies"
      @relateds = Company.all.page(params[:page])
      #@relateds = Company.search(params[:search]).order('created_at DESC').page(params[:page]).per_page(6)
      @relateds_path = "companies"
    when "contacts"
      @relateds = @company.contacts.search(params[:search]).order('updated_at DESC').page(params[:page])
      @relateds_path = "contacts"
    when "addresses"
      @relateds = @company.addresses.search(params[:search]).order('updated_at DESC').page(params[:page])
      @relateds_path = "addresses"
    when "histories"
      @relateds = @company.histories.search(params[:search]).order('updated_at DESC').page(params[:page])
      @relateds_path = "histories"
    else
      raise "#TODO"
    end
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.name = params[:last_front_search]
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        #format.html { redirect_to url_for(view_context.h_params_path(path: "/companies/#{@company.id}", last_front_controller: "companies", last_front_action: "show", last_front_id: "#{@company.id}", related: "favorites")), notice: t(".notice") }
        format.html do
          manage_favorite # private action
          #redirect_to url_for(view_context.h_params_path(path: "/companies/#{@company.id}", last_front_controller: "companies", last_front_action: "show", last_front_id: "#{@company.id}", related: "favorites")), notice: t(".notice")
          redirect_to url_for(view_context.h_params_path(path: "/companies/#{@company.id}", related: "favorites")), notice: t(".notice")
        end
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, alert: t(".alert") }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    if params[:company][:remove_logo] == "1"
      @company.logo = nil
      @company.save
    end
    respond_to do |format|
      if @company.update(company_params)
        #format.html { redirect_to url_for(view_context.h_params_path(path: "/companies/#{@company.id}")), notice: t(".notice") }
        format.html do
          manage_favorite # private action
          redirect_to url_for(view_context.h_params_path(path: "/companies/#{@company.id}")), notice: t(".notice")
        end
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, alert: t(".alert") }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    manage_favorite_destroy # private action
    @company.destroy
    respond_to do |format|
      format.html { redirect_to url_for(view_context.h_params_path(path: "/homepage/", related: "companies", page: 1, search: "")), notice: t(".notice") }
      #format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:logo, :name, :status, :sector, :taxation_number_first, :taxation_number_second, :memo, :favorite_id, :favorite_cb, :building, :full_address, :address_tag, :telephone, :fax, :email, :web_site, :note_contacts)
    end

    def manage_favorite
      #raise "->#{@company.favorite_cb}" # questo prende il valore dal database
      #raise "->#{params[:company][:favorite_cb]}" # questo prende il valore dalla view
      if params[:company][:favorite_cb] == "0"  # if combo-box-favorite is OFF
        if @company.favorite_id.blank?
          #raise "don't do anything"
        else
          #raise "delete favorite"
          Favorite.find(@company.favorite_id).destroy
          @company.update(favorite_id: nil)
        end
      else  # if check-box-favorite is ON
        if @company.favorite_id.blank?
          #raise "crea nuovo favorite"
          f = current_user.favorites.new(copy_normal: "azienda", copy_bold: "#{@company.name}", copy_table: "companies", copy_table_id: @company.id)
          f.save
          @company.update(favorite_id: f.id)
        else
          #raise "aggiorna favorite esistente"
          f = Favorite.find(@company.favorite_id)
          f.update(copy_normal: "azienda", copy_bold: "#{@company.name}", copy_table: "companies", copy_table_id: @company.id)
          f.save
        end
      end
    end

    def manage_favorite_destroy
      # se il record @company ha un favorito lo elimino prima di eliminare il record.
      Favorite.find(@company.favorite_id).destroy unless @company.favorite_id.blank?
      #@company.favoritable.destroy unless @company.favorite_id.blank?
    end
end
