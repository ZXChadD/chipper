class Reply < ApplicationRecord
  belongs_to :tweet
  has_many :likes
end
