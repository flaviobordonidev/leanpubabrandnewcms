class CompanyPersonMapsController < ApplicationController
  before_action :set_company_person_map, only: [:show, :edit, :update, :destroy]

  # GET /company_person_maps
  # GET /company_person_maps.json
  def index
    #@companies = Company.all
    params[:master_page] = "companies" if params[:master_page].blank?
    params[:search_master] = "" if params[:search_master].blank?
    params[:search_nested] = "" if params[:search_nested].blank?
    if params[:master_page] == "companies"
      if params[:search_nested] == ""
        #companiesduplicated = Company.search(params[:search_master])
        #@companies = companiesduplicated.uniq
        #@companies = Company.search(params[:search_master]).distinct
        @pagy, @companies = pagy(Company.search(params[:search_master]).order(created_at: "DESC"), page_param: :page_master, items: 2)
      else
        #companiesduplicated = Company.search(params[:search_master]).joins(:people).merge(Person.search(params[:search_nested]))
        #@companies = companiesduplicated.uniq
        #@companies = Company.search(params[:search_master]).joins(:people).merge(Person.search(params[:search_nested]))
        @pagy, @companies = pagy(Company.search(params[:search_master]).order(created_at: "DESC").joins(:people).merge(Person.search(params[:search_nested])), page_param: :page_master, items: 2)
      end
    else # l'altra unica alternativa è master_page = people
      if params[:search_nested] == ""
        @pagy, @people = pagy(Person.search(params[:search_master]).order(created_at: "DESC"), page_param: :page_master, items: 2)
      else
        @pagy, @people = pagy(Person.search(params[:search_master]).order(created_at: "DESC").joins(:companies).merge(Company.search(params[:search_nested])), page_param: :page_master, items: 2)
      end
    end
  end

  # GET /company_person_maps/1
  # GET /company_person_maps/1.json
  def show
  end

  # GET /company_person_maps/new
  def new
    @company_person_map = CompanyPersonMap.new
  end

  # GET /company_person_maps/1/edit
  def edit
    @people = Person.all # Per elenco nel popup
    @company_person_map.person_id = params[:nested_id] unless params[:nested_id].blank? # Se scelgo persona nel popup 
  end

  # POST /company_person_maps
  # POST /company_person_maps.json
  def create
    @company_person_map = CompanyPersonMap.new(company_person_map_params)

    respond_to do |format|
      if @company_person_map.save
        format.html { redirect_to @company_person_map, notice: 'Company person map was successfully created.' }
        format.json { render :show, status: :created, location: @company_person_map }
      else
        format.html { render :new }
        format.json { render json: @company_person_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /company_person_maps/1
  # PATCH/PUT /company_person_maps/1.json
  def update
    respond_to do |format|
      if @company_person_map.update(company_person_map_params)
        format.html { redirect_to @company_person_map, notice: 'Company person map was successfully updated.' }
        format.json { render :show, status: :ok, location: @company_person_map }
      else
        format.html { render :edit }
        format.json { render json: @company_person_map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_person_maps/1
  # DELETE /company_person_maps/1.json
  def destroy
    @company_person_map.destroy
    respond_to do |format|
      format.html { redirect_to company_person_maps_url, notice: 'Company person map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_person_map
      @company_person_map = CompanyPersonMap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_person_map_params
      params.require(:company_person_map).permit(:company_id, :person_id, :summary, person_attributes: [:id, :title, :first_name, :last_name, :homonym, :note, telephones_attributes: [:_destroy, :id, :name, :prefix, :number], emails_attributes: [:_destroy, :id, :name, :address]])
    end

end
