class CreateSelectRelatedsTranslations < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      
      dir.up do
        SelectRelated.create_translation_table!({
          name: :string
        },{
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do 
        SelectRelated.drop_translation_table! migrate_data: true
      end
      
    end
  end
end