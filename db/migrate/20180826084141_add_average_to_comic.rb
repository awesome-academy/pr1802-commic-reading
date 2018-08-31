class AddAverageToComic < ActiveRecord::Migration[5.1]
  def change
    add_column :comics, :average_ratings, :string
  end
end
