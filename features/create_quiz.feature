Feature: Create Quiz
  In order to test my knowledge
  As a User
  I want to generate a quiz

  Scenario: Quiz of random questions
    Given a User, with 100 questions
    When I click 'Generate Quiz'
    And I click 'Random Questions'
    Then i should see a random set of questions

  Scenario: Quiz of least answered questions
    Given a User, with 100 questions, with 1000 answers randomly distributed between them
    When I click 'Generate Quiz'
    And I click 'Least Answered'
    Then I should see the 7 questions that have the least amount of answers out of all of my questions.