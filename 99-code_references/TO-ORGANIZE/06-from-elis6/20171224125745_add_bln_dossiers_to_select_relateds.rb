class AddBlnDossiersToSelectRelateds < ActiveRecord::Migration[5.0]
  def change
    add_column :select_relateds, :bln_dossiers, :boolean
  end
end
