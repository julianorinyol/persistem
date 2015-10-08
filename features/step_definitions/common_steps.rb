Given(/^I log in$/) do
  set_speed(:medium)
  user = create(:evernote_user, synced: false)
  # create(:notebook, guid: ENV["FIRST_NOTEBOOK_GUID"])
  # create(:notebook, guid: ENV["SECOND_NOTEBOOK_GUID"])
  login_user user.email
  expect(current_path).to eq "/notes"
end

Given(/^I visit the home page$/) do
  visit root_path
end