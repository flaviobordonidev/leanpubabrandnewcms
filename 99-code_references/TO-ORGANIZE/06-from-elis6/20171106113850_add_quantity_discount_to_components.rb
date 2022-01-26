class AddQuantityDiscountToComponents < ActiveRecord::Migration[5.0]
  def change
    add_column :components, :discount_one_min_quantity, :decimal
    add_column :components, :discount_one_rounding, :integer
    add_column :components, :discount_two_min_quantity, :decimal
    add_column :components, :discount_two_percentage, :decimal
    add_column :components, :discount_two_rounding, :integer
    add_column :components, :discount_three_min_quantity, :decimal
    add_column :components, :discount_three_percentage, :decimal
    add_column :components, :discount_three_rounding, :integer
    add_column :components, :discount_four_min_quantity, :decimal
    add_column :components, :discount_four_percentage, :decimal
    add_column :components, :discount_four_rounding, :integer
    add_column :components, :discount_five_min_quantity, :decimal
    add_column :components, :discount_five_percentage, :decimal
    add_column :components, :discount_five_rounding, :integer
    add_column :components, :discount_note, :text
  end
end
