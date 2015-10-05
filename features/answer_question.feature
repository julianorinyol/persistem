Feature: Answer question
  In order to ensure that I have the correct answer saved for reference
  As a User
  I want to submit an answer when I'm viewing my questions

  Scenario: View the answer submission form
    Given a User, viewing Questions
    When I click on a Question
    Then I should see an Answer submission form

  Scenario: Submit an answer
    Given a User, the answer submission form for a Question
    When I fill out the form and click submit
    Then a new Answer should be in the database
    And I should see it in the answer list

  Scenario: Browse Answers
    Given A User, viewing Questions
    When I click on a Question
    Then I should see a list of Answers