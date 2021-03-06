class RenameCompanyIdInComponents < ActiveRecord::Migration[5.0]
  def change
    rename_column :components, :company_id, :supplier_id
  end
end
