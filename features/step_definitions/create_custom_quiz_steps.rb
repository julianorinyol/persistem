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

# old version... How can this work, without querying db
  # Given I log in 
  #   And I have 3 "notebooks" 
  #   And I have 6 "notes"
  #   And I have 30 "questions"
  #   When I click "Generate Quiz"
  #   And I select a notebook 
  #   And I click button "Create Quiz"
  #   Then all of the questions should be from that notebook, even though other questions exist