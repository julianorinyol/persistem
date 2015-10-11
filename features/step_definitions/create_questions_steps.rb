When(/^I click on a note$/) do
  find_all("#private-notes-list .clickable-tr").sample.click()
end

Then(/^I see a create question area$/) do
  expect(page).to have_field "question_text"
end
