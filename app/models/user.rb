class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :invitation_code

  acts_as_voter

  mount_uploader :avatar, AvatarUploader

  has_many :albums
  has_many :pictures

  def remember_me
    true
  end

  def to_param
    self.username
  end

  def name
    self.fullname.presence || self.username
  end

  before_create do
    self.balance = 100e6 # Give 100 MB of data to each new user for free
  end

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  validate :invitation_code_must_be_valid, on: :create

  def invitation_code_must_be_valid
    unless self.invitation_code == Rails.application.secrets.invitation_code
      errors.add(:invitation_code, 'is invalid')
    end
  end
end
