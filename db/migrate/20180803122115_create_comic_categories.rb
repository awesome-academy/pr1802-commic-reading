class CreateComicCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :comic_categories do |t|
      t.references :category, forgein_key: true
      t.references :comic, forgein_key: true

      t.timestamps
    end
  end
end
