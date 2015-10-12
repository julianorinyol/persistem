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