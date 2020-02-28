class CreateEgPostTranslations < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      
      dir.up do
        EgPost.create_translation_table!({
          meta_title: :string,
          meta_description: :string,
          headline: :string,
          incipit: :string
        },{
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do 
        EgPost.drop_translation_table! migrate_data: true
      end
      
    end
  end
end
