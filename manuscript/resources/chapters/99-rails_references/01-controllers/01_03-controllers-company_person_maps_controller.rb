class CompanyPersonMapsController < ApplicationController
  before_action :set_company_person_map, only: [:show, :edit, :update, :destroy]

  # GET /company_person_maps
  # GET /company_person_maps.json
  def index
    @company_person_maps = CompanyPersonMap.all
  end

  # GET /company_person_maps/1
  # GET /company_person_maps/1.json
  def show
  end

  # GET /company_person_maps/new
  def new
    # il new mi apre la maschera di company/person index per scegliere l'id mancante
    # una volta scelto salva il record con summary = "employee" e mi apre la maschera di edit
    @company_person_map = CompanyPersonMap.new
    if params[:last_front_controller] == "companies"
      @company_person_map.company_id = params[:last_front_id]
      @company_person_map.person_id = params[:change_id] if params[:change_id].present?
      #@relateds = Person.search(params[:search]).order('created_at DESC').page(params[:page]).per_page(2)
    elsif params[:last_front_controller] == "people"
      @company_person_map.person_id = params[:last_front_id]
      @company_person_map.company_id = params[:change_id] if params[:change_id].present?
      #@relateds = Company.search(params[:search]).order('created_at DESC').page(params[:page]).per_page(2)
    else
      raise "error"
    end
  end

  # GET /company_person_maps/1/edit
  def edit
    if params[:change_id].present?
      if params[:last_front_controller] == "companies"
        @company_person_map.person_id = params[:change_id]
      elsif params[:last_front_controller] == "people"
        @company_person_map.company_id = params[:change_id]
      end
    end
  end

  # POST /company_person_maps
  # POST /company_person_maps.json
  def create
    @company_person_map = CompanyPersonMap.new(company_person_map_params)

    respond_to do |format|
      if @company_person_map.save
        #format.html { redirect_to @company_person_map, notice: 'Company person map was successfully created.' }
        format.html { redirect_to url_for(view_context.h_params_path(path: "/#{params[:last_front_controller]}/#{params[:last_front_id]}", related: params[:last_front_related], page: params[:last_front_page], search: params[:last_front_search])), notice: 'Company_Person_Map was successfully created.' }
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
        format.html do
          if params[:last_front_controller] == "companies"
            #"seleziona la persona da associare come preferita dell'azienda"
            manage_person_favorite_of_company # private action
          elsif params[:last_front_controller] == "people"
            #"seleziona l'azienda da associare come preferita della persona"
            manage_company_favorite_of_person # private action
          else
            raise "ERROR"
          end
          redirect_to url_for(view_context.h_params_path(path: "/#{params[:last_front_controller]}/#{params[:last_front_id]}", related: params[:last_front_related], page: params[:last_front_page], search: params[:last_front_search])), notice: 'Company person map was successfully updated.'
        end
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
    manage_favorite_destroy # private action
    @company_person_map.destroy
    respond_to do |format|
      #format.html { redirect_to company_person_maps_url, notice: 'Company person map was successfully destroyed.' }
      format.html { redirect_to url_for(view_context.h_params_path(path: "/#{params[:last_front_controller]}/#{params[:last_front_id]}", related: params[:last_front_related], page: params[:last_front_page], search: params[:last_front_search])), notice: 'Company person map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #-----------------------------------------------------------------------------
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_person_map
      @company_person_map = CompanyPersonMap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_person_map_params
      params.require(:company_person_map).permit(:company_id, :person_id, :summary, :favorite_id_company, :favorite_cb_company, :favorite_id_person, :favorite_cb_person)
    end

    def manage_person_favorite_of_company
      #raise "->#{@company_person_map.favorite_cb_company}" # questo prende il valore dal database
      #raise "->#{params[:company_person_map][:favorite_cb_company]}" # questo prende il valore dalla view
      if params[:company_person_map][:favorite_cb_person] == "0"  # if combo-box-favorite is OFF
        if @company_person_map.favorite_id_person.blank?
          #raise "don't do anything"
        else
          #raise "delete favorite"
          Favorite.find(@company_person_map.favorite_id_person).destroy
          @company_person_map.update(favorite_id_person: nil)
        end
      else  # if combo-box-favorite is ON
        if @company_person_map.favorite_id_person.blank?
          #raise "crea nuovo favorite"
          #f = Company.find(@company_person_map.company_id).favorites.new(copy_normal: @company_person_map.summary, copy_bold: "#{@company_person_map.person.title} #{@company_person_map.person.first_name} #{@company_person_map.person.last_name}")
          f = Company.find(@company_person_map.company_id).favorites.new(copy_table: "company_person_maps", copy_table_id: @company_person_map.id, copy_normal: @company_person_map.summary, copy_bold: "#{@company_person_map.person.title} #{@company_person_map.person.first_name} #{@company_person_map.person.last_name}")
          f.save
          @company_person_map.update(favorite_id_person: f.id)
        else
          #raise "aggiorna favorite esistente"
          f = Favorite.find(@company_person_map.favorite_id_person)
          f.update(copy_table: "company_person_maps", copy_table_id: @company_person_map.id, copy_normal: @company_person_map.summary, copy_bold: "#{@company_person_map.person.title} #{@company_person_map.person.first_name} #{@company_person_map.person.last_name}")
          f.save
        end
      end
    end

    def manage_company_favorite_of_person
      #raise "->#{@company_person_map.favorite_cb_person}" # questo prende il valore dal database
      #raise "->#{params[:company_person_map][:favorite_cb_person]}" # questo prende il valore dalla view
      if params[:company_person_map][:favorite_cb_company] == "0"  # if combo-box-favorite is OFF
        if @company_person_map.favorite_id_company.blank?
          #raise "don't do anything"
        else
          #raise "delete favorite"
          Favorite.find(@company_person_map.favorite_id_company).destroy
          @company_person_map.update(favorite_id_company: nil)
        end
      else  # if combo-box-favorite is ON
        if @company_person_map.favorite_id_company.blank?
          #raise "crea nuovo favorite"
          f = Person.find(@company_person_map.person_id).favorites.new(copy_table: "company_person_maps", copy_table_id: @company_person_map.id, copy_normal: @company_person_map.summary, copy_bold: "#{@company_person_map.company.name} - #{@company_person_map.company.status}")
          f.save
          @company_person_map.update(favorite_id_company: f.id)
        else
          raise "aggiorna favorite esistente"
          f = Favorite.find(@company_person_map.favorite_id_company)
          f.update(copy_table: "company_person_maps", copy_table_id: @company_person_map.id, copy_normal: @company_person_map.summary, copy_bold: "#{@company_person_map.company.name} - #{@company_person_map.company.status}")
          f.save
        end
      end
    end

    def manage_favorite_destroy
      # se il record company_person_maps ha dei favoriti li elimino prima di eliminare il record.
      Favorite.find(@company_person_map.favorite_id_person).destroy unless @company_person_map.favorite_id_person.blank?
      Favorite.find(@company_person_map.favorite_id_company).destroy unless @company_person_map.favorite_id_company.blank?
    end

end
