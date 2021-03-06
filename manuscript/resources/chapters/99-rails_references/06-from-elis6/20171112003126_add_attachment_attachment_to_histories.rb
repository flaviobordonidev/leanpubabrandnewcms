class AddAttachmentAttachmentToHistories < ActiveRecord::Migration
  def self.up
    change_table :histories do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :histories, :attachment
  end
end
