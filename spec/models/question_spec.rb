require 'rails_helper'

describe Question do

  before(:each) do
    @question = build(:question)
  end

  #*********************************Validations**********************************************************# 
   it { is_expected.to validate_presence_of :text }
   it { is_expected.to validate_presence_of :note_id }
   it { is_expected.to validate_presence_of :user_id }


  # create_table "questions", force: :cascade do |t|
  #   t.integer  "note_id"
  #   t.string   "text"
  #   t.integer  "subject_id"
  #   t.integer  "user_id"
  #   t.integer  "answer_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  it "is valid with an note_id, text, user_id" do
    expect(@question).to be_valid
  end
 

  #*********************************Associations**********************************************************# 
  it { is_expected.to belong_to(:note) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:answers) }
  it { is_expected.to have_and_belong_to_many(:quizzes) }



  # belongs_to :note
  # has_many :answers
  # belongs_to :user
  # # has_many :questions_quiz
  # has_and_belongs_to_many :quizzes
  # delegate :notebook, :to => :note
  # # has_many :quizzes, through: :questions_quiz

  # *********************************Scopes************************************************************** #
  # scope :today
  # scope :this_week
  # scope :this_month
  # scope :this_year

  # *********************************Methods************************************************************** #
  
  # def self.popular 
  it "sorts the questions by how many answers each has" do
    binding.pry
    5.times do 
      create(:question)
    end
    100.times do
      create(:answer)
    end
    sorted_questions = Question::popular
    expect(sorted_questions[0].answers.size).to be >= sorted_questions[1].answers.size
  end
    # 5.times do 
    #   create(:note, user: @user)
    # end
    # 100.times do 
    #   create(:question, user: @user)
    # end
    # sorted_notes = Note::popular(@user)
    # expect(sorted_notes[0].questions.size).to be >= sorted_notes[1].questions.size

  # def self.sort_by_popularity questions


end