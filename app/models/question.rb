class Question < ActiveRecord::Base
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

  # returns all the users questions in order from LEAST to MOST popular (in terms of amount of associated questions)
  def self.popular current_user
    questions = Question.where(user_id: current_user.id).includes(:answers)

    counts = Hash.new 0

    questions.each do |question|
      counts[question.id] = { question: question, amount: question.answers.size }
    end
    sorted_by_num_answers = counts.values.sort_by do |obj| obj[:amount] end
    result = []
    sorted_by_num_answers.each do |custom_obj| result << custom_obj[:question] end
    return result
  end

  # returns the provided question set in order LEAST to MOST popular (in terms of amount of associated questions)
  def self.sort_by_popularity questions
    counts = Hash.new 0

    questions.each do |question|
      counts[question.id] = { question: question, amount: question.answers.size }
    end
    counts_sorted_by_num_answers = counts.values.sort_by do |obj| obj[:amount] end
    result = []
    counts_sorted_by_num_answers.each do |custom_obj| result << custom_obj[:question] end
    return result
  end
end
