Feature:
  In order to start using the service
  As a first time visitor
  I want to register an account

  Scenario: Register an account
    When I visit the home page
    And I click on Register
    And I fill in the form
    Then I should be redirected to Evernote log in
    And a new User should be in the database