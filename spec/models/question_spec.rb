require 'rails_helper'

describe Question do

  before(:each) do
    @question = build(:question)
  end

  #*********************************Validations**********************************************************# 

  # it "is valid with an email, password_digest, firstname, lastname, evernote_auth" do
  #   @user 
  #   expect(@user).to be_valid
  # end
  # it "is invalid without a unique email" do 
  #   @user.email = nil
  #   @user.valid?
  #   expect(@user.errors[:email]).to include("can't be blank")

  #   @user.save
  #   user2 = build(:user, email: @user.email)
  #   user2.valid?
  #   expect(user2.errors[:email]).to include("can't be blank")

  #   user2.email = 'bla@bla.com'
  #   expect(user2.valid?).to be true
  # end


  #*********************************Associations**********************************************************# 

  # *********************************Methods************************************************************** #

end