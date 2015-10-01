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


   # def update_notes(notes,note_store)
   it "creates new notes if they don't exist yet"

   it "updates notes that have been changed"

   it "sets the users update_sequence_number to the most recent usn"
   
end
  # has_many :notes#, inverse_of: :user
  # has_many :quizzes
  # has_many :notebooks
  # has_many :questions
  # has_many :answers