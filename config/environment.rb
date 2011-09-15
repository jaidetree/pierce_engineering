RAILS_ENV="development"
RAILS_ENV.freeze

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PierceEngineering::Application.initialize!
