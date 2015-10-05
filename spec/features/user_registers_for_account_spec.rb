require 'rails_helper'
  

  feature "user registers for account" do
    scenario "they click on register and see the form on the page" do
      visit new_session_path
      click_link "Register"
      expect(current_path).to eq '/users/new'
      expect(page).to have_field("Confirm Password")
    end
    scenario "they fill in valid info and click submit" do
    end


  end