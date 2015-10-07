Feature: Take A Quiz
  In order to practise my knowledge, and check my retention
  As a User
  I want to answer the questions on a quiz

  Scenario: I have generated a quiz, and am entering answers
    Given I'm logged in
    When I enter the answer for the first question
    Then A new answer is created in the database
    And I can see the answer when i refresh the page