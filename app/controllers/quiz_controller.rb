class QuizController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
  before_filter :restrict_access
  
  def index
    @quizzes = Quiz.where(user_id: current_user.id)

    if current_user
      @notes = Note.where(user_id: current_user.id)

      if @notes.length < 4 && current_user.evernote_auth
        get_notes_from_evernote 10
      end
      @notes = Note.where(user_id: current_user.id)
      @notebooks = Notebook.where(user_id: current_user.id)
      @synced = current_user.synced
    end 
  end

  def new
    @quiz = Quiz.create(user_id: current_user.id)
    @quiz.get_questions(7)
    redirect_to quiz_path(id: @quiz.id)
  end


  def new_least_answered
    @quiz = Quiz.create(user_id: current_user.id)
    @quiz.add_questions_with_least_answers 7
    redirect_to quiz_path(id: @quiz.id)
  end

  def new_custom
    @quiz = Quiz.create(user_id: current_user.id)

      @quiz.custom 7, params[:quiz]
      redirect_to quiz_path(id: @quiz.id)
  end

  def show
    if current_user
      @notes = Note.where(user_id: current_user.id)

      if @notes.length < 4 && current_user.evernote_auth
        get_notes_from_evernote 10
      end
      @notes = Note.where(user_id: current_user.id)
      @notebooks = Notebook.where(user_id: current_user.id)
      @synced = current_user.synced
    end
  end

  def sync 
    @quizzes = Quiz.where(user_id: current_user.id)
    render json: @quizzes
  end

  
  def create

  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params[:question]
      params.require(:quiz).(:quiz).permit(:note_id, :text, :subject_id, :user_id, :time_ago, :popular, :notebooks)
    end
end
