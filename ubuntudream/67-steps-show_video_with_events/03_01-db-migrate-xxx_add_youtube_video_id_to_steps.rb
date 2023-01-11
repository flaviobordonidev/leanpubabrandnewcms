class AddYoutubeVideoIdToSteps < ActiveRecord::Migration[7.0]
  def change
    add_column :steps, :youtube_video_id, :string
  end
end
