Feature: Create Custom Quizzes
  In order to test myself on specific knowledge
  As a User
  I want to create custom quizzes, including and excluding certain notebooks and timeranges


  Scenario: Click on Create a Quiz and see the quiz generation page
    Given a logged in User
    When I click 'Generate Quiz'
    Then I should see "Generate a quiz to test your knowledge"

  Scenario: Create a quiz with only Questions relating to one Notebook
    Given a User, with many Notebooks, Notes, and Questions
    When I select a notebook 
    And click "Create Quiz"
    Then all of the questions should be from that notebook, even though other questions exist