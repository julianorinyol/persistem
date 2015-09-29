require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # TEST      All Notes should have a Guid


# *************************************************** Validations ***************************************************
  # validates :guid, :title, :user_id, :notebook_guid, :notebook_id, :update_sequence_number, presence: true
  # validates :public, inclusion: { in: [true, false] }
  test "should not save note without guid" do
    note = Note.new(title: 'bla', user_id: 1, notebook_guid: 'g34q', notebook_id: 1, update_sequence_number: 14, public: false)
    assert_not note.save, "Saved the note without a guid"
  end
  test "should not save note without title" do
    note = Note.new(guid: 12, user_id: 1, notebook_guid: 'g34q', notebook_id: 1, update_sequence_number: 14, public: false)
    assert_not note.save, "Saved the note without a title"
  end
  test "should not save note without user_id" do
    note = Note.new(guid: 12, title: 'bla', notebook_guid: 'g34q', notebook_id: 1, update_sequence_number: 14, public: false)
    assert_not note.save, "Saved the note without a user_id"
  end
  test "should not save note without :notebook_guid" do
    note = Note.new(guid: 12, title: 'bla', user_id: 1, notebook_id: 1, update_sequence_number: 14, public: false)
    assert_not note.save, "Saved the note without a :notebook_guid"
  end
  test "should not save note without notebook_id" do
    note = Note.new(guid: 12, title: 'bla', user_id: 1, notebook_guid: 'g34q', update_sequence_number: 14, public: false)
    assert_not note.save, "Saved the note without a notebook_id"
  end
  test "should not save note without update_sequence_number" do
    note = Note.new(guid: 12, title: 'bla', user_id: 1, notebook_guid: 'g34q', notebook_id: 1, public: false)
    assert_not note.save, "Saved the note without a update_sequence_number"
  end
  test "should not save note without public" do
    note = Note.new(guid: 12, title: 'bla', user_id: 1, notebook_guid: 'g34q', notebook_id: 1, update_sequence_number: 14)
    assert_not note.save, "Saved the note without public"
  end

# causing issues, boolean columns will cast non-booleans as false. in rails 5 , they will be cast as true...
  # test "should not save note with public as not false or true" do
  #   note = Note.new(guid: 12, title: 'bla', user_id: 1, notebook_guid: 'g34q', notebook_id: 1, update_sequence_number: 14, public: 'cat')
  #   assert_not note.save, "Saved the note with public as a string"
  # end



# *************************************************** Methods ***************************************************

# is_already_in_db?
  test 'should return false if a record is in the db...' do
  
  end
#   def get_content note_store, note
  test 'should get content and save it in db ' do

  end

#   def self.parseENML xml_content
  test 'should parse the ENML' do

  end

#   def self.popular 
  test 'should return all the users\'s notes, sorted by how many questions they have' do 

  end

#   def self.popular 
  test 'should only include the users notes' do

  end

#   def self.updateNotes(notes, current_user, note_store)
  test 'should update the users last usn' do

  end

#   def self.updateNotes(notes, current_user, note_store)
  test 'should create a note if one with that guid doesn\'t exist yet ' do

  end
#  
#   def self.updateNotes(notes, current_user, note_store)
  test 'should update a notes title if it already exists' do 

  end
end


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
