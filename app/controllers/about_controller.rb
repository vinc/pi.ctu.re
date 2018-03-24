require "mail"

class AboutController < ApplicationController
  def pricing
  end

  def contact
    @email = Mail::Address.new(ENV["MAILER_SENDER"]).address
  end
end
