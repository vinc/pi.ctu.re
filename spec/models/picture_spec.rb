require 'rails_helper'

RSpec.describe Picture, type: :model do
  it 'has a valid factory' do
    picture = FactoryGirl.build(:picture)
    expect(picture).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'token' do
    it 'is random' do
      token = FactoryGirl.create(:picture).token
      expect(token).to match(/[0-9a-z]{8}/)
    end

    it 'is unique' do
      token_1 = FactoryGirl.create(:picture).token
      token_2 = FactoryGirl.create(:picture).token
      expect(token_1).not_to eql(token_2)
    end
  end

  describe '.regenerate_token' do
    it 'regenerates a new token' do
      picture = FactoryGirl.create(:picture)
      token_1 = picture.token
      picture.regenerate_token
      token_2 = picture.token
      expect(token_1).not_to eql(token_2)
    end
  end

  describe '.order_by' do
    before do
      @picture_1 = FactoryGirl.create(:picture, created_at: 5.hours.ago, views_count: 10)
      @picture_2 = FactoryGirl.create(:picture, created_at: 1.hours.ago, views_count: 50)
      @picture_3 = FactoryGirl.create(:picture, created_at: 3.hours.ago, views_count: 30)
    end

    it 'returns a list ordered by creation time' do
      pictures = Picture.order_by(:time)
      expect(pictures[0]).to eql(@picture_2)
      expect(pictures[1]).to eql(@picture_3)
      expect(pictures[2]).to eql(@picture_1)
    end

    it 'returns a list ordered by views count' do
      pictures = Picture.order_by(:view)
      expect(pictures[0]).to eql(@picture_2)
      expect(pictures[1]).to eql(@picture_3)
      expect(pictures[2]).to eql(@picture_1)
    end

    it 'raises ArgumentError on unknown order argument' do
      expect { Picture.order_by(:lol) }.to raise_error(ArgumentError)
    end
  end
end
