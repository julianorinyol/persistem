Feature: Log In
  In order to access my account
  As a User
  I want to log in

  Scenario: Resistered but unauthenticated User
    Given a registered User that has not yet authenticated with Evernote
    When I visit the login page
    And fill in the form with my details
    Then I should be redirected to an Evernote login page

  Scenario: Resistered and authenticated User
    Given a registerd and authenticated User, with notes in her evernote account
    When I visit the login page
    And fill in the form with my details
    Then I should see a list of my notes
