class Question < ActiveRecord::Base
  belongs_to :note
  has_many :answers
  belongs_to :user
  # has_many :questions_quiz
  has_and_belongs_to_many :quizzes
  delegate :notebook, :to => :note
  # has_many :quizzes, through: :questions_quiz

  scope :today, -> do where("created_at BETWEEN ? AND ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day) end
  scope :this_week, -> do where("created_at BETWEEN ? AND ?", (Time.zone.now - 7.days).beginning_of_day, Time.zone.now.end_of_day) end
  scope :this_month, -> do where("created_at BETWEEN ? AND ?", (Time.zone.now - 30.days).beginning_of_day, Time.zone.now.end_of_day) end
  scope :this_year,  -> do where("created_at BETWEEN ? AND ?", (Time.zone.now - 1.year).beginning_of_day, Time.zone.now.end_of_day) end

  def self.popular 
    questions = Question.includes(:answers)

    counts = Hash.new 0

    questions.each do |q|
      counts[q.id] = { question: q, amount: q.answers.size }
    end
    mapped = counts.values.sort_by do |obj| obj['amount'] end
    arr = []
    mapped.each do |custom_obj| arr << custom_obj[:question] end
    return arr
  end

  def self.sort_by_popularity questions
    counts = Hash.new 0

    questions.each do |q|
      counts[q.id] = { question: q, amount: q.answers.size }
    end
    mapped = counts.values.sort_by do |obj| obj['amount'] end
    arr = []
    mapped.each do |custom_obj| arr << custom_obj[:question] end
    return arr
  end
end
