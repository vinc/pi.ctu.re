class Album < ApplicationRecord
  include OrderQuery
  include Tokenizable

  belongs_to :user
  has_and_belongs_to_many :pictures

  order_query :order_by_time, [:created_at, :desc]
end
