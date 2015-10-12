When(/^I select a notebook titled "(.*?)"$/) do |title|
  select title, from: "notebook-select-dropdown"
end

Then(/^all of the questions should be from the notebook "(.*?)", even though other questions exist$/) do |title|
  binding.pry
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
  pending
  # find_by_id("notebook-list-tab").click
  # notebooks = find_all(".notebook-row")
  # notebooks.each do |notebook| 
  #   binding.pry
  #   if notebook.text[0, (notebook.text.length - 2)] == notebook_title
  #     the_one = notebook
  #     break
  #   end
  # end
  # the_one.click
  # notes = find_all(".clickable-tr")
  # notes.sample.click
  # binding.pry
end

Given(/^I create (\d+) notes for each of the other notebooks$/) do |num|
  binding.pry
  pending
end

Then(/^I should see (\d+) notes with the text "(.*?)"$/) do |arg1, arg2|
  binding.pry
  pending  
end
