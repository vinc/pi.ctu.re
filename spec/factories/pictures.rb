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

require "faker"

FactoryBot.define do
  factory :picture do
    caption { Faker::Lorem.sentence }
    image   { File.open(Rails.root.join("app/assets/images/home_bg.jpg")) }
    user
  end
end
