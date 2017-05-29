class Like < ApplicationRecord
  belongs_to :tweet
  belongs_to :reply
end
