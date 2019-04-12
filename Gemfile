source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.5.3"

gem "rails", "~> 5.2.0"

gem "bootsnap", ">= 1.1.0", require: false
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.12"
gem "redis", "~> 4.0"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug", platform: :mri
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "generator_spec"
  gem "rspec-rails", "~> 3.5"
end

group :development do
  gem "annotate"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "action-cable-testing"
  gem "capybara", ">= 2.15", "< 4.0"
  gem "capybara-selenium"
  gem "chromedriver-helper"
  gem "codecov", require: false
  gem "database_cleaner"
  gem "shoulda-matchers", "~> 3.1.2"
  gem "simplecov", require: false
  gem "stripe-ruby-mock", "~> 2.5.3", require: "stripe_mock"
  gem "timecop"
end

gem "acts_as_votable", "~> 0.12.0"
gem "bootstrap", "~> 4.1.0"
gem "carrierwave", "~> 1.3.1"
gem "carrierwave-bombshelter"
gem "carrierwave-postgresql", "0.3.0"
gem "devise", "~> 4.4.3"
gem "devise-bootstrap-views", "~> 1.0"
gem "devise-i18n"
gem "exifr", "~> 1.3.3"
gem "font-awesome-rails"
gem "iso"
gem "kaminari"
gem "meta-tags"
gem "mini_magick"
gem "money"
gem "order_query", "~> 0.4.0"
gem "pundit"
gem "rails-i18n", "~> 5.1"
gem "rails-timeago", "~> 2.16.0"
gem "redcarpet"
gem "responders"
gem "stripe"
