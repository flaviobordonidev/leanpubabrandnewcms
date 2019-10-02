class AddListPositionToPostParagraphs < ActiveRecord::Migration[5.2]
  def change
    add_column :post_paragraphs, :list_position, :integer, default: 1
    add_index :post_paragraphs, :list_position, unique: false
  end
end
