# <a name="top"></a> Cap 12.3 - Aggiungiamo la colonna Prezzo

Inseriamo la colonna *price* ad *eg_posts* per formattare i prezzi per le varie valute nel prossimo capitolo.



## Risorse interne

- [99-rails_references/i18n/02-format_date_time_i18n]



## Risorse esterne

- [Rails Internationalization guide](https://guides.rubyonrails.org/i18n.html)



## Apriamo il branch "Add Price Column"

```bash
$ git checkout -b apc
```



## Creiamo la nuova colonna prezzo

Inseriamo la colonna prezzo nella tabella *eg_posts*.

```bash
$ rails g migration AddPriceToEgPosts price:decimal
```

> ATTENZIONE: 
> per gestire colonne con i prezzi e non avere problemi di arrotondamenti utiliziamo il ***data_type "DECIMAL(19, 4)"***.

Quindi modifichiamo il migrate creato inserendo "precisione", "scala" e che il valore di default sia zero e non "nil".

***codice 01 - .../db/migrate/xxx_add_price_to_eg_posts.rb -line: 1***

```ruby
class AddPriceToEgPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :eg_posts, :price, :decimal, precision: 19, scale: 4, default: 0
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/03_01-db-migrate-xxx_add_price_to_eg_posts.rb)

eseguiamo il migrate 

```bash
$ sudo service postgresql start
$ rails db:migrate
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (fic) $ rails db:migrate
== 20220215100206 AddPriceToEgPosts: migrating ================================
-- add_column(:eg_posts, :price, :decimal, {:precision=>19, :scale=>4, :default=>0})
   -> 0.0705s
== 20220215100206 AddPriceToEgPosts: migrated (0.0708s) =======================

user_fb:~/environment/bl7_0 (fic) $ 
```



## Inseriamo nella white list del controller

Inseriamo la nuova colonna *:price* nella white list del controller altrimenti i valori passati con il submit del form non sarebbero gestiti.

***codice 02 - .../app/controllers/eg_posts_controller.rb - line: 71***

```ruby
    # Only allow a list of trusted parameters through.
    def eg_post_params
      params.require(:eg_post).permit(:meta_title, :meta_description, :headline, :incipit, :price, :user_id)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/03_01-db-migrate-xxx_add_price_to_eg_posts.rb)

> Abbiamo lasciato *:user_id* per ultimo solo perché mi piace di più vedere gli indici esterni in fondo.



## Inseriamo il nuovo campo nelle views

Inseriamo il nuovo campo *:price* nelle views *_form* e *_eg_post*.

***codice 03 - .../app/views/eg_posts/_form.html.erb - line 34***

```html+erb
  <div>
    <%= form.label :price, style: "display: block" %>
    <%= form.text_field :price %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/03_03-views-eg_posts-_form.html.erb)


***codice 04 - .../app/views/eg_posts/_eg_post.html.erb - line: 3***

```html+erb
  <p>
    <strong>Price:</strong>
    <%= eg_post.price %>
  </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/03_04-views-eg_posts-_eg_post.html.erb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- https://mycloud9path.amazonaws.com/eg_posts

Modifichiamo un articolo inserendo un valore nel campo *price* e vediamo su *show* o su *index* che è correttamente gestito.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Add price field to eg_posts"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku apc:master
$ heroku run rails db:migrate
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge apc
$ git branch -d apc
```



## Facciamo un backup su Github

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02-format_date_time_i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/04-format_currencies_i18n-it.md)
