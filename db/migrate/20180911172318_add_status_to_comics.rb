class AddStatusToComics < ActiveRecord::Migration[5.1]
  def change
    add_column :comics, :status, :integer, default: 0
  end
end
