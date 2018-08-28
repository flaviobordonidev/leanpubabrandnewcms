# Companies




## db




#### 01 {#code-migrations-companies-db-01}

{title="db/migrations/xxx_add_corporate_to_company.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class AddCorporateToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :corporate, :string
  end
end
~~~~~~~~




#### 02 {#code-migrations-companies-db-02}

{title="db/migrations/xxx_remove_image_field_from_companies.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class RemoveImageFieldFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :image, :string
  end
end
~~~~~~~~
