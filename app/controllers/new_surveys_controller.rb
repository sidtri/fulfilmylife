class NewSurveysController < ApplicationController
  before_action :set_new_survey, only: [:show, :edit, :update, :destroy]

  # GET /new_surveys
  # GET /new_surveys.json
  def index
    @new_surveys = NewSurvey.all
  end

  # GET /new_surveys/1
  # GET /new_surveys/1.json
  def show
  end

  # GET /new_surveys/new
  def new
    @new_survey = NewSurvey.new
  end

  # GET /new_surveys/1/edit
  def edit
  end

  # POST /new_surveys
  # POST /new_surveys.json
  def create
    @new_surveys = []
    params.except(:utf8, :authenticity_token, :action, :controller, :card_id).each do |key, val|
     @new_surveys << NewSurvey.new(card_id: params[:card_id], question_id: key, answer: val)
    end

    respond_to do |format|
      if @new_surveys.each(&:save)
        format.html { redirect_to root_path, notice: 'New survey was successfully created.' }
        format.json { render :show, status: :created, location: @new_survey }
      else
        format.html { render :new }
        format.json { render json: @new_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /new_surveys/1
  # PATCH/PUT /new_surveys/1.json
  def update
    respond_to do |format|
      if @new_survey.update(new_survey_params)
        format.html { redirect_to @new_survey, notice: 'New survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @new_survey }
      else
        format.html { render :edit }
        format.json { render json: @new_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /new_surveys/1
  # DELETE /new_surveys/1.json
  def destroy
    @new_survey.destroy
    respond_to do |format|
      format.html { redirect_to new_surveys_url, notice: 'New survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_survey
      @new_survey = NewSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_survey_params
      params.require(:new_survey).permit(:card_id, :question_id, :answer)
    end
end
