class CompanyPersonMapsController < ApplicationController
  before_action :set_company_person_map, only: [:show, :edit, :update, :destroy]

  # GET /company_person_maps
  # GET /company_person_maps.json
  def index
    @companies = Company.all
    #@company_person_maps = CompanyPersonMap.all
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
      params.require(:company_person_map).permit(:company_id, :person_id, :summary)
    end
end
