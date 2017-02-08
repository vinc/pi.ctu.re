class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :invitation_code

  acts_as_voter

  has_many :pictures

  def remember_me
    true
  end

  def to_param
    self.username
  end

  def name
    self.fullname || self.username
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
