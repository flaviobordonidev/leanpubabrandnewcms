class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.integer :historyable_id, foreign_key: true
      t.string :historyable_type
      t.string :title
      t.datetime :when
      t.text :memo
      t.integer :user_id, foreign_key: true

      t.timestamps
    end
  end
end
