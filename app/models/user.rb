# frozen_string_literal: true

class User < ApplicationRecord

  mount_uploader :avatar, AvatarUploader

  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook], authentication_keys: [:login]

  # Username Validation
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  validates :username, format: { with: /^[a-zA-Z0-9_\.]*$/, multiline: true }

  # Email Validation
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  # User Avatar Validation
  validates_integrity_of :avatar
  validates_processing_of :avatar

  has_many :tweets, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :notifications, foreign_key: 'recipient_id'
  has_many :retweets, class_name: 'tweet'

  has_many :following, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :notifications, foreign_key: 'recipient_id'

  def follow(other)
    following.create!(followed: other)
  end

  def unfollow(other)
    following.find_by(followed: other).destroy
  end

  def following?(other)
    if following.find_by(followed_id: other.id).nil?
      false
    else
      true
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.username = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  private

  def avatar_size_validation
    errors[:avatar] << 'should be less than 500KB' if avatar.size > 0.5.megabytes
  end

end
