Feature: Delete note
  In order simplify my dashboard, and remove sensitive content from the app
  As a User
  I want to delete a note

  Scenario: I delete a note
    Given I log in
    And I have 5 "notes"
    When I view a note
    And I click on delete note
    Then the note is removed from my notes list
    And I am redirected to the main page


  Scenario: Visit a deleted notes show page
    Given I log in
    And I have a deleted note
    When I visit the deleted note's show page
    Then I am redirected to the main page
