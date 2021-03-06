# frozen_string_literal: true

class Tag < ApplicationRecord

  has_many :tweet_tags, dependent: :destroy
  has_many :tweets, through: :tweet_tags
  # validates :text, presence: true

end
