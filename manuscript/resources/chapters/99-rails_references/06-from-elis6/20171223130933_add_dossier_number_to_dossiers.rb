class AddDossierNumberToDossiers < ActiveRecord::Migration[5.0]
  def change
    add_column :dossiers, :dossier_number, :string
  end
end
