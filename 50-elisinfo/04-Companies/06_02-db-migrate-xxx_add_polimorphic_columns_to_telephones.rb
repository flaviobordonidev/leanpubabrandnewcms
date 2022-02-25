class AddPolimorphicColumnsToTelephones < ActiveRecord::Migration[6.0]
  def change
    add_column :telephones, :telephoneable_id, :integer
    add_column :telephones, :telephoneable_type, :string
  end
end