Given(/^I log in$/) do
  # set_speed(:medium)
  user = create(:evernote_user, synced: false)
  login_user user.email
  expect(current_path).to eq "/notes"
end

Given(/^I visit the home page$/) do
  visit root_path
end

Given(/^I have (\d+) "(.*?)"$/) do |num, class_name|
    num.to_i.times do 
      create(class_name.singularize.downcase.to_sym)
    end
end

# good for one field forms only....
When(/^I fill in the "(.*?)" with "(.*?)" and click submit$/) do |form_name, text|
  field_id = {answerform:"answer_text", questionform: "question_text"}[form_name.gsub(/\s+/, "").to_sym]
  fill_in field_id, with: text

  submit_id = {answerform:'create-answer-button', questionform: "create-question-button"}[form_name.gsub(/\s+/, "").to_sym]
  find_by_id(submit_id).click()
end

Then(/^"(.*?)" is listed on the page$/) do |text|
  expect(page).to have_content(text)
end

#     And each "question" has 5 "answers"
Given(/^each "(.*?)" has (\d+) "(.*?)"$/) do |parent_class, quantity, child_class|
# remove the last letter.. an  s..
  child_class = child_class[0..(child_class.length - 2)]
  Object.const_get(parent_class.titleize).all.each do |obj|
    quantity.to_i.times do
      id = parent_class + "_id"
      id = id.to_sym
      create(child_class.to_sym, "#{id}": obj.id )
    end
  end
end

Then(/^I see "(.*?)"$/) do |text|
  expect(page).to have_content text
end

When(/^I click "(.*?)"$/) do |button_text|
  expect(page).to have_content(button_text)
  click_on(button_text)
end

When(/^I click button "(.*?)"$/) do |button_text|
  expect(page).to have_button(button_text)
  click_on(button_text)
end

Then(/^I see (\d+) notes$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end