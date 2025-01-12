source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1'
# Use PostgreSQL as the database for Active Record
gem 'pg', '~> 1.5', '>= 1.5.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test, :production do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development, :test do
  gem 'rspec-rails', '~> 6.0.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # There is an important fix in 3.39.1.
  gem 'capybara', '~> 3.39.1'
  # gem 'capybara-webkit'
  gem 'selenium-webdriver', '>= 4.9'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "shakapacker", "7.0.2"
gem "react_on_rails", "13.4.0"

gem "net-smtp", "~> 0.3.3"

# Psych 4+ comes with breakibg changes in Ruby 3.1.0. Though the issue are
# addressed in Rails 7. So remove this the next line in Rails 7.
gem 'psych', '< 4'

gem "ruby-openai", "~> 4.0"
gem 'dotenv-rails', groups: [:development, :test]
gem 'json', '~> 2.6', '>= 2.6.3'
gem 'tokenizers', '~> 0.4.1'
gem 'pdf-reader', '~> 2.11'
gem 'cosine-similarity', '~> 1.0'


gem "trestle", "~> 0.9.8"
gem "trestle-auth", "~> 0.4.4"
