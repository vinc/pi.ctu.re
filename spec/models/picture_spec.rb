# == Schema Information
#
# Table name: pictures
#
#  id             :integer          not null, primary key
#  caption        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  token          :string
#  views_count    :integer          default(0), not null
#  image_height   :integer
#  image_width    :integer
#  is_featured    :boolean          default(FALSE), not null
#  image          :integer          not null
#  image_filename :string
#

require "rails_helper"

RSpec.describe Picture, type: :model do
  subject { FactoryBot.build(:picture) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  describe "validations" do
    it { should validate_length_of(:caption).is_at_most(Picture::CAPTION_LENGTH_MAX) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "#token" do
    context "when subject is new" do
      it "is nil" do
        expect(subject.token).to be_nil
      end
    end

    context "when subject is persisted" do
      subject { FactoryBot.create(:picture) }

      it "is random" do
        expect(subject.token).to match(/[0-9a-z]{8}/)
      end

      it "is unique" do
        other_token = FactoryBot.create(:picture).token
        expect(subject.token).not_to eql(other_token)
      end
    end
  end

  describe "#regenerate_token" do
    it "regenerates a new token" do
      old_token = subject.token
      subject.regenerate_token
      expect(subject.token).not_to eql(old_token)
    end
  end

  context ".order_by" do
    let!(:pictures) do
      [
        FactoryBot.create(:picture, created_at: 5.hours.ago, views_count: 10),
        FactoryBot.create(:picture, created_at: 3.hours.ago, views_count: 50),
        FactoryBot.create(:picture, created_at: 1.hours.ago, views_count: 30)
      ]
    end

    it "returns a list ordered by creation time" do
      scope = Picture.order_by_time
      expect(scope[0]).to eql(pictures[2])
      expect(scope[1]).to eql(pictures[1])
      expect(scope[2]).to eql(pictures[0])
    end

    it "returns a list ordered by views count" do
      scope = Picture.order_by_view
      expect(scope[0]).to eql(pictures[1])
      expect(scope[1]).to eql(pictures[2])
      expect(scope[2]).to eql(pictures[0])
    end

    it "works with previous and next" do
      expect(Picture.order_by_time_at(pictures[1]).previous).to eql(pictures[2])
      expect(Picture.order_by_time_at(pictures[1]).next).to eql(pictures[0])

      expect(Picture.order_by_view_at(pictures[2]).previous).to eql(pictures[1])
      expect(Picture.order_by_view_at(pictures[2]).next).to eql(pictures[0])
    end
  end

  describe "after_create" do
    it "notifies of picture creation" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        subject.save
      }.to have_enqueued_job
    end
  end

  describe "#notify" do
    subject! { FactoryBot.create(:picture) }

    it "notifies of picture creation" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        subject.notify!
      }.to have_enqueued_job
    end
  end
end
