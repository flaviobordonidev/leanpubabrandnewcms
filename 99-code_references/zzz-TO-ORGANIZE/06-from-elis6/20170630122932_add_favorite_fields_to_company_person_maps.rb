class AddFavoriteFieldsToCompanyPersonMaps < ActiveRecord::Migration[5.0]
  def change
    add_column :company_person_maps, :favorite_id_company, :integer
    add_column :company_person_maps, :favorite_id_person, :integer
  end
end
