class ChangeClientSupplierTypeAndAddIndexToCompanies < ActiveRecord::Migration[6.0]
  def change
    change_column :companies, :client_type, :integer, default: 0
    change_column :companies, :supplier_type, :integer, default: 0
    add_index :companies, :client_type, unique: false
    add_index :companies, :supplier_type, unique: false
  end
end
