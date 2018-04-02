require "rails_helper"

RSpec.describe PictureHelper, type: :helper do
  describe "#picture_caption_format" do
    context "with one sentence" do
      subject { Faker::Lorem.sentence }

      it "formats picture caption" do
        expect(helper.picture_caption_format(subject)).
          to eq("<p>#{subject}</p>")
      end

      it "pass options to simple_format" do
        expect(helper.picture_caption_format(subject, class: "text-center")).
          to eq("<p class=\"text-center\">#{subject}</p>")
      end
    end

    context "with multiple paragraphs" do
      subject { Faker::Lorem.paragraphs(2).join("\n\n") }

      it "formats picture caption" do
        expect(helper.picture_caption_format(subject)).
          to match /\A(<p>[^<]+<\/p>\s*){2}\z/
      end

      it "has a truncate option" do
        expect(subject.length).to be > 50

        expect(helper.picture_caption_format(subject, truncate: 20).length).
          to be < 50
        expect(helper.picture_caption_format(subject, truncate: 20)).
          to match /\A<p>[^<]+<\/p>\z/
      end
    end

    it "transforms hashtags into links" do
      expect(helper.picture_caption_format("aaa #bbb ccc")).
        to eq("<p>aaa #{link_to '#bbb', search_pictures_path(q: '#bbb')} ccc</p>")
    end
  end
end
