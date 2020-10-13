class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :homonym
      t.text :note

      t.timestamps
    end
  end
end
