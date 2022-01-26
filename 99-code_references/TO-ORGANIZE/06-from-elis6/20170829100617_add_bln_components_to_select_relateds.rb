class AddBlnComponentsToSelectRelateds < ActiveRecord::Migration[5.0]
  def change
    add_column :select_relateds, :bln_components, :boolean
  end
end
