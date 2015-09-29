require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # TEST      All Notes should have a Guid

# should not save not without user

  test "should not save note without user_id" do
    note = Note.new
    assert_not note.save
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
