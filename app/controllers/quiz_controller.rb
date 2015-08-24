class QuizController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
 
  def new
    @quiz = Quiz.create
    @quiz.get_questions(7)
    redirect_to quiz_path(id: @quiz.id)
  end

  def show
  
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
      params.requirquize(:quiz).permit(:note_id, :text, :subject_id, :user_id)
    end
end
