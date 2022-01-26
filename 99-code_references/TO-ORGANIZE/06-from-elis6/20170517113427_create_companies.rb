class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :status
      t.string :taxation_number_first
      t.string :taxation_number_second
      t.text :memo

      t.timestamps
    end
  end
end
