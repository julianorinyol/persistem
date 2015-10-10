When(/^I click Notebooks$/) do
  find_by_id("notebook-list-tab").click()
end
When(/^I click Quizzes$/) do
  find_by_id("quiz-tab").click()
end
Then(/^I see a list of my notebooks$/) do
  Notebook.all.each do |notebook|
    expect(page).to have_content notebook.title 
  end
end

Given(/^I have (\d+) "(.*?)"$/) do |num, class_name|
    num.to_i.times do 
      create(class_name.singularize.downcase.to_sym)
    end
end


Then(/^I see a list of my Quizzes$/) do
  expect(page).to have_css(".clickable-tr[data-link='/quiz/1']")
  expect(page).to have_css(".clickable-tr[data-link='/quiz/2']")
  expect(page).to have_css(".clickable-tr[data-link='/quiz/3']")
  expect(page).to have_css(".clickable-tr[data-link='/quiz/4']")
  expect(page).to have_content("seconds")
end


When(/^I click Your Notes$/) do
  page.find_by_id("note-list-tab").click()
end

Then(/^I see a list of my Notes$/) do
  Note.all.each do |note|
    expect(page).to have_content(note.title)
  end
end
