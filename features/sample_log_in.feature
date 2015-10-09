Feature: Log In On Sample Account
  In order to test out the app
  As a site visitor
  I want to log in on a sample account

  Scenario: Log in on sample account
    Given I visit the home page
    When I click "Log in on demo account"
    Then I see 10 notes