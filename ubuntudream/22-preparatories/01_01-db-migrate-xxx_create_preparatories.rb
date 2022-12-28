class CreatePreparatories < ActiveRecord::Migration[7.0]
  def change
    create_table :preparatories do |t|
      t.string :name
      t.integer :duration
      t.string :youtube_video_id

      t.timestamps
    end
  end
end
