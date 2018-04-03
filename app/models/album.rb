# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  title      :string
#  token      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord
  include OrderQuery
  include Tokenizable

  TITLE_LENGTH_MAX = 100

  belongs_to :user
  has_and_belongs_to_many :pictures

  order_query :order_by_time, %i[updated_at desc]

  validates :title, presence: true, length: { maximum: TITLE_LENGTH_MAX }
end
