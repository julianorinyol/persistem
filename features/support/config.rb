require_relative "./login_helpers.rb" 
include LoginHelpers
require_relative "./test_helper_methods.rb"

require_relative "../../app/models/concerns/shared_methods.rb"
include SharedMethods

require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist

# Capybara.default_driver = :selenium

# Capybara.default_max_wait_time = 20
 
World(Capybara)

# The following line includes factory girls methods
World(FactoryGirl::Syntax::Methods)