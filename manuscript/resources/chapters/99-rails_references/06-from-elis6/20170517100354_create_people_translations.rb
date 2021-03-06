class CreatePeopleTranslations < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      
      dir.up do
        Person.create_translation_table!({
          title: :string,
          homonym: :string,
          memo: :text
        },{
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do 
        Person.drop_translation_table! migrate_data: true
      end
      
    end
  end
end
