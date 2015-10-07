Feature: Test Cucumber
  In order to see my notes 
  As an authenticated user
  I visit the home page

  Scenario: authenticated user
    Given an authenticated user 
    When  I visit the home page
    Then I should see my email
