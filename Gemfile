def next?
  File.basename(__FILE__) == "Gemfile.next"
end

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "3.2.0"

gem "next_rails"

gem "rails", "~> 7.0.4.2"
gem "rails-i18n", "~> 7.0"

gem "bootsnap", ">= 1.1.0", require: false
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 6.3"
gem "redis", "~> 5.0"
gem "sassc-rails", "~> 2.1"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug", platform: :mri
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "generator_spec"
  gem "rspec-rails", "~> 6.0"
end

group :development do
  gem "annotate"
  gem "brakeman"
  gem "bundler-audit"
  gem "listen", ">= 3.0.5", "< 3.9"
  gem "rubocop"
  gem "rubocop-performance"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.1.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15", "< 4.0"
  gem "capybara-selenium"
  gem "database_cleaner"
  gem "selenium-webdriver", require: false
  gem "shoulda-matchers", "~> 3.1.2"
  gem "simplecov", require: false
  gem "simplecov-cobertura"
  gem "stripe-ruby-mock", github: "smakani/stripe-ruby-mock"
  gem "timecop"
  gem "webdrivers"
end

gem "acts_as_votable", "~> 0.14.0"
gem "bootstrap", "~> 4.1.0"
gem "carrierwave", "~> 1.3.1"
gem "carrierwave-bombshelter"
gem "carrierwave-postgresql", "0.3.0"
gem "devise", "~> 4.9.0"
gem "devise-bootstrap-views", "~> 1.0"
gem "devise-i18n"
gem "exifr", "~> 1.3.3"
gem "font-awesome-rails"
gem "iso"
gem "kaminari"
gem "meta-tags"
gem "mini_magick"
gem "money"
gem "order_query", "~> 0.5.2"
gem "pundit"
gem "rails-timeago", "~> 2.20.0"
gem "redcarpet"
gem "responders"
gem "stripe", "~> 7.1"
