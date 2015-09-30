require 'rails_helper'

describe Note do

  before(:each) do
    @user = User.create(
      email: 'Donkey@Anderson.com', 
      password: 'catcatcat', 
      password_confirmation: 'catcatcat',
      firstname: 'Donkey', 
      lastname: 'Anderson', 
      evernote_auth: 'asdfj4fj52'
    )
    @notebook = Notebook.create(
      guid: '1234dsfa4',
      title: 'myNotebook',
      user_id: @user.id,
      update_sequence_number: 123
    )
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
    note = Note.new(
      title: 'bla',
      guid: 'asdf23', 
      user_id: @user.id, 
      notebook_guid: @notebook.guid, 
      notebook_id: @notebook.id, 
      update_sequence_number: 14, 
      public: false
    )
    expect(note).to be_valid
  end

  it "is invalid without guid" do
    note = Note.new(
      title: 'bla',
      guid: nil, 
      user_id: @user.id, 
      notebook_guid: @notebook.guid, 
      notebook_id: @notebook.id, 
      update_sequence_number: 14, 
      public: false
    )
    note.valid?
    expect(note.errors[:guid]).to include("can't be blank")
  end

  it "is invalid without title" do
    note = Note.new(
      title: nil,
      guid: 'asdfj324', 
      user_id: @user.id, 
      notebook_guid: @notebook.guid, 
      notebook_id: @notebook.id, 
      update_sequence_number: 14, 
      public: false
    )
    note.valid?
    expect(note.errors[:title]).to include("can't be blank")
  end

  it "is invalid without user_id" do
    note = Note.new(
      title: 'bla',
      guid: 'asdfj324', 
      user_id: nil, 
      notebook_guid: @notebook.guid, 
      notebook_id: @notebook.id, 
      update_sequence_number: 14, 
      public: false
    )
    note.valid?
    expect(note.errors[:user_id]).to include("can't be blank")
  end

  it "is invalid without :notebook_guid" do
    note = Note.new(
      title: 'bla',
      guid: 'asdfj324', 
      user_id: @user.id, 
      notebook_guid: nil, 
      notebook_id: @notebook.id, 
      update_sequence_number: 14, 
      public: false
    )
    note.valid?
    expect(note.errors[:notebook_guid]).to include("can't be blank")
  end

  it "is invalid without notebook_id" do
    note = Note.new(
      title: 'bla',
      guid: 'asdfj324', 
      user_id: @user.id, 
      notebook_guid: @notebook.guid, 
      notebook_id: nil, 
      update_sequence_number: 14, 
      public: false
    )
    note.valid?
    expect(note.errors[:notebook_id]).to include("can't be blank")
  end

  it "is invalid without update_sequence_number" do
    note = Note.new(
      title: 'bla',
      guid: 'asdfj324', 
      user_id: @user.id, 
      notebook_guid: @notebook.guid, 
      notebook_id: @notebook.id, 
      update_sequence_number: nil, 
      public: false
    )
    note.valid?
    expect(note.errors[:update_sequence_number]).to include("can't be blank")
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


  it "is invalid without a user" 
  it "is invalid without a notebook"


  # *********************************Methods************************************************************** #

# is_already_in_db?
  it 'should return true if a record is in the db' do
    User.create()
    note = Note.create(
      title: 'bla',
      guid: 'asdf23', 
      user_id: @user.id, 
      notebook_guid: @notebook.guid, 
      notebook_id: @notebook.id, 
      update_sequence_number: 14, 
      public: false
    )
    expect(note.is_already_in_db?).to be true
    
    note2 = Note.new(
      title: 'blaasdfa',
      guid: 'asdf23fd', 
      user_id: @user.id, 
      notebook_guid: @notebook.guid, 
      notebook_id: @notebook.id, 
      update_sequence_number: 14, 
      public: false
    )
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
  it 'should parse the ENML' do 
    xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">\r\n\r\n<en-note style=\"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;\"><div><br/></div><div><a href=\"http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday\">http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday</a></div><div><br/></div></en-note>"

    parsed = "<div>\n  <br/>\n</div><div>\n  <a href=\"http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday\">http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday</a>\n</div><div>\n  <br/>\n</div>"
    expect(Note::parseENML(xml)).to eq parsed
  end

#   def self.updateNotes(notes, current_user, note_store)
  it 'should update the users last usn'

#   def self.updateNotes(notes, current_user, note_store)
  it 'should create a note if one with that guid doesn\'t exist yet '

#   def self.updateNotes(notes, current_user, note_store)
  it 'should update a notes title if it already exists'

end


    # note = Note.new(title: 'bla', guid: 'asdf23', user_id: @user.id, notebook_guid: @notebook.guid, notebook_id: @notebook.id, update_sequence_number: 14, public: false)


# def is_already_in_db?
# def get_content note_store, note
# def self.parseENML xml_content
# def self.popular 
# def self.updateNotes(notes, current_user, note_store)


  # belongs_to :user
  # has_many :subjects
  # has_many :questions
  # belongs_to :notebook
  # has_many :answers, through: :questions


   # create_table "notes", force: :cascade do |t|
  #   t.datetime "created_at",             null: false
  #   t.datetime "updated_at",             null: false
  #   t.string   "content"
  #   t.integer  "user_id"
  #   t.boolean  "public"
  #   t.integer  "subject_id"
  #   t.string   "title"
  #   t.string   "guid"
  #   t.string   "notebook_guid"
  #   t.integer  "notebook_id"
  #   t.integer  "update_sequence_number"
  # end





  # create_table "notebooks", force: :cascade do |t|
  #     t.string  "guid"
  #     t.string  "title"
  #     t.integer "user_id"
  #     t.integer "update_sequence_number"
  #   end
  # create_table "users", force: :cascade do |t|
  #     t.string   "email"
  #     t.string   "password_digest"
  #     t.datetime "created_at",                      null: false
  #     t.datetime "updated_at",                      null: false
  #     t.string   "firstname"
  #     t.string   "lastname"
  #     t.string   "evernote_auth"
  #     t.integer  "last_usn"
  #     t.boolean  "synced",          default: false
  #   end