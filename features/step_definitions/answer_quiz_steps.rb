When(/^I enter "(.*?)" as the answer for the first question$/) do |text|
  #quiz-show-container > textarea:nth-child(2)
  Capybara.default_max_wait_time = 7
  sleep 7
  first(".quiz-answer-submit-text").set(text)
end

When(/^I generate a quiz$/) do
  click_on("generate-quiz-btn")
  click_on("generate_quiz_btn")
end

When(/^I click somewhere else to blur the element$/) do
  x = find_all(".quiz-answer-submit-text")
  x[2].click()
end

When(/^I refresh the page$/) do
  visit current_path
end

Then(/^I can see "(.*?)" on the page$/) do |text|
  expect(page).to have_content(text)
  Capybara.default_max_wait_time = 2 
end
