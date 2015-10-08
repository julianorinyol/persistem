Feature: Answer question
  In order to ensure that I have the correct answer saved for reference
  As a User
  I want to submit an answer when I'm viewing my questions

  Scenario: View the answer submission form
    Given I log in
    And I have 3 questions for each note
    When I view a note
    And I click list questions
    And I click on a question
    Then I see an Answer submission form

  Scenario: Submit an answer
    Given I log in aaa
    When I view the answer submission form for a question
    And I fill out the form and click submit
    Then the answer should be saved in the database
    And I see it in the answer list

  Scenario: Browse Answers
    Given I log in aaa
    When I view questions for a note 
    And I click on a question
    And the question has 5 answers
    Then I see a list of answers