class AddToCompanyPersonMapsTranslations < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      
      dir.up do
        CompanyPersonMap.add_translation_fields!({
          building: :string,
          job_title: :string
        },{
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do
        remove_column :company_person_maps, :building
        remove_column :company_person_maps, :job_title
      end
    end
  end
end
