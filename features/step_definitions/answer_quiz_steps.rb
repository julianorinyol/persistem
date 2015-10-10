When(/^I enter "(.*?)" as the answer for the first question$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I generate a quiz$/) do
  binding.pry
  click_on("generate-quiz-btn")
  binding.pry
  click_on("generate_quiz_btn")
  binding.pry
end

When(/^I click somewhere else to blur the element$/) do
  binding.pry
end

When(/^I refresh the page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I can see "(.*?)" on the page$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
