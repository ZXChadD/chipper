class AddReferencesToReply < ActiveRecord::Migration[5.1]
  def change
    add_reference :replies, :user, foreign_key: true
    add_reference :replies, :tweet, foreign_key: true
  end
end
