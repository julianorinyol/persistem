require 'rails_helper'

describe Note do
  before(:each) do
    @user = create(:user)
    @notebook = create(:notebook, user_id: @user.id)
    @note = build(:note, user_id: @user.id, notebook_id: @notebook.id, notebook_guid: @notebook.guid)

    # doing this only because question's factory doesn't work...
    create(:note, user: @user, notebook: @notebook)
  end


  it "is valid with a guid, title, user_id, notebook_guid, notbooke_id, update_sequence_number, and public" do
    expect(@note).to be_valid
  end

  it { is_expected.to validate_presence_of :guid }

  it { is_expected.to validate_presence_of :title }

  it { is_expected.to validate_presence_of :user_id }

  it { is_expected.to validate_presence_of :notebook_guid }
 
  it { is_expected.to validate_presence_of :notebook_id }

  it { is_expected.to validate_presence_of :update_sequence_number }

  
  it "do i need to test public???"
  #*********************************Associations**********************************************************# 

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:notebook) }
  it { is_expected.to have_many(:questions) }
  it { is_expected.to have_many(:answers) }

  # *********************************Methods************************************************************** #

# is_already_in_db?
  it 'should return true if a record is in the db' do
    note = create(:note)
    expect(note.is_already_in_db?).to be true
    
    note2 = build(:note)
    expect(note2.is_already_in_db?).to be false
  end

#   def get_content note_store, note
  it 'gets content and save it in db ' do
    xml_sample = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">\r\n\r\n<en-note style=\"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;\"><div><br/></div><div><a href=\"http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday\">http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday</a></div><div><br/></div></en-note>"
   parsed_xml_sample = "<div>\n  <br/>\n</div><div>\n  <a href=\"http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday\">http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday</a>\n</div><div>\n  <br/>\n</div>"

    @note.content = '<header>OverWriteME</header><main>this content should be overwritten!</main>'
    @note.save
    note_store = double('Note Store', getNoteContent: xml_sample)

    @note.get_content note_store, @note
    expect(@note.content).to eq parsed_xml_sample
    
  end

#   def get_content note_store, note
  it "contacts the evernote api for real and gets note content and saves to db" do
  # Write a test that accesses the sandbox!  Or should this type of test go in controller tests??
    user = create(:user, email: "persistemsample@gmail.com", evernote_auth: ENV["TEST_AUTH_TOKEN"])
    notebook = create(:notebook, guid: "93658a6c-ef7b-4511-8890-b767ea5b9ca9")
    note = create(:note, user: user, content: "<div>this should get updated by the function!</div>", guid: "77526061-74e7-4cfb-b5f4-8c751edc75d2", notebook: notebook, notebook_guid: "93658a6c-ef7b-4511-8890-b767ea5b9ca9")
    token = user.evernote_auth
    client = EvernoteOAuth::Client.new(token: token)
    note_store = client.note_store
    note.get_content(note_store, note)
    #this is the actual note content in persistemsample@gmail.com's sandbox.evernote account, if changed, this will fail.. 
    expect(note.content).to eq "<div>note content   lalalalla</div><div>laasdf</div>"
  end

#   def self.parseENML xml_content
  it 'parses ENML' do 
    xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">\r\n\r\n<en-note style=\"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;\"><div><br/></div><div><a href=\"http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday\">http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday</a></div><div><br/></div></en-note>"

    parsed = "<div>\n  <br/>\n</div><div>\n  <a href=\"http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday\">http://en.wikipedia.org/wiki/Doomsday_rule#Finding_a_year.27s_Doomsday</a>\n</div><div>\n  <br/>\n</div>"
    expect(Note::parseENML(xml)).to eq parsed
  end

  # def self.popular
  # The function should return all the users notes, sorted by how many questions they have. 
  it 'sorts the users notes by how many questions each has' do
    5.times do 
      create(:note, user: @user)
    end
    100.times do 
      create(:question, user: @user)
    end
    sorted_notes = Note::popular(@user)
    expect(sorted_notes[0].questions.size).to be >= sorted_notes[1].questions.size
  end

  it "doesn't return any notes that don't belong to the current user"

end

  