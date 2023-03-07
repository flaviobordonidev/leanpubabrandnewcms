# <a name="top"></a> Cap migrate.8 - Aggiungi colonna (Add column)



## La sintassi

***code n/a - .../db/migrate/....rb - line:n/a***

```ruby
add_column :table_name, :column_name, type, options
```



## Esempio1: Add price column to eg_posts table

***code n/a - "terminal" - line:n/a***

```ruby
$ rails g migration AddPriceToEgPosts price:decimal
```

***code 01 - .../db/migrate/xxx_add_price_to_eg_posts.rb - line:n/a***

```ruby
    add_column :eg_posts, :price, :decimal, precision: 19, scale: 4, default: 0
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/migrate/06_01-db-migrate-xxx_add_price_to_eg_posts.rb)

> Nota: I parametri messi di "precision" e "scale" sono basati su varie ricerche fatte nel web e coprono la maggior parte dei casi di uso comune.



## Esempio2: Add corporate column to companies table

***code n/a - "terminal" - line:n/a***

```ruby
$ rails g migration AddCorporateToCompanies corporate:string
```

***code: n/a - .../db/migrate/xxx_add_corporate_to_companies.rb - line:n/a***

```ruby
  add_column :companies, :corporate, :string
```



## Esempio3: Add user columns to posts table ***as external_key***

***code n/a - "terminal" - line:n/a***

```ruby
$ rails g migration AddUserToPosts user:references
```

***code: n/a - .../db/migrate/xxx_add_user_to_posts.rb - line:1***

```ruby
class AddUserToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
  end
end
```

> Nota: `add_reference` invece di `add_column`.</br>
> questo aggiunge anche l'indice in automatico.



## Esempio4: Add address columns to kiosks table

***code n/a - "terminal" - line:n/a***

```ruby
$ rails g migration AddAddressColumnsToKiosk line1:string line2:string line3:string locality:string region:string postcode:string country:string latitude:string longitude:string
```


***code: n/a - .../db/migrate/xxx_add_address_columns_to_kiosk.rb - line:1***

```ruby
class AddAddressColumnsToKiosk < ActiveRecord::Migration[5.0]
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
```



## Esempio 4: Aggiungiamo le colonne video_id e select_media nella tabella posts 

- video_id      : string
- select_media  : integer -> youtube-video, vimeo-video, foto, audio, quote)

***code n/a - "terminal" - line:n/a***

```ruby
$ rails g migration AddVideoIdAndSocialMediaToPosts video_id:string select_media:integer
```

questo crea il migrate:

***code: n/a - .../db/migrate/xxx_add_video_id_and_social_media_to_posts.rb - line:1***

```ruby
class AddVideoIdAndSocialMediaToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :video_id, :string
    add_column :posts, :select_media, :integer
  end
end
```

eseguiamo il migrate 

```
$ sudo service postgresql start
$ rails db:migrate
```

Aggiorniamo il controller

aggiungiamo i campi nella withelist di authors/posts

***code: n/a - .../db/controllers/authors/posts_controller.rb - line:1***

```ruby
      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params.require(:post).permit(:title, :body, :description, :author_id, :image, :incipit, :sharing_image, :sharing_description, :tag_list, :video_id, :select_media)
      end
```


Aggiorniamo la view

aggiungiamo i due campi nel partial form della cartella authors/posts

***code: n/a - .../app/views/authors/posts/_form.html.erb - line:1***

```html+erb
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
```
