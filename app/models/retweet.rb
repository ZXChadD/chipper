class Retweet < ApplicationRecord
  belongs_to :retweeter, class_name: "user"
  belongs_to :tweet
end
