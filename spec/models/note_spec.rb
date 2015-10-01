require 'rails_helper'

describe Note do
  before(:each) do
    # @user = User.create(
    #   email: 'Donkey@Anderson.com', 
    #   password: 'catcatcat', 
    #   password_confirmation: 'catcatcat',
    #   firstname: 'Donkey', 
    #   lastname: 'Anderson', 
    #   evernote_auth: 'asdfj4fj52'
    # )
    # @notebook = Notebook.create(
    #   guid: '1234dsfa4',
    #   title: 'myNotebook',
    #   user_id: @user.id,
    #   update_sequence_number: 123
    # )
    @user = create(:user)
    @notebook = create(:notebook, user_id: @user.id)
    @note = build(:note, user_id: @user.id, notebook_id: @notebook.id, notebook_guid: @notebook.guid)

    # doing this only because question's factory doesn't work...
    create(:note, user: @user, notebook: @notebook)
  end

   # create_table "users", force: :cascade do |t|
   #    t.string   "email"
   #    t.string   "password_digest"
   #    t.datetime "created_at",                      null: false
   #    t.datetime "updated_at",                      null: false
   #    t.string   "firstname"
   #    t.string   "lastname"
   #    t.string   "evernote_auth"
   #    t.integer  "last_usn"
   #    t.boolean  "synced",          default: false
   #  end


  it "has a valid factory"
  it "is valid with a guid, title, user_id, notebook_guid, notbooke_id, update_sequence_number, and public" do
    expect(@note).to be_valid
  end

  it "is invalid without guid" do
    @note.guid = nil
    @note.valid?
    expect(@note.errors[:guid]).to include("can't be blank")
  end

  it "is invalid without title" do
    @note.title = nil
    @note.valid?
    expect(@note.errors[:title]).to include("can't be blank")
  end

  it "is invalid without user_id" do
    @note.user_id = nil
    @note.valid?
    expect(@note.errors[:user_id]).to include("can't be blank")
  end

  it "is invalid without :notebook_guid" do
    @note.notebook_guid = nil
    @note.valid?
    expect(@note.errors[:notebook_guid]).to include("can't be blank")
  end

  it "is invalid without notebook_id" do
    @note.notebook_id = nil
    @note.valid?
    expect(@note.errors[:notebook_id]).to include("can't be blank")
  end

  it "is invalid without update_sequence_number" do
    @note.update_sequence_number = nil
    @note.valid?
    expect(@note.errors[:update_sequence_number]).to include("can't be blank")
  end

  # it "is invalid without public" do
  #   note = Note.new(
  #     title: 'bla',
  #     guid: 'asdfj324', 
  #     user_id: @user.id, 
  #     notebook_guid: @notebook.guid, 
  #     notebook_id: @notebook.id, 
  #     update_sequence_number: 14, 
  #     public: nil
  #   )
  #   note.valid?
  #   expect(note.errors[:public]).to include("can't be blank")
  # end


  #*********************************Associations**********************************************************# 

  it "has a user that can be accessed" do
    @note.save
    expect(@note.user).to be_a User
  end

  it "has a notebook that can be accessed" do
    @note.save
    expect(@note.notebook).to be_a Notebook
  end

  it "has questions that can be accessed" do
    @note.save
    create(:question, note: @note)
    expect(@note.questions.first).to be_a Question
  end

  it "has answers that can be accessed" do
    @note.save
    question = create(:question, note: @note)
    create(:answer, question: question)
    expect(@note.answers.first).to be_an Answer
  end



  # *********************************Methods************************************************************** #

# is_already_in_db?
  it 'should return true if a record is in the db' do
    note = create(:note)
    expect(note.is_already_in_db?).to be true
    
    note2 = build(:note)
    expect(note2.is_already_in_db?).to be false
  end

#   def get_content note_store, note
  it 'should get content and save it in db '
  # How do we test this?  
  # what the function does...  sends a request to the evernote api, parses it and saves it in the db
  #we could test that it is parsing and saving in the db?  by creating a fake response object...
  #how can we fake the return of an api??
  # 1)create note with no content
# 2)create note_store
#3) call the function, somehow faking the response (even though it's halfway through the function...)
#4)test that the notes content is now updated..

#   def self.parseENML xml_content
  it 'parses ENML' do 
    xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">\r\n\r\n<en-note style=\"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;\"><div><br/></div><div><a href=\"http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday\">http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday</a></div><div><br/></div></en-note>"

    parsed = "<div>\n  <br/>\n</div><div>\n  <a href=\"http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday\">http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday</a>\n</div><div>\n  <br/>\n</div>"
    expect(Note::parseENML(xml)).to eq parsed
  end

  # def self.popular
  # The function should return all the users notes, sorted by how many questions they have. 
  it 'sorts the users notes by how many questions each has' do
    # create_notes(10)
    # # create_questions(100)
    5.times do 
      create(:note, user: @user)
    end
    100.times do 
      # random_note = @user.notes.sample
      create(:question, user: @user)
    end
    sorted_notes = Note::popular(@user)
    expect(sorted_notes[0].questions.size).to be >= sorted_notes[1].questions.size
  end
  # def create_notes amount 
  #   amount.times do 

  #   end
  # end
end


    # note = Note.new(title: 'bla', guid: 'asdf23', user_id: @user.id, notebook_guid: @notebook.guid, notebook_id: @notebook.id, update_sequence_number: 14, public: false)


# def is_already_in_db?
# def get_content note_store, note
# def self.parseENML xml_content
# def self.popular 


  