class CreatePostParagraphs < ActiveRecord::Migration[5.2]
  def change
    create_table :post_paragraphs do |t|
      t.references :post, foreign_key: true
      t.string :title
      t.text :content
      t.string :imagecaption
      t.string :youtube
      t.string :youtubecaption
      t.string :vimeo
      t.string :vimeocaption

      t.timestamps
    end
  end
end