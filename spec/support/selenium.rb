require "selenium-webdriver"
require "webdrivers"

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[headless no-sandbox]
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :selenium

Capybara.server = :puma, { Silent: true }
