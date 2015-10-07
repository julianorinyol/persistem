Given(/^I log in$/) do
  set_speed(:slow)
  user = create(:evernote_user, synced: true)
  login_user user.email
  expect(current_path).to eq "/notes"
end

Given(/^I visit the home page$/) do
  visit root_path
end