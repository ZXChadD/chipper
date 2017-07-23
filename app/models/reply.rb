# frozen_string_literal: true

class Reply < ApplicationRecord

  belongs_to :tweet
  belongs_to :user

  validates :body, presence: true

end
