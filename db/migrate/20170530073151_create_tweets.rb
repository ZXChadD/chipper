# frozen_string_literal: true

class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :body

      t.timestamps
    end
  end
end
