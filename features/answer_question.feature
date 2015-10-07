Feature: Answer question
  In order to ensure that I have the correct answer saved for reference
  As a User
  I want to submit an answer when I'm viewing my questions

  Scenario: View the answer submission form
    Given I'm logged in
    When I view a note
    And I click list questions
    And I click on a question
    Then I should see an Answer submission form

  Scenario: Submit an answer
    Given I'm logged in 
    When I view the answer submission form for a question
    And I fill out the form and click submit
    Then the answer should be saved in the database
    And I should see it in the answer list

  Scenario: Browse Answers
    Given I'm logged in 
    When I'm viewing questions for a note 
    And I click on a question
    And the question has 5 answers
    Then I should see a list of Answers