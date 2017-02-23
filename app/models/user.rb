class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :invitation_token

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

  validate :invitation_token_must_be_valid, on: :create

  def invitation_token_must_be_valid
    return if self.invitation_token == Rails.application.secrets.invitation_token
    return if Invitation.approved.where(email: self.email, token: self.invitation_token).exists?

    errors.add(:invitation_token, 'is invalid')
  end
end
