class AddUniqueIndexToFollows < ActiveRecord::Migration[5.1]
  def change
    add_index :follows, [:user_id, :comic_id], unique: true
  end
end
