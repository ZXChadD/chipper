# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.references :follower, references: :users, null: false
      t.references :followed, references: :users, null: false

      t.timestamps
    end
    add_index :relationships, %i[follower_id followed_id], unique: true
  end
end
