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
    num_answers_for_all_questions = get_num_of_dependants_for_all("Question", 'answers')[0, 7]

    num_answers_quizzes_questions = get_num_of_dependants_for_array(@quiz.questions, 'answers')
    expect(num_answers_quizzes_questions).to eq num_answers_for_all_questions
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

  it "doesn't expose other users notes, when creating custom quiz by date"

  it "creates a custom quiz selecting only questions from particular notebooks" do
    @quiz.save
    # create some notebooks
    create_x_many_objects(5, 'notebook')
    # create some questions, randomly distributed among notebooks.
    create_x_many_objects(35, 'note')
    create_x_many_objects(35, 'question')
    notebook_ids = [Notebook.first.id, Notebook.last.id]
    notebook_param = "" + notebook_ids[0].to_s + ", " + notebook_ids[1].to_s
    params = { time_ago: nil, popular: "unpopular", notebooks: notebook_param }
    @quiz.custom(7, params)
    # expect(@quiz.questions.size).to eq ???????
    @quiz.questions.each do |question|
      expect(notebook_ids.include?(question.notebook.id)).to be true
    end
  end

  it "doesn't expose other users notes, when creating custom quiz by notebook" do 
    @quiz.save
    user1 = User.first
    user2 = create(:user)
    create_x_many_objects(10, 'notebook')
    create_x_many_objects(50, 'note')
    create_x_many_objects(100, 'question')
    notebook_ids = [user1.notebooks.sample.id,user1.notebooks.sample.id]
    notebook_param = "" + notebook_ids[0].to_s + ", " + notebook_ids[1].to_s
    params = { time_ago: nil, popular: "unpopular", notebooks: notebook_param }
    @quiz.custom(7, params)
    @quiz.questions.each do |question|
      expect(question.user_id).to_not eq user2.id
    end
  end

  it "creates a custom quiz selecting more popular questions" do
    @quiz.save
    # create some notebooks
    create_x_many_objects(5, 'notebook')
    # create some questions, randomly distributed among notebooks.
    create_x_many_objects(12, 'note')
    create_x_many_objects(35, 'question')
    create_x_many_objects(100, 'answer')

    params = { time_ago: nil, popular: "popular", notebooks: nil }
    @quiz.custom(7, params)
    num_of_answers_for_each_question = get_num_of_dependants_for_all("question","answers").reverse[0,7]
    num_answers_quizzes_questions = get_num_of_dependants_for_array(@quiz.questions, 'answers')
    expect(num_answers_quizzes_questions).to eq num_of_answers_for_each_question
  end
  # num_answers_for_all_questions = get_num_of_dependants_for_all("Question", 'answers')[0, 7]

  # num_answers_quizzes_questions = get_num_of_dependants_for_array(@quiz.questions, 'answers')
  # expect(num_answers_for_all_questions).to eq num_answers_quizzes_questions

  it "doesn't expose other users notes, when creating custom quiz by popularity" do
    @quiz.save
    user1 = User.first
    user2 = create(:user)
    # create some notebooks
    create_x_many_objects(10, 'notebook')
    # create some questions, randomly distributed among notebooks.
    create_x_many_objects(20, 'note')
    create_x_many_objects(70, 'question')
    create_x_many_objects(200, 'answer')

    # check for reasonable distribution.. giving space for probability so tests don't fail at random times
    expect(user2.answers.size).to be > 75
    ensure_each_user_has_at_least_one

    params = { time_ago: nil, popular: "popular", notebooks: nil }
    @quiz.custom(7, params)
    num_of_answers_for_each_question = get_num_of_dependants_for_all("question","answers").reverse[0,7]
    num_answers_quizzes_questions = get_num_of_dependants_for_array(@quiz.questions, 'answers')

    @quiz.questions.each do |question|
      expect(question.user.id).to be user1.id
      expect(question.user.id).not_to be user2.id
    end
  end



  it "selects questions from this year the first notebook only in order of least popular" do


    user = User.first
    2.times do
      create(:notebook)
    end
    # using only 2 notes, ONE from each notebook, as this makes it easier to query questions...
    note1 = create(:note,notebook_id: Notebook.first.id)
    note2 = create(:note, notebook_id: Notebook.last.id)

    40.times do 
      # questions generated before year
      months_ago = rand(100) + 13
      create(:question, created_at: (Time.now - months_ago.months))
    end
    60.times do 
      # questions generated this year
      days_ago = rand(363) + 1
      create(:question, created_at: (Time.now - days_ago.days))
    end
    create_x_many_objects(300, 'answer')

    expect(Question.this_year.size).to eq 60

    notebook_param = Notebook.first.id.to_s
    params = { time_ago: "this_year", popular: "unpopular", notebooks: notebook_param }
    @quiz.custom(7, params)

    # verify that they were the least popular of the subset
    this_year_questions_from_this_notebook = Note.first.questions.where("created_at >= :start_date", {start_date: Time.now - 1.year})
    nums_of_answers_for_questions_this_year_from_this_notebook = get_num_of_dependants_for_array(this_year_questions_from_this_notebook, "answers")[0,7]

    @quiz.questions.each do |question|
      # verify time
      expect(question.created_at).to be > (Time.now - 1.year)
      # verify notebook
      expect(question.notebook.id).to eq Notebook.first.id
    end

    expect(get_num_of_dependants_for_array(@quiz.questions, "answers")).to eq nums_of_answers_for_questions_this_year_from_this_notebook
  end

  it "doesn't expose other peoples notes"


  # def shuffle_hash hashy
  it "puts a hash into a random order"

  # def get_previous_answers
  it "returns previously submitted answers in a custom object"
  # {index: index, text: question.text}

end