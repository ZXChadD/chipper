# frozen_string_literal: true

class CreateRetweets < ActiveRecord::Migration[5.1]
  def change
    create_table :retweets do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :tweet, foreign_key: true

      t.timestamps
    end
  end
end
