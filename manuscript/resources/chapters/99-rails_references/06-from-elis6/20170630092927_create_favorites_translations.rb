class CreateFavoritesTranslations < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      
      dir.up do
        Favorite.create_translation_table!({
          copy_normal: :string,
          copy_bold: :string
        },{
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do 
        Favorite.drop_translation_table! migrate_data: true
      end
      
    end
  end
end
