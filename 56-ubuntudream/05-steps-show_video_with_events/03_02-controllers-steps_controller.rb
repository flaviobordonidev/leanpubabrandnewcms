class StepsController < ApplicationController
  before_action :set_lesson
  before_action :set_step, only: %i[ show edit update destroy ]

  # GET /steps or /steps.json
  def index
    #@steps = Step.all
    @steps = @lesson.steps
  end

  # GET /steps/1 or /steps/1.json
  def show
  end

  # GET /steps/new
  def new
    #@step = Step.new
    @step = @lesson.steps.new
  end

  # GET /steps/1/edit
  def edit
  end

  # POST /steps or /steps.json
  def create
    #@step = Step.new(step_params)
    @step = @lesson.steps.new(step_params)

    respond_to do |format|
      if @step.save
        #format.html { redirect_to step_url(@step), notice: "Step was successfully created." }
        format.html { redirect_to lesson_steps_path(@lesson), notice: 'Step was successfully created.' }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1 or /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        #format.html { redirect_to step_url(@step), notice: "Step was successfully updated." }
        #format.html { redirect_to lesson_step_path(@lesson), notice: 'Step was successfully updated.' }
        format.html do 
          if @step.next.present?
            redirect_to lesson_step_path(@lesson, @step.next.id), notice: 'Step was successfully updated.' 
          else
            redirect_to lesson_step_path(@lesson), notice: 'Step was successfully updated. - Ultima risposta'
          end
        end
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1 or /steps/1.json
  def destroy
    @step.destroy

    respond_to do |format|
      #format.html { redirect_to steps_url, notice: "Step was successfully destroyed." }
      format.html { redirect_to lesson_steps_path(@lesson), notice: 'Step was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_step
      #@step = Step.find(params[:id])
      @step = @lesson.steps.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def step_params
      params.require(:step).permit(:question, :answer, :lesson_id, :youtube_video_id, answers_attributes: [:_destroy, :id, :content, :user_id])
    end
end
