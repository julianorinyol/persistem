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
  class EvernotebookSample 
    attr_accessor :guid, :name, :updateSequenceNum

    def initialize user, guid=false
      @name = Faker::Lorem.words(rand(3)+1).join(' ')
      @updateSequenceNum = rand(1000)
      @guid = guid || rand(1000).to_s
    end
  end

   def create_evernotebook_samples num, updating=nil
    samples = []
    num.times do 
      if updating
        samples << EvernotebookSample.new(@user, @user.notebooks.sample.guid)
      else
        samples << EvernotebookSample.new(@user)
      end
    end
    return samples
   end

# def self.updateNotebooks(notebooks, current_user)
  it "creates new notebooks if they don't exist yet" do
    @notebook.save
    @user = @notebook.user
    number_of_notebooks_before = @user.notebooks.size
    evernote_notebooks = create_evernotebook_samples(3)
    Notebook::updateNotebooks(evernote_notebooks, @user)
    number_of_notebooks = @user.notebooks.size
    expect(number_of_notebooks).to be > number_of_notebooks_before
  end
  # def self.updateNotebooks(notebooks, current_user)
  #   notebooks.each do |notebook|
  #     n = Notebook.where(guid: notebook.guid).first
  #     if !n
  #       n = Notebook.new(user_id: current_user.id, guid: notebook.guid)
  #     end
  #     n.update(title: notebook.name, update_sequence_number: notebook.updateSequenceNum)
  #     current_user.update(last_usn: notebook.updateSequenceNum)
  #   end 
  # end

  it "updates notebooks that have been changed" do
    @notebook.save
    create(:notebook, title: 'cats')
    create(:notebook, title: 'donkeys')
    @user = @notebook.user
    number_of_notebooks_before = @user.notebooks.size
    evernote_notebooks = create_evernotebook_samples(3,true)
    Notebook::updateNotebooks(evernote_notebooks, @user)
    number_of_notebooks = @user.notebooks.size
    expect(number_of_notebooks).to eq number_of_notebooks_before
    changed_notebooks = Notebook.where(update_sequence_number: [evernote_notebooks[0].updateSequenceNum, evernote_notebooks[1].updateSequenceNum,evernote_notebooks[2].updateSequenceNum])
    changed_notebooks.each do |notebook|
      expect(notebook.title).not_to eq 'cats'
      expect(notebook.title).not_to eq 'donkeys'
    end
  end

  # it "updates notes that have been changed" do
  #     @user.save
  #     @notebook = create(:notebook, user: @user)
      
  #     # this actually just blocks the code that would otherwise break because the notestore isnt real, and the evernote doesn't have content.
  #     Note.any_instance.stub(:get_content).and_return('')

  #     create(:note)
  #     create(:note)
  #     number_of_notes_before = @user.notes.size
  #     evernote_notes = create_evernote_samples(2, true)
  #     number_of_notes = @user.notes.size
  #     expect(number_of_notes).to eq number_of_notes_before
  #     # expect that an instance of the note class will receive call to get_content...
  #   end

  it "sets the users update_sequence_number to the last usn" do 
    @notebook.save
    create(:notebook, title: 'donkeys')
    @user = @notebook.user
    evernote_notebooks = create_evernotebook_samples(3,true)
    Notebook::updateNotebooks(evernote_notebooks, @user)
    expect(@user.last_usn).to be evernote_notebooks.last.updateSequenceNum
  end


  # def self.get_count_of_notes_by_notebook note_store
  it "it returns the amount of notes in each notebook**in what format????" do
    user = create(:user, email: "persistemsample@gmail.com", evernote_auth: ENV["TEST_AUTH_TOKEN"])
    notebook = create(:notebook, guid: "93658a6c-ef7b-4511-8890-b767ea5b9ca9", user: user)
    notebook2 = create(:notebook, guid: "ca669dca-b708-46fe-a034-41d00535051e", user: user)

    note = create(:note, user: user, content: "<div>this should get updated by the function!</div>", guid: "77526061-74e7-4cfb-b5f4-8c751edc75d2", notebook: notebook, notebook_guid: "93658a6c-ef7b-4511-8890-b767ea5b9ca9")
    note = create(:note, user: user, content: "<div>this should get updated by the function!</div>", guid: "ef2b15f4-998e-4dce-81cc-d361d8f4c4ba", notebook: notebook2, notebook_guid: "ca669dca-b708-46fe-a034-41d00535051e")

    token = user.evernote_auth
    client = EvernoteOAuth::Client.new(token: token)
    
    note_store = client.note_store

    evernote_notebook_count = Notebook::get_count_of_notes_by_notebook note_store
    counts = evernote_notebook_count.notebookCounts
    user.notebooks.each do |nb|
      expect(counts[nb.guid]).to eq nb.notes.size
    end
  end

  it "doesn't expose any notebooks that don't belong to the current user "

end