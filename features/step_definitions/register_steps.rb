When(/^I click on Register$/) do
  click_link('Register')
  expect(current_path).to eq '/users/new' 
end

When(/^I fill in the form$/) do
  attrs = FactoryGirl::attributes_for(:user)
  fill_in "Email", with: attrs[:email]
  fill_in "First Name", with: attrs[:firstname]
  fill_in "Last Name", with: attrs[:lastname]
  fill_in "Password", with: attrs[:password]
  fill_in "Confirm Password", with: attrs[:password]
  pending
  click_button "Register Now"

end

Then(/^I should be redirected to Evernote log in$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^a new User should be in the database$/) do
  pending # express the regexp above with the code you wish you had
end
