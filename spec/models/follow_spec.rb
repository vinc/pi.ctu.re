# == Schema Information
#
# Table name: follows
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require "rails_helper"

RSpec.describe Follow, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:follower).counter_cache(:followees_count) }
    it { is_expected.to belong_to(:followee).counter_cache(:followers_count) }
  end
end
