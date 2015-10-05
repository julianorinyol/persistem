Feature: View Notebooks
  In order to find a specific note, or just browse them by notebook
  As a User
  I want to view a list of my notebooks

  Scenario: View Notebooks
    Given a logged in, synced User
    When I click 'Notebooks'
    Then I should see a list of my notebooks

  Scenario: View Quizzes
    Given a logged in, synced User, with 4 quizzes
    When I click 'Quizzes'
    Then I should see a list of my Quizzes

  Scenario: View Notes
    Given a logged in, synced User
    When I click 'Quizzes'
    And then I click 'Notes'
    Then I should see a list of my Notes