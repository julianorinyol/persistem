Given(/^I have notes blablabla$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I go to blablabl$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see blabla$/) do
  pending # express the regexp above with the code you wish you had
end


When(/^I visit the home page$/) do
  visit new_session_path
end

Then(/^I should see the title$/) do
  have_content("Persistem")
end
