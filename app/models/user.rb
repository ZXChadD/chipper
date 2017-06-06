class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # User Avatar Validation
  validates_integrity_of :avatar
  validates_processing_of :avatar

  has_many :tweets, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  has_many :replies

  # has_many :active_relationships, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  # has_many :passive_relationships, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
  # has_many :following, through: :active_relationships, source: :followed
  # has_many :followers, through: :passive_relationships, source: :follower

  has_many :following, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followers, class_name: 'Relationship', foreign_key: 'followed_id'

  def follow(other)
    following.create!(followed: other)
  end

  def unfollow(other)
    following.find_by(followed: other).destroy
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

  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end
end
