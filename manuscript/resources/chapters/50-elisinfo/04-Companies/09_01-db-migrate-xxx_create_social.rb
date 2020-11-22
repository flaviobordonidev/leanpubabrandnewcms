class CreateSocials < ActiveRecord::Migration[6.0]
  def change
    create_table :socials do |t|
      t.string :name
      t.string :address
      t.integer :socialable_id
      t.string :socialable_type

      t.timestamps
    end
  end
end
