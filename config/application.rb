require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PictureApplication
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    config.action_dispatch.rescue_responses["Pundit::NotAuthorizedError"] = :forbidden

    config.i18n.fallbacks = [:en]

    # Custom configuration
    config.invitation_enabled = ENV["PICTURE_DISABLE_INVITATION"].blank?
    config.payment_enabled = ENV["PICTURE_DISABLE_PAYMENT"].blank?
    config.cost_per_gigabyte = ENV["PICTURE_COST_PER_GIGABYTE"] || "10"
    config.price_per_gigabyte = ENV["PICTURE_PRICE_PER_GIGABYTE"] || "100"
    Money.default_currency = Money::Currency.new(ENV["DEFAULT_CURRENCY"] || "eur")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
