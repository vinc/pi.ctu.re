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
    xit 'regenerates a new token' do
      picture = FactoryGirl.create(:picture)
      token_1 = picture.token
      picture.regenerate_token
      token_2 = picture.token
      expect(token_1).not_to eql(token_2)
    end
  end

  describe '.size' do
    before do
      @picture = FactoryGirl.create(:picture)
    end

    it 'returns the size of the picture' do
      expect(@picture.size).to be > 0
    end

    it 'returns the size of a version of the picture' do
      expect(@picture.size(:large)).to be > 0
    end
  end

  describe '.charge_user' do
    before do
      @balance = 100_000_000
      @picture = FactoryGirl.create(:picture)
      @picture.user = FactoryGirl.create(:user, balance: @balance) # 100 MB
    end

    it 'charges user with the size of the picture' do
      @picture.charge_user

      expect(@picture.user.balance).to eql(@balance - @picture.size)
    end

    it 'charges user the size of a version of the picture' do
      @picture.charge_user(:large)

      expect(@picture.user.balance).to eql(@balance - @picture.size(:large))
    end
  end

  describe '.order_by' do
    before do
      @picture_1 = FactoryGirl.create(:picture, created_at: 5.hours.ago, views_count: 10)
      @picture_2 = FactoryGirl.create(:picture, created_at: 1.hours.ago, views_count: 50)
      @picture_3 = FactoryGirl.create(:picture, created_at: 3.hours.ago, views_count: 30)
    end

    it 'returns a list ordered by creation time' do
      pictures = Picture.order_by_time
      expect(pictures[0]).to eql(@picture_2)
      expect(pictures[1]).to eql(@picture_3)
      expect(pictures[2]).to eql(@picture_1)
    end

    it 'returns a list ordered by views count' do
      pictures = Picture.order_by_view
      expect(pictures[0]).to eql(@picture_2)
      expect(pictures[1]).to eql(@picture_3)
      expect(pictures[2]).to eql(@picture_1)
    end

    it 'works with previous and next' do
      expect(Picture.order_by_time_at(@picture_3).previous).to eql(@picture_2)
      expect(Picture.order_by_time_at(@picture_3).next).to eql(@picture_1)

      expect(Picture.order_by_view_at(@picture_3).previous).to eql(@picture_2)
      expect(Picture.order_by_view_at(@picture_3).next).to eql(@picture_1)
    end
  end
end
