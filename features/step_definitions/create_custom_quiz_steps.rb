When(/^I select a notebook titled "(.*?)"$/) do |title|
  select title, from: "notebook-select-dropdown"
end

Then(/^all of the questions should be from the notebook "(.*?)", even though other questions exist$/) do |title|
  questions = find_all("#quiz-show-container p")
  question_texts = questions.map do |q| q.text  end
  notebook = Notebook.find_by_title(title)
  question_texts.each do |text|
    question = Question.find_by_text(text)
    expect(question.note.notebook_id).to eq notebook.id
  end
end

Given(/^I have a "(.*?)" titled "(.*?)"$/) do |model, title|
  find_by_id("notebook-list-tab").click
  if !has_content?(title)
    create(model.to_sym, title: title)
  end
end

Given(/^I create (\d+) questions for the notebook: "(.*?)" with text "(.*?)"$/) do |num, notebook_title, question_text|
  binding.pry
end

Given(/^I create (\d+) notes for each of the other notebooks$/) do |num|
  binding.pry
end

Then(/^I should see (\d+) notes with the text "(.*?)"$/) do |arg1, arg2|
  binding.pry  
end
