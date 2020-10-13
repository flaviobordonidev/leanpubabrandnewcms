class CreateCompanyPersonMapsTranslations < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      
      dir.up do
        CompanyPersonMap.create_translation_table!({
          summary: :string
        },{
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do 
        CompanyPersonMap.drop_translation_table! migrate_data: true
      end
      
    end
  end
end
