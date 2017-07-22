# frozen_string_literal: true

class AddIdToLikes < ActiveRecord::Migration[5.1]
  def change
    add_reference :likes, :user, foreign_key: true
    add_reference :likes, :tweet, foreign_key: true
  end
end
