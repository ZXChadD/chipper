class Tweet < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :likes
  has_many :tweet_tags
  has_many :tags, through: :tweet_tags
end
