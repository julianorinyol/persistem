class QuestionsQuiz < ActiveRecord::Migration
  def change
    create_table :questions_quizzes do |t|
      t.integer :quiz_id
      t.integer :question_id
    end
  end
end
