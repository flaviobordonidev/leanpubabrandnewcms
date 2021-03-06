class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    #raise "request.referer = #{request.referer}"
    #raise "request.params = #{request.params}"
    params[:search] = "" if params[:search].blank?
    #@companies = Company.all
    #@companies = Company.search(params[:search])
    #@companies = Company.search(params[:search]).order('created_at DESC').page(params[:page])
    @pagy, @companies = pagy(Company.search(params[:search]).order(created_at: "DESC"), items: 12)
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
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
        format.html { redirect_to company_path(@company, params_from_submit), notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        #format.html { redirect_to company_path(@company, {:previous=>{"orologio"=>"gialle", "controller"=>"companies"}}), notice: 'Company was successfully updated.' }
        format.html do
          redirect_to company_path(@company, params_from_submit), notice: 'Company was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_image_attachment
    @image_to_delete = ActiveStorage::Attachment.find(params[:id])
    @image_to_delete.purge
    #redirect_back(fallback_location: request.referer)
    redirect_back(fallback_location: root_path)
  end

  private
  
    def params_from_submit
        #myparams = {previous:{orologio:"gialle", controller:"companies"}, disney: "toppolino"}
        #myparams = myparams.merge(:purequesto => "miao")
        myparams = {}
        myparams = myparams.merge(step: params[:step])
        myparams = myparams.merge(ones_index_controller: params[:ones_index_controller])
        myparams = myparams.merge(ones_index_action: params[:ones_index_action])
        #myparams = myparams.merge(ones_index_page: params[:ones_index_page]) Non mi serve perché sono in ordine di ultima immissione quindi vanno sempre in page=1
        #raise "myparams = #{myparams}"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :building, :address, :client_type, :client_rate, :supplier_type, :supplier_rate, :note, :sector, :tax_number_1, :tax_number_2, :logo_image, telephones_attributes: [:_destroy, :id, :name, :prefix, :number], emails_attributes: [:_destroy, :id, :name, :address], socials_attributes: [:_destroy, :id, :name, :address])
    end
end
