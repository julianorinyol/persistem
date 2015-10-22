Feature: Sample Data
  In order to test out the app
  As a user 
  I want to see example notes, notebooks, and questions

  Scenario: Log in and see sample data
    Given I log in as a user with no data
    Then I see 5 notes
    When I click on "Notebooks"
    Then I see 2 notebooks

  Scenario: Generate a quiz out of sample questions
    Given I log in as a user with no data
    When I click "Generate Quiz"
    And I click "Least Answered"
    Then I see 7 questions

