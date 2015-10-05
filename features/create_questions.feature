Feature: Create Questions
  In order to test myself on one of my notes
  As an user
  I want to create a question for that note

  Scenario: See the question creation area
    Given a User with Notes 
    When  I click on a note
    Then I should see a create question area

  Scenario: Fill in the question creation form
    Given a User with Notes, viewing a Note
    When I type in a question and click submit
    Then A new question should be in the database

