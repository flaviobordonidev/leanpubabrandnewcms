class AddContentToEgPostTranslations < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|

      dir.up do
        EgPost.add_translation_fields! content: :text
      end

      dir.down do
        remove_column :eg_post_translations, :content
      end
    end
  end
end
