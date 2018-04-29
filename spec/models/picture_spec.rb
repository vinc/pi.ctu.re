# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#  token              :string
#  views_count        :integer          default(0), not null
#  image_height       :integer
#  image_width        :integer
#  is_featured        :boolean          default(FALSE), not null
#  image              :integer          not null
#  image_filename     :string
#  privacy_setting    :integer          default("public")
#  cached_votes_total :integer          default(0)
#  status             :integer          default("enabled")
#

require "rails_helper"

RSpec.describe Picture, type: :model do
  subject { FactoryBot.build(:picture) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end

  describe "validations" do
    it { is_expected.to validate_length_of(:description).is_at_most(Picture::CAPTION_LENGTH_MAX) }
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
      expect do
        subject.save
      end.to have_enqueued_job
    end
  end

  describe "#notify" do
    subject! { FactoryBot.create(:picture) }

    it "notifies of picture creation" do
      ActiveJob::Base.queue_adapter = :test
      expect do
        subject.notify!
      end.to have_enqueued_job
    end
  end

  describe "#image" do
    subject! { FactoryBot.create(:picture) }

    describe "#thumb_size" do
      it "returns thumbnail size with a correct ratio" do
        width = subject.image_width / 10
        height = subject.image_height / 10
        expect(subject.image.thumb_size("#{width}x#{height}")).to eq("#{width}x#{height}")
        expect(subject.image.thumb_size("x#{height}")).to eq("#{width}x#{height}")
        expect(subject.image.thumb_size("#{width}x")).to eq("#{width}x#{height}")
      end
    end

    describe "#url" do
      it "returns image url" do
        expect(subject.image.url).
          to eq("#{ENV['PICTURE_DELIVERY_URL']}/pictures/#{subject.token}/#{subject.image.filename}")
      end
    end
  end

  describe "#protected_secret" do
    context "with a protected picture" do
      subject! { FactoryBot.create(:picture, privacy_setting: "protected") }

      it "returns a secret protecting a picture" do
        expect(subject.protected_secret).to be_a String
        expect(subject.protected_secret).to be_present
      end
    end

    context "with a public picture" do
      subject! { FactoryBot.create(:picture, privacy_setting: "public") }

      it "returns nil" do
        expect(subject.protected_secret).to be_nil
      end
    end
  end

  describe "#regenerate_protected_secret!" do
    context "with a protected picture" do
      subject! { FactoryBot.create(:picture, privacy_setting: "protected") }

      it "changes the secret" do
        old_secret = subject.protected_secret
        expect(subject.regenerate_protected_secret!).not_to eq(old_secret)
        expect(subject.protected_secret).not_to eq(old_secret)
      end

      it "changes the filename" do
        old_filename = subject.image.filename
        subject.regenerate_protected_secret!
        expect(subject.image.filename).not_to eq(old_filename)
      end
    end

    context "with a public picture" do
      subject! { FactoryBot.create(:picture, privacy_setting: "public") }

      it "doesn't change the secret" do
        expect(subject.regenerate_protected_secret!).to be_nil
        expect(subject.protected_secret).to be_nil
      end

      it "doesn't change the filename" do
        old_filename = subject.image.filename
        subject.regenerate_protected_secret!
        expect(subject.image.filename).to eq(old_filename)
      end
    end
  end

  describe "after_initialize" do
    context "when user default to private setting" do
      let(:user) { FactoryBot.create(:user, default_privacy_setting: "private") }

      context "with a new picture" do
        subject { user.pictures.new }

        it "applies user default privacy setting" do
          expect(subject.privacy_setting).to eq("private")
        end
      end
    end
  end

  describe "#albums" do
    subject { FactoryBot.create(:picture) }

    describe "after_add" do
      let(:album) do
        Timecop.freeze(5.minutes.ago) do
          FactoryBot.create(:album)
        end
      end

      it "touches album" do
        expect(album.updated_at).to be < 1.minute.ago
        subject.albums << album
        expect(album.updated_at).to be > 1.minute.ago
      end
    end

    describe "after_remove" do
      let(:album) do
        Timecop.freeze(5.minutes.ago) do
          FactoryBot.create(:album, pictures: [subject])
        end
      end

      it "touches album" do
        expect(album.updated_at).to be < 1.minute.ago
        subject.albums.delete(album)
        expect(album.updated_at).to be > 1.minute.ago
      end
    end
  end
end
