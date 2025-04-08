class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :building
      t.string :address
      t.integer :client_type
      t.integer :client_rate
      t.integer :supplier_type
      t.integer :supplier_rate
      t.text :note
      t.string :sector
      t.string :tax_number_1
      t.string :tax_number_2

      t.timestamps
    end
  end
end
