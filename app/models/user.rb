class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook], :authentication_keys => [:login]

  #Username Validation
  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  # User Avatar Validation
  validates_integrity_of :avatar
  validates_processing_of :avatar

  has_many :tweets, dependent: :destroy

  has_many :replies
  has_many :likes

  validates :email, presence: true, uniqueness: true
  has_many :replies

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  def follow(other)
    following << other
  end

  def unfollow(other)
    following.destroy(other)
  end

  def following?(other)
    following.include?(other)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.username = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
      where(username: conditions[:username]).first
      end
    end
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end


  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end
end
