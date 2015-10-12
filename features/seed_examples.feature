Feature: Seed Examples
  In order to learn how to use the app
  As a newly registered user with no evernotes
  I want to have my account seeded with example notes, notebooks, and questions

  Scenario: I log in as a user with empty evernote account
    Given I log in as a user with empty evernote account
    Then I see 3 notes

  Scenario: Example Notebooks 
    Given I log in as a user with empty evernote account
    When I click "Notebooks" 
    Then I see 2 Notebooks

  Scenario: Create quiz out of samples
    Given I log in as a user with empty evernote account
    When I click "Generate Quiz"
    And I click "Random Questions"
    Then I see 7 questions