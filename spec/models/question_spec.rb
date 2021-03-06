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

  # *********************************Scopes************************************************************** #
  # scope :today
  # scope :this_week
  # scope :this_month
  # scope :this_year

  # *********************************Methods************************************************************** #
  
  # def self.popular 
  it "sorts all the user's questions by how many answers each has least to most" do
    5.times do 
      create(:question)
    end
    100.times do
      create(:answer)
    end
    sorted_questions = Question::popular(User.first, "answers")

    sorted_questions.each_with_index do |question, index|
      expect(question.answers.size).to be >= sorted_questions[index+1].answers.size unless index == sorted_questions.size - 1 
    end
    expect(sorted_questions[0].answers.size).to be >= sorted_questions[1].answers.size 
  end

  # def self.sort_by_popularity questions
  it "sorts an array of questions by their popularity returning in orded the least popular first" do 
    5.times do 
      create(:question)
    end
    100.times do
      create(:answer)
    end
    sorted_questions = Question::sort_by_number_of_dependants( Question.all, "answers" )
    expect(sorted_questions.first.answers.size <= sorted_questions.last.answers.size).to be true 
  end

  it "doesn't expose any questions that don't belong to the current user"
end