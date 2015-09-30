module SetupMethods
  def setup_user
    @user = User.create(:name => "Fred")
    @cat = 'cat'
  end
  # put more setup methods here
end