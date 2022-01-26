class AddFactoryIdToComponents < ActiveRecord::Migration[5.0]
  def change
    add_column :components, :factory_id, :integer, index: true
    add_foreign_key :components, :companies, column: :factory_id
  end
end
