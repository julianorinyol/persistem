class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.where(public: true)
    if current_user
      @my_answers = Answer.where(user_id: current_user.id)
    end
    @answer = Answer.new
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # # GET /answers/new
  def new
    @answer = Answer.new
  end

  # # GET /answers/1/edit
  def edit
    @answers = Answer.where(public: true)
    if current_user
      @my_answers = Answer.where(user_id: current_user.id)
    end
  end

  # # POST /answers
  # # POST /answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.save
    redirect_to :back


    # respond_to do |format|
      # if @answer.save
        # format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        # format.json { render :show, status: :created, location: @answer }
        # format.html { notice: 'Answer was successfully created'}
      # else
        # format.html { render :new }
        # format.json { render json: @answer.errors, status: :unprocessable_entity }
      # end
    # end
  end

  def createViaAjax
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    # @answer.save
    # render :nothing => true

    if @answer.save
      render json: 'answer was saved'
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

    
  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        # format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        # format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      # format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params[:answer]
      params.permit(:answer, :note_id, :question_id, :text, :subject_id, :user_id)
    end

end

=begin
  create_table "answers", force: :cascade do |t|  
    t.integer "note_id"
    t.integer "subject_id"
    t.integer "user_id"
    t.integer "question_id"
    t.string  "text"
  end
=end