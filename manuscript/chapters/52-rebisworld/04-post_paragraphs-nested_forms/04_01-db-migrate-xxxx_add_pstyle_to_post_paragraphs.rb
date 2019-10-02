class AddPstyleToPostParagraphs < ActiveRecord::Migration[5.2]
  def change
    add_column :post_paragraphs, :pstyle, :integer, default: 0
    add_index :post_paragraphs, :pstyle, unique: false
  end
end