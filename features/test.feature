Feature: Test Cucumber
  In order choose where to navigate
  As an user
  I want to view the homepage

  Scenario: unauthed site visitor
    When  I visit the home page
    Then I should see the title
