Feature: View Notebooks
  In order to find a specific note, or just browse my notes by notebook
  As a logged in user
  I want to view a list of my notebooks

  Scenario: View Notebooks
    Given I log in
    When I click Notebooks
    Then I see a list of my notebooks

  Scenario: View Quizzes
    Given I log in
    And I have 4 "Quizzes"
    When I click Quizzes
    Then I see a list of my Quizzes

  Scenario: View Notes
    Given I log in
    When I click Quizzes
    And I click Your Notes
    Then I see a list of my Notes