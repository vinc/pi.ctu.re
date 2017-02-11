class Album < ApplicationRecord
  include Tokenizable

  belongs_to :user
  has_and_belongs_to_many :pictures
end
