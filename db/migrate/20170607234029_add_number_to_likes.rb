class AddNumberToLikes < ActiveRecord::Migration[5.1]
  def change
    add_column :likes, :number, :integer
  end
end
