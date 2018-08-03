class CreateComics < ActiveRecord::Migration[5.1]
  def change
    create_table :comics do |t|
      t.string :title
      t.text :content
      t.references :author, foregin_key: true
      t.references :user, foregin_key: true

      t.timestamps
    end
  end
end
