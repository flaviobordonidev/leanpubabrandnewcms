class AddAddressesAndContactsToCompanyPersonMaps < ActiveRecord::Migration[5.0]
  def change
    add_column :company_person_maps, :building, :string
    add_column :company_person_maps, :full_address, :string
    add_column :company_person_maps, :address_tag, :string
    add_column :company_person_maps, :latitude, :decimal
    add_column :company_person_maps, :longitude, :decimal
    add_column :company_person_maps, :job_title, :string
    add_column :company_person_maps, :job_title_useful, :string
    add_column :company_person_maps, :mobile, :string
    add_column :company_person_maps, :phone, :string
    add_column :company_person_maps, :direct, :string
    add_column :company_person_maps, :fax, :string
    add_column :company_person_maps, :email, :string
    add_column :company_person_maps, :note, :text
  end
end
