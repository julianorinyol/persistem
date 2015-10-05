Feature: Sync With Evernote
  In order to view all my notes
  As a logged in User
  I want to authenticate my account with Evernote

  Scenario: User just registered 
    Given that I just registered for an account
    When  I submit the registration form
    Then I should be redirected to an Evernote log in page

  Scenario: Filling out the Evernote auth page
    Given that Im a registed user on evernote but not yet authed with evernote and I have more than 10 notes in my evernote account
    When I enter my details on the evernote form
    Then I should be redirected to the home page
    And I should see ten of my notes

  Scenario: Checking for specific notes 
    Given that I have authed with Evernote and I have a notes called 'Rails - testing' and 'Rails - command line'
    When I auth with Evernote, and then wait for 10 seconds
    Then I should see a note titled 'Rails - testing'
    And I should see a note titled 'Rails - command line'

  Scenario: Syncing after making changes
    Given that I have authed with Evernote
    When I make a change to a note's title in Evernote
    Then after 10 seconds I should see the new title in Evernote

