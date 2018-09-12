class CreateChapterAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :chapter_attachments do |t|
      t.integer :chapter_id
      t.string :picture

      t.timestamps
    end
  end
end
