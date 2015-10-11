Feature: Create Questions
  In order to test myself on one of my notes
  As a user
  I want to create a question for that note

  Scenario: See the question creation area
    Given I log in 
    When  I click on a note
    Then I see a create question area

  Scenario: Fill in the question creation form
    Given I log in
    When I click on a note 
    And I fill in the "question form" with "Who is baker blue?" and click submit
    And I click list questions
    Then I see "Who is baker blue?"

