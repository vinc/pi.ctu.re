require "rails_helper"

RSpec.describe Picture, type: :model do
  it "has a valid factory" do
    picture = FactoryBot.build(:picture)
    expect(picture).to be_valid
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "token" do
    it "is random" do
      token = FactoryBot.create(:picture).token
      expect(token).to match(/[0-9a-z]{8}/)
    end

    it "is unique" do
      token_1 = FactoryBot.create(:picture).token
      token_2 = FactoryBot.create(:picture).token
      expect(token_1).not_to eql(token_2)
    end
  end

  describe ".regenerate_token" do
    xit "regenerates a new token" do
      picture = FactoryBot.create(:picture)
      token_1 = picture.token
      picture.regenerate_token
      token_2 = picture.token
      expect(token_1).not_to eql(token_2)
    end
  end

  describe ".order_by" do
    before do
      @picture_1 = FactoryBot.create(:picture, created_at: 5.hours.ago, views_count: 10)
      @picture_2 = FactoryBot.create(:picture, created_at: 3.hours.ago, views_count: 50)
      @picture_3 = FactoryBot.create(:picture, created_at: 1.hours.ago, views_count: 30)
    end

    it "returns a list ordered by creation time" do
      pictures = Picture.order_by_time
      expect(pictures[0]).to eql(@picture_3)
      expect(pictures[1]).to eql(@picture_2)
      expect(pictures[2]).to eql(@picture_1)
    end

    it "returns a list ordered by views count" do
      pictures = Picture.order_by_view
      expect(pictures[0]).to eql(@picture_2)
      expect(pictures[1]).to eql(@picture_3)
      expect(pictures[2]).to eql(@picture_1)
    end

    it "works with previous and next" do
      expect(Picture.order_by_time_at(@picture_2).previous).to eql(@picture_3)
      expect(Picture.order_by_time_at(@picture_2).next).to eql(@picture_1)

      expect(Picture.order_by_view_at(@picture_3).previous).to eql(@picture_2)
      expect(Picture.order_by_view_at(@picture_3).next).to eql(@picture_1)
    end
  end
end
