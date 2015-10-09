require 'rails_helper'

describe Quiz do

  before(:each) do
    @quiz = build(:quiz)
  end

  #*********************************Validations**********************************************************# 
  # create_table "quizzes", force: :cascade do |t|
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.integer  "user_id"
  # end

   it { is_expected.to validate_presence_of :user_id }

  #*********************************Associations**********************************************************# 
  # has_and_belongs_to_many :questions
  # belongs_to :user

  it { is_expected.to have_and_belong_to_many :questions }

  # *********************************Methods************************************************************** #
  # def get_questions num
  it "adds up to the specified number of questions that are the users to its question array" do
    # make a quiz

    # make 5 questions
    binding.pry

    @quiz.get_questions(5)
    expect(@quiz.questions.size).to eq 5
  end

  # def get_questions num
  #   self.questions << Question.where(user_id: user.id).order("RANDOM()").take(num)
  #   # Thing.order("RANDOM()").first
  # end

  it "doesn't expose any questions that don't belong to the current user"


  # def add_questions_with_least_answers num
  it "adds up to the number specified of questions to the questions array in the order of those that have the least answers"

  # def get_questions_with_least_answers num
  it "gets up to the specified amount of the users questions in the order of those that have the least answers"

  # def custom num_questions, params
  it "creates a custom quiz selecting only questions generated in a specific time frame"

  it "creates a custom quiz selecting only questions from particular notebooks"

  it "creates a custom quiz selecting more popular questions"


  it "selects questions from last week the first notebook only in order of least popular"


  # def shuffle_hash hashy
  it "puts a hash into a random order"

  # def get_previous_answers
  it "returns previously submitted answers in a custom object"
  # {index: index, text: question.text}

end