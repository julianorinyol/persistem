Feature: Create Custom Quizzes
  In order to test myself on specific knowledge
  As a User
  I want to create custom quizzes, including and excluding certain notebooks and timeranges

  Scenario: Create a quiz with only Questions relating to one Notebook
    Given I log in 
      And I have 3 "notebooks" 
      And I have 6 "notes"
      And I have 30 "questions"
      When I click "Generate Quiz"
      And I select a notebook titled "Rails" 
      And I click button "Create Quiz"
      Then all of the questions should be from the notebook "Rails", even though other questions exist

  Scenario: Create a quiz with only Questions relating to two Notebooks
    Given I log in
      And I have a "notebook" titled "Rails"
      And I have 2 "notebooks"
      And I have 10 "notes"
      And I create 5 questions for the notebook: "Rails" with text "question from notebook Rails"
      And I create 3 notes for each of the other notebooks
      When I click "Generate Quiz"
      And I select a notebook titled "Rails"
      And I click button "Create Quiz"
      Then I should see 5 notes with the text "question from notebook Rails"

  Scenario: Create a quiz with questions from the previous week

  Scenario: Create a quiz with the most popular questions

