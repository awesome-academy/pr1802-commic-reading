class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, forgein_key: true
      t.references :chapter, forgein_key: true

      t.timestamps
    end
  end
end
