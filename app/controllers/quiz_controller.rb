class QuizController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
   before_filter :restrict_access
  
  def index
    @quizzes = Quiz.where(user_id: current_user.id)

     @notes = Note.where(public: true)
    if current_user
      @my_notes = Note.where(user_id: current_user.id)

      if @my_notes.length < 4 && current_user.evernote_auth
        getNotesFromEvernote
      end
      @my_notes = Note.where(user_id: current_user.id)
    end 
  end

  def new
    @quiz = Quiz.create(user_id: current_user.id)
    @quiz.get_questions(7)
    redirect_to quiz_path(id: @quiz.id)
  end

  def show
    @answers = @quiz.get_previous_answers

     @notes = Note.where(public: true)
    if current_user
      @my_notes = Note.where(user_id: current_user.id)

      if @my_notes.length < 4 && current_user.evernote_auth
        getNotesFromEvernote
      end
      @my_notes = Note.where(user_id: current_user.id)

    end
    
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
      params.require(:quiz).(:quiz).permit(:note_id, :text, :subject_id, :user_id)
    end
end
