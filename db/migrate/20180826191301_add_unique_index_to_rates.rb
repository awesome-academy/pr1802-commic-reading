class AddUniqueIndexToRates < ActiveRecord::Migration[5.1]
  def change
    add_index :rates, [:user_id, :comic_id], unique: true
  end
end
