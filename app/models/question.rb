class Question < ActiveRecord::Base
  has_one :note
  has_many :answers
  belongs_to :user
  # has_many :questions_quiz
  has_and_belongs_to_many :quizzes

  # has_many :quizzes, through: :questions_quiz
end
