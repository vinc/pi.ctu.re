class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_voter

  has_many :pictures

  def to_param
    self.username
  end

  def name
    self.fullname || self.username
  end

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end
