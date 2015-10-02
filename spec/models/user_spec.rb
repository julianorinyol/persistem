require 'rails_helper'

describe User do

  before(:each) do
    @user = build(:user)
  end


  it "is valid with an email, password_digest, firstname, lastname, evernote_auth" do
    @user 
    expect(@user).to be_valid
  end
  it "is invalid without a unique email" do 
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include("can't be blank")

    @user.save
    user2 = build(:user, email: @user.email)
    user2.valid?
    expect(user2.errors[:email]).to include("can't be blank")

    user2.email = 'bla@bla.com'
    expect(user2.valid?).to be true
  end

  it "is invalid if password is not confirmed" do 
    @user.password = 'cats'
    @user.password_confirmation = 'dogs'
    @user.valid?
    expect(@user.errors[:password_confirmation]).to include('doesn\'t match Password')
    expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
    @user.password = 'catscats'
    @user.password_confirmation = 'catscats'
    expect(@user.valid?).to be true
  end

  it "is invalid without firstname" do
    @user.firstname = nil
    @user.valid?
    expect(@user.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid without lastname" do
    @user.lastname = nil
    @user.valid?
    expect(@user.errors[:lastname]).to include("can't be blank")
  end


  #*********************************Associations**********************************************************# 

  it "has many notes that can be accessed" do
    @user.save
    notes = []
    5.times do notes << create(:note, user: @user) end
    expect(@user.notes.size).to eq 5
    @user.notes.each do |note|
      expect(note).to be_a Note
    end
  end
  # *********************************Methods************************************************************** #
  class EvernoteSample 
    attr_accessor :guid, :notebookGuid, :title, :updateSequenceNum

    def initialize user
      @guid = rand(1000).to_s
      @notebookGuid = user.notebooks.sample.guid || create(:notebook, user: user).guid
      @title = Faker::Lorem.words(rand(3)+1).join(' ')
      @updateSequenceNum = rand(1000)
    end
  end

   def create_evernote_samples num
    samples = []
    num.times do 
      samples << EvernoteSample.new(@user)
    end
    return samples
   end


   # def update_notes(notes,note_store)
   it "creates new notes if they don't exist yet" do
    @user.save
    @notebook = create(:notebook, user: @user)
    create(:note)
    create(:note)

    number_of_notes_before = @user.notes.size
      evernote_notes = create_evernote_samples(3)

    note_store = double('Note Store')
    # guid, notebookGuid, title, updateSequenceNum

    Note.any_instance.stub(:get_content).and_return('<big><scary>cats</scary></big>')

    @user.update_notes evernote_notes, note_store
    
    number_of_notes = @user.notes.size
    expect(number_of_notes).to be > number_of_notes_before
   end

   it "updates notes that have been changed"

   it "sets the users update_sequence_number to the most recent usn"
   
  #  def update_notes(evernotes, note_store)
  #   evernotes.each do |evernote_note|
  #     note = Note.where(guid: evernote_note.guid).first
  #     if !note
  #       notebook_id = Notebook.where(guid: evernote_note.notebookGuid).first
  #       note = Note.create(user_id: id, notebook_guid: evernote_note.notebookGuid, notebook_id: notebook_id, public: false, guid: evernote_note.guid)
  #     end

  #     note.update(title: evernote_note.title, update_sequence_number: evernote_note.updateSequenceNum)
  #     note.get_content(note_store, note)
  #     self.update(last_usn: evernote_note.updateSequenceNum)
  #   end
  # end
end
  # has_many :notes#, inverse_of: :user
  # has_many :quizzes
  # has_many :notebooks
  # has_many :questions
  # has_many :answers