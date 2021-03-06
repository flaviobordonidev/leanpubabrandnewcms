class CreateComponents < ActiveRecord::Migration[5.0]
  def change
    create_table :components do |t|
      t.string :part_number
      t.string :name
      t.integer :company_id, foreign_key: true
      t.string :homonym
      t.text :memo
      t.text :description
      t.decimal :supplier_price_list
      t.string :currency
      t.decimal :currency_exchange
      t.integer :currency_rounding
      t.decimal :supplier_discount
      t.integer :discount_rounding

      t.timestamps
    end
  end
end
