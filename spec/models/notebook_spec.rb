require 'rails_helper'

describe Notebook do

  before(:each) do
    @notebook = build(:notebook)
  end
  
  it "is valid with guid, title, user_id, update_sequence_number " do
    expect(@notebook).to be_valid
  end
  it "is invalid without guid" do
    @notebook.guid = nil
    @notebook.valid?
    expect(@notebook.errors[:guid]).to include("can't be blank")    
  end

  it "is invalid without user_id"do
  @notebook.user_id = nil
  @notebook.valid?
  expect(@notebook.errors[:user_id]).to include("can't be blank")
end

  it "is invalid without update_sequence_number" do
    @notebook.update_sequence_number = nil
    @notebook.valid?
    expect(@notebook.errors[:update_sequence_number]).to include("can't be blank")
  end

  it "is invalid without title"do
    @notebook.title = nil
    @notebook.valid?
    expect(@notebook.errors[:title]).to include("can't be blank")
  end

  #*********************************Associations**********************************************************# 
  # belongs_to :user
  # has_many :notes#, inverse_of: :notebook
  # has_many :questions, through: :notes 
  # has_many :answers, through: :questions
  it "belongs to a user that it can access" do
    expect(@notebook.user).to be_a User
  end
  it "has many notes it can access" do
    @notebook.save
    create(:note, notebook: @notebook)
    expect(@notebook.notes.first).to be_a Note
  end
   it "has many questions it can access" do
    @notebook.save
    note = create(:note, notebook: @notebook)
    create(:question, note: note)
    expect(@notebook.questions.first).to be_a Question
  end
  it "has many answers it can access" do
    @notebook.save
    note = create(:note, notebook: @notebook)
    question = create(:question, note: note)
    create(:answer, question: question)
    expect(@notebook.answers.first).to be_an Answer
  end




  # *********************************Methods************************************************************** #
  it "creates new notebooks if they don't exist yet" do
    
  end

  it "updates notebooks that have been changed"

  it "sets the users update_sequence_number to the most recent usn"


  # def self.get_count_of_notes_by_notebook note_store
  it "it returns the amount of notes in each notebook**in what format????"
end
# def self.updateNotebooks(notebooks, current_user)