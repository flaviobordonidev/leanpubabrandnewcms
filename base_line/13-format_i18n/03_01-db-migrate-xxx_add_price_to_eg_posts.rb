class AddPriceToEgPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :eg_posts, :price, :decimal, precision: 19, scale: 4, default: 0
  end
end
