class RemoveImageFieldFromCompanies < ActiveRecord::Migration[7.0]
  def change
    remove_column :companies, :image, :string
  end
end
