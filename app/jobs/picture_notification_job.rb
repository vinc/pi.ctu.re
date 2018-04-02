class PictureNotificationJob < ApplicationJob
  queue_as :default

  def perform(picture)
    TimelineChannel.broadcast_to(picture.user, picture: picture.token)

    picture.user.followers.each do |follower|
      TimelineChannel.broadcast_to(follower, picture: picture.token)
    end
  end
end
