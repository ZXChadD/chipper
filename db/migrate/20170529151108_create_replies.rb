# frozen_string_literal: true

class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.text :body

      t.timestamps
    end
  end
end
