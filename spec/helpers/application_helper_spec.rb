require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#body_class" do
    context "within welcome#index" do
      it "returns a string" do
        allow(helper).to receive(:controller_path) { "welcome" }
        allow(helper).to receive(:action_name) { "index" }

        expect(helper.body_class).to eq("welcome-index")
      end
    end

    context "within account/settings#edit" do
      it "returns a string" do
        allow(helper).to receive(:controller_path) { "account/settings" }
        allow(helper).to receive(:action_name) { "edit" }

        expect(helper.body_class).to eq("account-settings-edit")
      end
    end
  end

  describe "#email_munging" do
    subject { Faker::Internet.email }

    it "returns a munged email address" do
      expect(helper.email_munging(subject)).to eq(subject.gsub("@", "(@_@)"))
    end
  end

  describe "#language" do
    describe "#direction" do
      context "with default English locale" do
        it "returns ltr" do
          expect(helper.language.direction).to eq("ltr")
        end
      end

      context "with Arabic locale" do
        before { I18n.locale = :ar }
        after { I18n.locale = :en }

        it "returns rtl" do
          expect(helper.language.direction).to eq("rtl")
        end
      end
    end
  end

  describe "#pull_end_class" do
    context "with default English locale" do
      it "returns pull-right" do
        expect(helper.pull_end_class).to eq("pull-right")
      end
    end

    context "with Arabic locale" do
      before { I18n.locale = :ar }
      after { I18n.locale = :en }

      it "returns pull-left" do
        expect(helper.pull_end_class).to eq("pull-left")
      end
    end
  end

  describe "#form_errors_heading" do
    context "with a form error" do
      let(:picture) { FactoryBot.build(:picture, image: nil) }

      it "returns a form errors heading" do
        picture.save
        expect(helper.form_errors_heading(picture)).to match("1 error prohibited this picture from being saved:")
      end
    end
  end

  describe "#render_markdown" do
    it "returns a html string" do
      expect(helper.render_markdown("test")).to match("<p>test</p>")
    end
  end
end
