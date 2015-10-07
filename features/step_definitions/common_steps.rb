Given(/^I'm logged in$/) do
  binding.pry
  # user = 
  login_user
end

Given(/^I visit the home page$/) do
  visit root_path
end