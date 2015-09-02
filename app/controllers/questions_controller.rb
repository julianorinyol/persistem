class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
   before_filter :restrict_access
   
  # respond_to :js
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.where(public: true)
    if current_user
      @my_questions = Question.where(user_id: current_user.id)
    end
    @question = Question.new
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # # GET /questions/new
  def new
    @question = Question.new
  end

  # # GET /questions/1/edit
  def edit
    @questions = Question.where(public: true)
    @answer = Answer.new
    @answers = Answer.where(question_id: @question.id)
    if current_user
      @synced = current_user.synced
      @my_questions = Question.where(user_id: current_user.id)
    end
    @note = Note.where(id: @question.note_id).first
  end
  # # POST /questions
  # # POST /questions.json
  def create
    @question = Question.new(question_params)

    if current_user
      @question.user = current_user
    end
    
    respond_to do |format|
      if @question.save
        format.html { redirect_to :back, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
        # format.html { notice: 'Question was successfully created'}
      else
        # format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end

    # render json: @question
  end
    
  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to :back, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        # format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      # format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params[:question]
      params.require(:question).permit(:note_id, :text, :subject_id, :user_id)
    end

end
