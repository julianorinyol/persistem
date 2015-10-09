Given(/^a registered User that has not yet authenticated with Evernote$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I visit the home page$/) do
  # set_speed(:slow)
  visit new_session_path
  expect(current_path).to eq "/sessions/new"
end

When(/^fill in the form with my details$/) do
  user = User.first
  fill_in "Email", with: user[:email]
  fill_in "Password", with: 'password'
  click_button "Log In"
  expect(current_path).to eq "/notes"
  # Capybara.default_max_wait_time = 10
end

Then(/^I should be redirected to an Evernote login page$/) do

  pending # express the regexp above with the code you wish you had
end

Given(/^a registerd and authenticated User, with notes in her evernote account$/) do
  user = FactoryGirl::create(:user)
  user.update(synced: true)
  20.times do 
    FactoryGirl::create(:note)
  end
end

Then(/^I should see Welcome! Get Started$/) do
  expect(page).to have_content("Welcome! Get Started")
end




Given(/^a user with a session already started, has note in account$/) do
  u = FactoryGirl.create(:user)
  u.update(synced: true)
  page.driver.browser.authorize u.email, 'password'
  pending # express the regexp above with the code you wish you had
end

When(/^I visit the root_path$/) do
  visit notes_path
end

Then(/^I should see the notes title$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^a user with a session already started, has (\d+) notes in account$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see (\d+) notes$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
