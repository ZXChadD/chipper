# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes, &:timestamps
  end
end
