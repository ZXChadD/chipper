class Reply < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  has_many :likes

  validates :body, presence: true
end
