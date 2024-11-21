# Rails Template Script (template.rb)

# Usage
# rails new my_demo_app -m rails_template.rb --database=postgresql --minimal
# skips action acable, active storage etc ..

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'webdrivers'
  gem 'faker'
end

initializer 'generators.rb', <<-CODE
  Rails.application.config.generators do |g|
    g.test_framework :rspec,
      fixtures:         false,
      view_specs:       false,
      helper_specs:     false,
      routing_specs:    false,
      request_specs:    false,
      controller_specs: false
  end
CODE

after_bundle do
  # Set PostgreSQL as the database
  inside 'config' do
    gsub_file 'database.yml', /sqlite3/, 'postgresql'
  end

  # Create the User model with scaffolding
  generate 'scaffold', 'User', 'first_name:string', 'last_name:string', 'email:string'
  rake 'db:create'
  rake 'db:migrate'

  # Install RSpec
  generate 'rspec:install'

  say "Application successfully set up with PostgreSQL, User scaffolding, and RSpec!"
end
