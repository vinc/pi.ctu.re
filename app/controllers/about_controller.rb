require "mail"

class AboutController < ApplicationController
  def contact
    @email = Mail::Address.new(ENV["MAILER_SENDER"]).address
  end

  def pricing
  end

  def privacy
  end

  def terms
  end

  def rules
  end
end
