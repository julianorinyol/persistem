Feature: Create Custom Quizzes
  In order to test myself on specific knowledge
  As a User
  I want to create custom quizzes, including and excluding certain notebooks and timeranges

  Scenario: Create a quiz with only Questions relating to one Notebook
    Given I log in 
    And I have 3 "notebooks" 
    And I have 6 "notes"
    And I have 30 "questions"
    When I select a notebook 
    And I click "Create Quiz"
    Then all of the questions should be from that notebook, even though other questions exist