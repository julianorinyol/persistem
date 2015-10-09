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
  first(:css, ".clickable-tr").click()
  find_by_id("list-questions-tab").click()
  first(:css, ".question-clickable-tr").click()
  expect(has_field? 'answer_text').to be true
end

Then(/^the answer should be saved in the database$/) do
  expect(@text_to_check)
end

Then(/^I see an Answer submission form$/) do
  expect(page).to have_field("answer_text")
end

When(/^I view questions for a note$/) do
  page.first(:css, ".clickable-tr").click()
  find_by_id("list-questions-tab").click()
end

Then(/^I see a list of answers$/) do
  expect(find_all(".answer").size).to eq 5
end
