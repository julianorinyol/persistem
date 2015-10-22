Given(/^I log in as a user with no data$/) do
  user = create(:empty_user, synced: false)
  login_user user.email
  expect(current_path).to eq "/notes"
end

Then(/^I see (\d+) notes$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I click on "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I see (\d+) notebooks$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I see (\d+) questions$/) do |num|
  questions = find_all(".question-text")
  expect(questions.size).to eq num
end
