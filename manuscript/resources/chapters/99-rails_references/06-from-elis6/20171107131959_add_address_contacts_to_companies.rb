class AddAddressContactsToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :building, :string
    add_column :companies, :full_address, :string
    add_column :companies, :address_tag, :string
    add_column :companies, :telephone, :string
    add_column :companies, :fax, :string
    add_column :companies, :email, :string
    add_column :companies, :web_site, :string
    add_column :companies, :note_contacts, :text
  end
end
