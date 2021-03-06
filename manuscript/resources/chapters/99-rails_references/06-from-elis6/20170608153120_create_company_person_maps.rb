class CreateCompanyPersonMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :company_person_maps do |t|
      t.references :company, foreign_key: true
      t.references :person, foreign_key: true
      t.string :summary

      t.timestamps
    end
  end
end