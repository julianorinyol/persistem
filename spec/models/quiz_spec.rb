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
    @quiz.save
    7.times do
      create(:question)
    end
    @quiz.get_questions(5)
    expect(@quiz.questions.size).to eq 5
  end

  it "doesn't expose any questions that don't belong to the current user" do
    first_user = User.first
    @quiz.save
    7.times do
      create(:question)
    end
    user2 = create(:user)
    7.times do
      create(:question, user_id: user2.id)
    end
    @quiz.get_questions(5)
    @quiz.questions.each do |question|
      expect(question.user_id).not_to eq user2.id
      expect(question.user_id).to eq first_user.id
    end
  end


  # def add_questions_with_least_answers num and get_questions_with_least_answers
  it "adds up to the number specified of questions to the questions array in the order of those that have the least answers" do
    @quiz.save
    create_x_many_objects(15, 'question')
    create_x_many_objects(100, 'answer')
    # make answers, distribute them randomly
    @quiz.add_questions_with_least_answers 7
    expect(@quiz.questions.size).to eq 7
  end

  # def add_questions_with_least_answers num and get_questions_with_least_answers
  it "gets the questions with the least answers" do
    @quiz.save

    create_x_many_objects(15, 'question')
    create_x_many_objects(100, 'answer')

    @quiz.add_questions_with_least_answers 7

    # Get an array of the 7 smallest number of answers a question has, ordered smallest to biggest.
    num_answers = get_num_of_dependants_for_all("Question", 'answers')[0, 7]

    x = get_num_of_dependants_for_array(@quiz.questions, 'answers')
    expect(num_answers).to eq x
  end


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