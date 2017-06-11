class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags, &:timestamps
  end
end
