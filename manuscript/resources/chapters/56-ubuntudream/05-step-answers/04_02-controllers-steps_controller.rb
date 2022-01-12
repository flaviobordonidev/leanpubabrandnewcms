class StepsController < ApplicationController
  before_action :get_lesson
  before_action :set_step, only: [:show, :edit, :update, :destroy]

  # GET /steps
  # GET /steps.json
  def index
    @steps = @lesson.steps
  end

  # GET /steps/1
  # GET /steps/1.json
  def show
  end

  # GET /steps/new
  def new
    @step = @lesson.steps.build
  end

  # GET /steps/1/edit
  def edit
  end

  # POST /steps
  # POST /steps.json
  def create
    @step = @lesson.steps.build(step_params)

    respond_to do |format|
      if @step.save
        format.html { redirect_to lesson_steps_path(@lesson), notice: 'Step was successfully created.' }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1
  # PATCH/PUT /steps/1.json
  def update
    #inserisco utente loggato nella chiave esterna delle risposte
    step_params_copy = step_params
    if step_params_copy[:answers_attributes].present?
      step_params_copy[:answers_attributes].each do |pos,answer_params| #keys are integers, like indices in a list.
        next if answer_params.include?(:id) #Because the user is updating an answer
        step_params_copy[:answers_attributes][pos][:user_id] = current_user.id
      end 
    end
    #raise "Controllo: #{step_params_copy[:answers_attributes]}"
    respond_to do |format|
      if @step.update(step_params_copy)
        format.html do 
          if @step.id < @lesson.steps.last.id
            redirect_to lesson_step_path(@lesson, @step.id+1), notice: 'Passo successivo'
          else
            redirect_to lesson_steps_path(@lesson), notice: 'Fine Aula'
            #redirect_to "https://www.google.it/"
          end
        end
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1
  # DELETE /steps/1.json
  def destroy
    @step.destroy
    respond_to do |format|
      #format.html { redirect_to steps_url, notice: 'Step was successfully destroyed.' }
      format.html { redirect_to lesson_steps_path(@lesson), notice: 'Step was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def get_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_step
      @step = @lesson.steps.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      #params.require(:step).permit(:question, :answer, :lesson_id, answers_attributes: [:_destroy, :id, :content, :user_id])
      params.require(:step).permit(:question, :answer, :lesson_id, :youtube_video_id, answers_attributes: [:_destroy, :id, :content])
    end
end