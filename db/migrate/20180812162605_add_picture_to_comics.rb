class AddPictureToComics < ActiveRecord::Migration[5.1]
  def change
    add_column :comics, :picture, :string
  end
end
