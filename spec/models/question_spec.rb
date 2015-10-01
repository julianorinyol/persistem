require 'rails_helper'

describe Question do

  before(:each) do
    @question = build(:question)
  end

  #*********************************Validations**********************************************************# 
  # create_table "questions", force: :cascade do |t|
  #   t.integer  "note_id"
  #   t.string   "text"
  #   t.integer  "subject_id"
  #   t.integer  "user_id"
  #   t.integer  "answer_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end

  # it "is valid with an email, password_digest, firstname, lastname, evernote_auth" do
  #   @user 
  #   expect(@user).to be_valid
  # end
  # it "is invalid without a unique email" do 
  #   @user.email = nil
  #   @user.valid?
  #   expect(@user.errors[:email]).to include("can't be blank")

  #   @user.save
  #   user2 = build(:user, email: @user.email)
  #   user2.valid?
  #   expect(user2.errors[:email]).to include("can't be blank")

  #   user2.email = 'bla@bla.com'
  #   expect(user2.valid?).to be true
  # end


  #*********************************Associations**********************************************************# 

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
  
  # def self.sort_by_popularity questions


end