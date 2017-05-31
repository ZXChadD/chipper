class Reply < ApplicationRecord
  belongs_to :tweet
  has_many :likes

  validates :body, presence: true 
end
