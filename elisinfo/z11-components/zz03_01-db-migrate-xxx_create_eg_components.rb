class CreateEgComponents < ActiveRecord::Migration[6.0]
  def change
    create_table :eg_components do |t|
      t.string :name
      t.references :eg_company, null: false, foreign_key: true
      t.text :description
      t.integer :shelf_life
      t.integer :service_life
      t.datetime :supplier_price_list_expiration_date
      t.decimal :supplier_price_list
      t.string :currency
      t.decimal :currency_exchange
      t.integer :currency_rounding
      t.decimal :supplier_discount
      t.integer :supplier_discount_rounding
      t.string :country_of_origin
      t.string :custom_tariff_number
      t.decimal :net_weight

      t.timestamps
    end
  end
end
