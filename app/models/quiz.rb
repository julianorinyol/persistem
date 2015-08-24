class Quiz < ActiveRecord::Base
  # has_many :questions_quiz
  # has_many :questions
  # has_many :questions, through: :questions_quiz
  has_and_belongs_to_many :questions

  belongs_to :user
end