source 'https://rubygems.org'

gem 'rails', '3.2.9'
gem 'pg'

gem "devise"
gem 'devise-russian'
gem "cancan"
gem 'state_machine'
gem 'kaminari'
gem 'formtastic'
gem 'formtastic-bootstrap'
gem "carrierwave"

gem "airbrake"
gem 'whenever', :require => false
gem 'resque', :require => "resque/server"
gem 'dev_log_in'

gem 'haml'
gem 'bootstrap-sass'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

group :development do
  gem 'pry-rails'
  gem 'ultimate-log-silencer'
  gem "annotate"
  gem 'guard-annotate'
  gem 'guard-resque'
  gem 'guard-rspec'
  gem 'hirb'
  gem 'showoff-io'
end

group :production do
  gem 'newrelic_rpm'
  gem 'thin'
end

group :test, :development do
  gem "letter_opener"
  gem 'guard'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  #gem 'mocha'
end
