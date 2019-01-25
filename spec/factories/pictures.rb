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

require "faker"

FactoryBot.define do
  image_path = Rails.root.join("app/assets/images/home_bg.jpg")

  factory :picture do
    description { Faker::Lorem.sentence }
    image { File.open(image_path) }
    user

    trait :with_uploaded_file do
      image { Rack::Test::UploadedFile.new(image_path, "image/jpeg") }
    end
  end
end
