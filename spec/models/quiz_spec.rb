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
    num_answers_for_quizzes_questions = get_num_of_dependants_for_all("Question", 'answers')[0, 7]

    num_answer_all_questions = get_num_of_dependants_for_array(@quiz.questions, 'answers')
    expect(num_answers_for_quizzes_questions).to eq num_answer_all_questions
  end


  # def custom num_questions, params
  it "creates a custom quiz selecting only questions generated in a specific time frame" do
    # generate questions from different time periods
    @quiz.save
    # this week's questions
    create(:question)
    create(:question, created_at: Time.zone.now - 4.days)
    create(:question, created_at: Time.zone.now - 3.days)
    create(:question, created_at: Time.zone.now - 2.days)
    create(:question, created_at: Time.zone.now - 1.days)
    # older 
    create(:question, created_at: Time.zone.now - 12.days)
    create(:question, created_at: Time.zone.now - 8.days)

    params = { time_ago: 'this_week', popular: "unpopular", notebooks: nil }
    @quiz.custom(7, params)
    expect(@quiz.questions.size).to eq 5
    @quiz.questions.each do |question|
      expect(question.created_at).to be > (Time.zone.now - 7.days).beginning_of_day
    end
  end
  #  def custom num_questions, params
  #   # first 2 are exclusive queries, and then popular is an order_by

  #   if params[:time_ago]
  #     questions = Question.where(user_id: user.id).send(params[:time_ago]).includes(:note)
  #   else  
  #     questions = Question.joins(:note).where(user_id: user.id)
  #   end
    
  #   # notebooks is an array of strings
  #   if params[:notebooks] && params[:notebooks].length > 0 
  #     # Cant get the godamn query to work:
  #       #  it works like Question.joins(:note).where('notebook_id = (1,2)')
  #     # Question.joins(:note).where('notebook_id = ?', params[:notebooks])
  #     notebook_ids_ints = [];
  #     params[:notebooks].split(',').each do |id|
  #       notebook_ids_ints << id.to_i
  #     end
  #     results = filter_out_questions_not_in_notebook_array(questions, notebook_ids_ints)
  #   else 
  #     results = questions
  #   end
    
  #   if params[:popular] && params[:popular] == 'popular'
  #     results = Question.sort_by_popularity(results)
  #   end

  #   correct_num = []

  #   results.each do|r|
  #     if correct_num.size < num_questions
  #       correct_num << r
  #     end
  #   end
  #   self.questions << correct_num
  # end

  it "creates a custom quiz selecting only questions from particular notebooks"

  it "creates a custom quiz selecting more popular questions"


  it "selects questions from last week the first notebook only in order of least popular"

  it "doesn't expose other peoples notes"


  # def shuffle_hash hashy
  it "puts a hash into a random order"

  # def get_previous_answers
  it "returns previously submitted answers in a custom object"
  # {index: index, text: question.text}

end