module LoginHelpers

  def logout_and_login_user(email, password = "password")
    logout() if @current_user
    login_user(email, password)
  end

  def login_user(email, password = "password")
    visit new_session_path
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log In"

    # Warning! This sets @current_user even if the login fails.
    # This should be fixed.
    @current_user = Person.find_by_email(email)
  end

  def logout()
    click_link "Sign out"

    @current_user = nil
  end

  # No browser interaction
  # def login_user_without_browser(username)
 # copy & pasted... doesn't work
  #   person = Person.find_by_username(username)
  #   login_as(person, :scope => :person)
  #   visit root_path(:locale => :en)
  #   @logged_in_user = person
  #   @current_user = person
  # end
end
