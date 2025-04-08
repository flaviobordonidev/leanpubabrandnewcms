class CreateTelephones < ActiveRecord::Migration[6.0]
  def change
    create_table :telephones do |t|
      t.belongs_to :company, null: false, foreign_key: true
      t.string :name, default: "Ufficio"
      t.string :prefix, default: "+39"
      t.string :number

      t.timestamps
    end
  end
end
