Feature: Log In
  In order to access my account
  As a User
  I want to log in

  Scenario: Resistered but unauthenticated User
    Given a registered User that has not yet authenticated with Evernote
    When I visit the home page
    And fill in the form with my details
    Then I should be redirected to an Evernote login page

  Scenario: Resistered and authenticated User
    Given a registerd and authenticated User, with notes in her evernote account
    When I visit the login page
    And fill in the form with my details
    Then I should see Welcome! Get Started

  Scenario: Logged in User, already has session, revisting the page
    Given a user with a session already started, has note in account
    When I visit the root_path 
    Then  I should see the notes title


  Scenario: Logged in User, already has session, revisting the page
    Given a user with a session already started, has 20 notes in account
    When I visit the root_path 
    Then  I should see 20 notes