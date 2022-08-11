class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.string :name
      t.string :address
      t.integer :emailable_id
      t.string :emailable_type

      t.timestamps
    end
  end
end
