Given(/^an authenticated user$/) do
  u = FactoryGirl.create(:user)
  u.update(synced: true)
  visit new_session_path
  binding.pry
  fill_in "Email", with: u.email
  fill_in "Password", with: 'password'
  click_button "Log In"
  # page.driver.browser.authorize u.email, 'password'
  # authorize u.email, "password"
end

When(/^I visit the home page$/) do
  visit notes_path
  binding.pry
  expect(current_path).to eq "/notes"
end

Then(/^I should see my email$/) do
  pending # express the regexp above with the code you wish you had
end
