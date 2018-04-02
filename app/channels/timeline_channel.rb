class TimelineChannel < ApplicationCable::Channel
  def subscribed
    reject if current_user.nil?

    stream_for current_user
  end
end
