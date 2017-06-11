class CreateTweetTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tweet_tags, &:timestamps
  end
end
