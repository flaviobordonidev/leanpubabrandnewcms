class CreateSteps < ActiveRecord::Migration[7.0]
  def change
    create_table :steps do |t|
      t.string :question
      t.text :answer
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
