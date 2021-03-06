class CreateContactsTranslations < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      
      dir.up do
        Contact.create_translation_table!({
          medium: :string
        },{
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do 
        Contact.drop_translation_table! migrate_data: true
      end
      
    end
  end
end
