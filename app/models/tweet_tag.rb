class TweetTag < ApplicationRecord
  belongs_to :tweet
  belongs_to :tag
  validates :text, presence: true
end
