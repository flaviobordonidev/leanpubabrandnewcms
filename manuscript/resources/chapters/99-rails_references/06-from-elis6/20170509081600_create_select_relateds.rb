class CreateSelectRelateds < ActiveRecord::Migration[5.0]
  def change
    create_table :select_relateds do |t|
      t.string :name
      t.string :metadata
      t.boolean :bln_homepage
      t.boolean :bln_people
      t.boolean :bln_companies

      t.timestamps
    end
  end
end
