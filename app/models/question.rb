class Question < ActiveRecord::Base
  include SharedMethods

  belongs_to :note
  has_many :answers
  belongs_to :user
  # has_many :questions_quiz
  has_and_belongs_to_many :quizzes
  delegate :notebook, :to => :note
  # has_many :quizzes, through: :questions_quiz

  validates :note_id, :text, :user_id, presence: true


  scope :today, -> do where("created_at BETWEEN ? AND ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day) end
  scope :this_week, -> do where("created_at BETWEEN ? AND ?", (Time.zone.now - 7.days).beginning_of_day, Time.zone.now.end_of_day) end
  scope :this_month, -> do where("created_at BETWEEN ? AND ?", (Time.zone.now - 30.days).beginning_of_day, Time.zone.now.end_of_day) end
  scope :this_year,  -> do where("created_at BETWEEN ? AND ?", (Time.zone.now - 1.year).beginning_of_day, Time.zone.now.end_of_day) end

  def self.popular current_user
    questions = Question.where(user_id: current_user.id)
    sort_by_number_of_dependants(questions, "answers")
  end

  def self.sort_by_popularity questions
    sort_by_number_of_dependants(questions, "answers")
  end
end