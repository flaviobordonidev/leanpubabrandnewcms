class CreateCompanyPersonMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :company_person_maps do |t|
      t.references :company, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.string :summary

      t.timestamps
    end
  end
end
