class AddPublishedToEgPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :eg_posts, :published, :boolean, default: false
    add_column :eg_posts, :published_at, :datetime
  end
end
