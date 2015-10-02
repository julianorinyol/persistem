require 'rails_helper'

describe Answer do

  before(:each) do
    @answer = build(:answer)
  end
  # create_table "answers", force: :cascade do |t|
  #   t.integer  "note_id"
  #   t.integer  "subject_id"
  #   t.integer  "user_id"
  #   t.integer  "question_id"
  #   t.string   "text"
  #   t.datetime "created_at",  null: false
  #   t.datetime "updated_at",  null: false
  #   t.integer  "quiz_id"
  # end

  #*********************************Validations**********************************************************# 
   it { is_expected.to validate_presence_of :text }
   it { is_expected.to validate_presence_of :user_id }
   it { is_expected.to validate_presence_of :question_id }


  # it "is valid with an question_id, text, user_id" do
  #   expect(@answer).to be_valid
  # end

  #*********************************Associations**********************************************************# 
  # belongs_to :question
  # belongs_to :user
  # delegate :note, :to => :question
  # delegate :notebook, :to => :note
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:question) }

  # *********************************Methods************************************************************** #

end