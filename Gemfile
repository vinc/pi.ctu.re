source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.5.0"

gem "rails", "~> 5.1.5"

gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "pg", "~> 0.18"
gem "puma", "~> 3.7"
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
  gem "listen", "~> 3.0.5"
  gem "rubocop"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara"
  gem "codecov", require: false
  gem "database_cleaner"
  gem "shoulda-matchers", "~> 3.1.2"
  gem "simplecov", require: false
  gem "stripe-ruby-mock", "~> 2.5.3", require: "stripe_mock"
end

gem "acts_as_votable", "~> 0.11.1"
gem "bootstrap", "~> 4.0.0"
gem "carrierwave", "~> 1.2.2"
gem "carrierwave-postgresql", "0.1.5"
gem "devise", "~> 4.4.3"
gem "devise-bootstrap-views", "~> 1.0.0.alpha1"
gem "exifr", "~> 1.3.3"
gem "font-awesome-rails"
gem "kaminari"
gem "mini_magick"
gem "order_query", "~> 0.4.0"
gem "pundit"
gem "rails-timeago", "~> 2.16.0"
gem "responders"
gem "stripe"
