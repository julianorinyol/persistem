require 'rails_helper'

describe User do

  def setup
  end

  it "has a valid factory"

  it "is valid with an email, password_digest, firstname, lastname, evernote_auth" do
    user = User.new(
      email: 'Donkey@Anderson.com', 
      password: 'catcatcat', 
      password_confirmation: 'catcatcat',
      firstname: 'Donkey', 
      lastname: 'Anderson', 
      evernote_auth: 'asdfj4fj52'
    )
    expect(user).to be_valid
  end
  it "is invalid without email"
  it "is invalid without password"
  it "is invalid without password_confirmation"
  it "is invalid without firstname"
  it "is invalid without lastname"


  #*********************************Associations**********************************************************# 
  # *********************************Methods************************************************************** #
end
