# frozen_string_literal: true

class TweetTag < ApplicationRecord

  belongs_to :tweet
  belongs_to :tag

end
