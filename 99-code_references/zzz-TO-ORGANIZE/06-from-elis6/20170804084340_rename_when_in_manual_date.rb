class RenameWhenInManualDate < ActiveRecord::Migration[5.0]
  def change
    rename_column :histories, :when, :manual_date
  end
end
