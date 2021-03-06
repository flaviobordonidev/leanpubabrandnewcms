class ChangePriceFieldsInComponents < ActiveRecord::Migration[5.0]
  def change
    change_column :components, :supplier_price_list, :decimal, default: 0
    change_column :components, :currency, :string, default: "EUR"
    change_column :components, :currency_exchange, :decimal, default: 1
    change_column :components, :discount_one_min_quantity, :decimal, default: 1
    change_column :components, :discount_one_percentage, :decimal, default: 0
  end
end
