class CreateChapters < ActiveRecord::Migration[5.1]
  def change
    create_table :chapters do |t|
      t.string :title
      t.references :comic, foregin_key: true
      t.references :user, foregin_key: true

      t.timestamps
    end
  end
end
