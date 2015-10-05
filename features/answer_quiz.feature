Feature: Take A Quiz
  In order to Practise my Knowledge, and check my retention
  As a User
  I want to answer the questions on a quiz

  Scenario: I have generated a quiz, and am entering answers
    Given that I'm a logged in User with Notes and a generated quiz with 7 questions
    When I enter the answer for the first question
    Then A new answer is created in the database
    And I can see the answer when i refresh the page