require 'rails_helper'

describe Notebook do

  before(:each) do
    @user = User.create(
      email: 'Donkey@Anderson.com', 
      password: 'catcatcat', 
      password_confirmation: 'catcatcat',
      firstname: 'Donkey', 
      lastname: 'Anderson', 
      evernote_auth: 'asdfj4fj52'
    )
  end
  
  it "has a valid factory"

  it "is valid with guid, title, user_id, update_sequence_number " do
    notebook = Notebook.new(
      guid: '1234dsfa4',
      title: 'myNotebook',
      user_id: @user.id,
      update_sequence_number: 123
    )
    expect(notebook).to be_valid
  end
  it "is invalid without guid"
  it "is invalid without user_id"
  it "is invalid without update_sequence_number" 
  it "is invalid without title"


  #*********************************Associations**********************************************************# 
  # *********************************Methods************************************************************** #
end


# create_table "notebooks", force: :cascade do |t|
#     t.string  "guid"
#     t.string  "title"
#     t.integer "user_id"
#     t.integer "update_sequence_number"
#   end