class Album < ApplicationRecord
  include Tokenizable

  belongs_to :user
end
