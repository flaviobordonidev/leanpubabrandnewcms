class AddDescriptionToEgPostTranslations < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|

      dir.up do
        EgPost.add_translation_fields! description: :text
      end

      dir.down do
        remove_column :eg_post_translations, :description
      end
    end
  end
end
