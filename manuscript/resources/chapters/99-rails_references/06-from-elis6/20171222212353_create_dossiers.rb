class CreateDossiers < ActiveRecord::Migration[5.0]
  def change
    create_table :dossiers do |t|
      t.string :name
      t.text :description
      t.string :cord_number
      t.date :delivery_date
      t.integer :delivery_date_alarm
      t.integer :final_total_quantity
      t.integer :final_quantity_alarm
      t.decimal :final_price
      t.integer :final_price_alarm
      t.date :payment_date
      t.integer :payment_alarm
      t.integer :documental_flow_alarm
      t.integer :dossier_alarm

      t.timestamps
    end
  end
end
