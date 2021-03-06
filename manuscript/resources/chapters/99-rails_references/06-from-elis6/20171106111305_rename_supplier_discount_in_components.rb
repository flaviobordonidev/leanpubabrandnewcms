class RenameSupplierDiscountInComponents < ActiveRecord::Migration[5.0]
  def change
    rename_column :components, :supplier_discount, :discount_one_percentage
  end
end
