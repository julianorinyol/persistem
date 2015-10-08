When(/^I view a note$/) do
  page.first(:css, ".clickable-tr").click()
end

Given(/^I have (\d+) questions for each note$/) do |num|
  notes = Note.all
  num.to_i.times do
    notes.each do |note|
      create(:question, note_id: note.id )
    end
  end
end



When(/^I click list questions$/) do
  find_by_id("list-questions-tab").click()
end

When(/^I click on a question$/) do
  first(:css, ".question-clickable-tr").click()
end

When(/^I view the answer submission form for a question$/) do
  pending # express the regexp above with the code you wish you had

end

When(/^I fill out the form and click submit$/) do
  fill_in "answer_text", with: 'answer ' + Faker::Lorem.words(4)
  binding.pry
end

Then(/^the answer should be saved in the database$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I click on a Question$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^the question has (\d+) answers$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I see an Answer submission form$/) do
  expect(page).to have_field("answer_text")
end

Then(/^I see it in the answer list$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I view questions for a note$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I see a list of answers$/) do
  pending # express the regexp above with the code you wish you had
end
