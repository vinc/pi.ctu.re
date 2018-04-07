require "rails_helper"

RSpec.describe PictureNotificationJob, type: :job do
  describe "#perform_later" do
    let!(:picture) { FactoryBot.create(:picture) }

    it "notify picture creation" do
      ActiveJob::Base.queue_adapter = :test
      expect do
        PictureNotificationJob.perform_later(picture)
      end.to have_enqueued_job
    end
  end

  describe "#perform_now" do
    context "with a user" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:picture) { FactoryBot.create(:picture, user: user) }

      context "with many followers" do
        before do
          user.followers = FactoryBot.create_list(:user, 5)
        end

        it "notify picture creation" do
          follower = user.followers.first

          ActiveJob::Base.queue_adapter = :test
          expect do
            PictureNotificationJob.perform_now(picture)
          end.to have_broadcasted_to(follower).from_channel(TimelineChannel).with(picture: picture.token)
        end
      end
    end
  end
end
