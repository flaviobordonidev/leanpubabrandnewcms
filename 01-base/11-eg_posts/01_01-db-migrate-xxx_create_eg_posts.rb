class CreateEgPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :eg_posts do |t|
      t.string :meta_title
      t.string :meta_description
      t.string :headline
      t.string :incipit
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
