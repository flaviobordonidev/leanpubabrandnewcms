class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people
  # GET /people.json
  def index
    #@people = Person.all
    params[:search] = "" if params[:search].blank?
    #@people = Person.search(params[:search])
    @pagy, @people = pagy(Person.search(params[:search]).order(created_at: "DESC"), items: 2)
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    #raise "parametro da hidden_field back_to: #{params[:back_to]}"
    params[:back_to] = "" if params[:back_to].blank?
    respond_to do |format|
      if @person.update(person_params)
        format.html do
          if params[:back_to] == "company_person_maps_edit"
            redirect_to edit_company_person_map_path(params[:back_to_id]), notice: 'Person was successfully updated.' 
          else
            redirect_to @person, notice: 'Person was successfully updated.' 
          end
        end
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:title, :first_name, :last_name, :homonym, :note, telephones_attributes: [:_destroy, :id, :name, :prefix, :number], emails_attributes: [:_destroy, :id, :name, :address])
    end
end
