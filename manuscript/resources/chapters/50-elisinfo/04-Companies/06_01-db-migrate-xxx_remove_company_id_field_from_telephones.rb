class RemoveCompanyIdFieldFromTelephones < ActiveRecord::Migration[6.0]
  def change

    remove_column :telephones, :company_id, :integer
  end
end