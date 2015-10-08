require_relative "./login_helpers.rb" 
include LoginHelpers
require_relative "./test_seed_data.rb" 

Capybara.default_driver = :selenium
# Capybara.default_max_wait_time = 20
 
World(Capybara)

# The following line includes factory girls methods
World(FactoryGirl::Syntax::Methods)