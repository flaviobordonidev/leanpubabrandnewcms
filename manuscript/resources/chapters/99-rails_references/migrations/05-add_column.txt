{id: 99-rails_references-migrations-08-change_column}
# Cap 99.x -- Aggiungi colonna (Add column)

Nel migration usiamo il codice:

add_column :table_name, :column_name, type, options




## Esempio1: Add price column to eg_posts table


{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g migration AddPriceToEgPosts price:decimal
```

{caption: ".../db/migrate/xxx_add_price_to_eg_posts.rb", format: ruby, line-numbers: true, number-from: 1}
```
class AddPriceToEgPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :eg_posts, :price, :decimal, precision: 19, scale: 4, default: 0
  end
end
```




## Esempio2: Add corporate column to companies table


{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g migration AddCorporateToCompanies corporate:string
```

{caption: ".../db/migrate/xxx_add_corporate_to_company.rb", format: ruby, line-numbers: true, number-from: 1}
```
  add_column :companies, :corporate, :string
```




## Esempio3: Add address columns to kiosks table

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g migration AddAddressColumnsToKiosk line1:string line2:string line3:string locality:string region:string postcode:string country:string latitude:string longitude:string
~~~~~~~~


{lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class AddAddressCokumnsToKiosk < ActiveRecord::Migration[5.0]
  def change
    add_column :kiosks, :line1, :string
    add_column :kiosks, :line2, :string
    add_column :kiosks, :line3, :string
    add_column :kiosks, :locality, :string
    add_column :kiosks, :region, :string
    add_column :kiosks, :postcode, :string
    add_column :kiosks, :country, :string
    add_column :kiosks, :latitude, :string
    add_column :kiosks, :longitude, :string
  end
end
~~~~~~~~




## Esempio 4: Aggiungiamo le colonne video_id e select_media nella tabella posts 

* video_id      : string
* select_media  : integer -> youtube-video, vimeo-video, foto, audio, quote)


{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails g migration AddVideoIdAndSocialMediaToPosts video_id:string select_media:integer
~~~~~~~~

questo crea il migrate:

{title=".../db/migrate/xxx_add_video_id_and_social_media_to_posts.rb", lang=ruby, line-numbers=on, starting-line-number=1}
~~~~~~~~
class AddVideoIdAndSocialMediaToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :video_id, :string
    add_column :posts, :select_media, :integer
  end
end
~~~~~~~~


eseguiamo il migrate 

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ sudo service postgresql start
$ rails db:migrate
~~~~~~~~


Aggiorniamo il controller

aggiungiamo i campi nella withelist di authors/posts

{title=".../db/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=84}
~~~~~~~~
      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params.require(:post).permit(:title, :body, :description, :author_id, :image, :incipit, :sharing_image, :sharing_description, :tag_list, :video_id, :select_media)
      end
~~~~~~~~


Aggiorniamo la view

aggiungiamo i due campi nel partial form della cartella authors/posts

{title=".../app/views/authors/posts/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
~~~~~~~~
          <li class="list-group-item">
            <div class="field">
              <%= form.label :select_media %><!-- menu a cascata -->
              <%= form.text_field :select_media, id: :select_media, class: "form-control" %>
            </div>
          </li>
          <li class="list-group-item">
            <div class="field">
              <%= form.label :video_id %><!-- parte di URL youtube o vimeo che identifica il video -->
              <%= form.text_field :video_id, id: :video_id, class: "form-control" %>
            </div>
          </li>
~~~~~~~~
