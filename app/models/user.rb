# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :inet
#  last_sign_in_ip         :inet
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  username                :string
#  balance                 :integer          default(0), not null
#  fullname                :string
#  default_license         :string           default("CC BY-NC-ND"), not null
#  avatar                  :integer
#  avatar_filename         :string
#  customer_id             :string
#  followers_count         :integer          default(0)
#  followees_count         :integer          default(0)
#  default_privacy_setting :integer
#  role                    :integer          default("member")
#  locale                  :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :invitation_token

  FULLNAME_LENGTH_MAX = 50

  acts_as_voter

  mount_uploader :avatar, AvatarUploader

  has_many :albums
  has_many :pictures

  has_many :follower_relationships, foreign_key: :followee_id, class_name: "Follow"
  has_many :followee_relationships, foreign_key: :follower_id, class_name: "Follow"
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :followees, through: :followee_relationships, source: :followee

  after_initialize do
    self.locale ||= I18n.locale
  end

  before_create do
    self.balance = 1.gigabyte
  end

  enum role: %i[member moderator admin]

  enum default_privacy_setting: %i[public protected private], _suffix: :setting

  def self.locales
    {
      ar: "العربية",
      de: "Deutsch",
      en: "English",
      es: "Español",
      fr: "Français",
      ja: "日本語",
      pt: "Português",
      ru: "Русский"
    }.freeze
  end

  def self.default_licenses
    [
      "CC BY",
      "CC BY-SA",
      "CC BY-NC",
      "CC BY-ND",
      "CC BY-NC-SA",
      "CC BY-NC-ND"
    ].freeze
  end

  def self.username_pattern
    "[0-9A-Za-z][0-9A-Za-z-]{1,30}[0-9A-Za-z]".freeze
  end

  validates :locale, inclusion: { in: locales.keys.map(&:to_s) }
  validates :default_license, inclusion: { in: default_licenses }
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true, format: /\A#{User.username_pattern}\z/
  validates :fullname, length: { maximum: FULLNAME_LENGTH_MAX }
  validate :invitation_token_must_be_valid, on: :create, unless: :admin?

  def remember_me
    true
  end

  def to_param
    username
  end

  def name
    fullname.presence || username
  end

  def invitation_token_must_be_valid
    approved_invitation = Invitation.approved.where(email: email, token: invitation_token)
    errors.add(:invitation_token, "is invalid") unless approved_invitation.exists?
  end

  def billable?
    ENV["STRIPE_PUBLISHABLE_KEY"].present?
  end

  def usage
    pictures.map(&:image).map(&:size).sum
  end
end
