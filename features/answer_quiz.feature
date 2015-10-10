Feature: Take A Quiz
  In order to practise my knowledge, and check my retention
  As a User
  I want to answer the questions on a quiz

  Scenario: I have generated a quiz, and am entering answers
    Given I log in 
    And I have 10 "questions"
    When I generate a quiz 
    And I enter "YOYOYO blablaba" as the answer for the first question
    And I click somewhere else to blur the element
    And I refresh the page
    Then I can see "YOYOYO blablaba" on the page