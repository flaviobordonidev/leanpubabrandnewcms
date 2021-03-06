class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :addressable_id, foreign_key: true
      t.string :addressable_type
      t.text :full_address
      t.string :latitude
      t.string :longitude
      t.string :address_tag

      t.timestamps
    end
  end
end
