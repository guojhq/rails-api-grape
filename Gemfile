source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.3.8'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
gem 'rails-i18n', '~> 5.1'

# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'jwt', '~> 2.1'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# config
gem 'figaro', '~> 1.1'

# grape
gem 'grape', '~> 1.2'
gem 'hashie', '~> 3.6'
gem 'grape-entity', '~> 0.7'

# swagger
gem 'grape-swagger', '~> 0.32' # grape doc
gem 'grape-swagger-rails', '~> 0.3' # a web page
gem 'grape-swagger-entity', '~> 0.3'

# paginate
gem 'kaminari', '~> 0.17'

# # version of active_record
# gem 'paper_trail', '~> 10.2'
# gem 'grape-papertrail', '~> 0.2'
#
# # search helper
# gem 'ransack', '~> 2.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
  gem 'pry-rails'

  gem 'rubocop', require: false
  gem 'rubocop-performance'

  # TDD
  gem 'rspec-rails', '~> 3.8'

  # # BDD
  # gem 'cucumber'
  # gem 'cucumber-rails', require: false
  # gem 'cucumber-api-steps', require: false
  #
  # # test helper
  # gem 'factory_bot_rails'
  # gem 'ffaker', '~> 2.9'
  # gem 'database_cleaner'
  # gem 'timecop'
  #
  # gem 'simplecov', require: false
  #
  # # model comment
  # gem 'annotate'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # deploy
  # gem 'capistrano', '~> 3.11', require: false
  # gem 'capistrano-rails', '~> 1.3', require: false
  # gem 'capistrano3-puma', github: 'seuros/capistrano-puma'
  # gem 'capistrano-rvm', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
