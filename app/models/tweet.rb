class Tweet < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tweet_tags
  has_many :tags, through: :tweet_tags

  validates :body, presence: true
end
