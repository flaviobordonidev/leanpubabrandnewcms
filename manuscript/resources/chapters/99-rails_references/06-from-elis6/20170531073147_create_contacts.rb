class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.integer :contactable_id, foreign_key: true
      t.string :contactable_type
      t.string :medium
      t.string :identifier

      t.timestamps
    end
  end
end
