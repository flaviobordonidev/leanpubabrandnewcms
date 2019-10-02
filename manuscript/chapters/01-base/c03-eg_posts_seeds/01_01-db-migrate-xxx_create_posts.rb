class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :incipit
      t.text :content
      t.integer :content_type
      t.string :video_youtube
      t.string :video_vimeo
      t.text :seocontent
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
