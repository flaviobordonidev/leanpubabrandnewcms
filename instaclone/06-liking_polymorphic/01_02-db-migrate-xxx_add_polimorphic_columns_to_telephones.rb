class AddPolymorphicColumnsToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :likeable_id, :integer
    add_column :likes, :likeable_type, :string
  end
end
