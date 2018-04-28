require "rails_helper"

RSpec.describe PricingHelper, type: :helper do
  before do
    Rails.configuration.cost_per_gigabyte = 10
    Rails.configuration.price_per_gigabyte = 100
  end

  context "with US locale" do
    before do
      @old_locale = I18n.locale
      @old_currency = Money.default_currency
      I18n.locale = "en"
      Money.default_currency = "usd"
    end

    after do
      I18n.locale = @old_locale
      Money.default_currency = @old_currency
    end

    describe "#cost_per_gigabyte" do
      it "formats cost_per_gigabyte" do
        expect(helper.cost_per_gigabyte).to eq("$0.10")
      end
    end

    describe "#price_per_gigabyte" do
      it "formats price_per_gigabyte" do
        expect(helper.price_per_gigabyte).to eq("$1.00")
      end
    end

    describe "#price_options" do
      it "formats price_options" do
        expect(helper.price_options[2][0]).to eq("$10.00 / 10 GB")
      end
    end
  end

  context "with FR locale" do
    before do
      @old_locale = I18n.locale
      @old_currency = Money.default_currency
      I18n.locale = "fr"
      Money.default_currency = "eur"
    end

    after do
      I18n.locale = @old_locale
      Money.default_currency = @old_currency
    end

    describe "#cost_per_gigabyte" do
      it "formats cost_per_gigabyte" do
        expect(helper.cost_per_gigabyte).to eq("0,10 €")
      end
    end

    describe "#price_per_gigabyte" do
      it "formats price_per_gigabyte" do
        expect(helper.price_per_gigabyte).to eq("1,00 €")
      end
    end

    describe "#price_options" do
      it "formats price_options" do
        expect(helper.price_options[2][0]).to eq("10,00 € / 10 Go")
      end
    end
  end
end
