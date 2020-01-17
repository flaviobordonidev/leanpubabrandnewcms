{id: 01-base-12-format_i18n-02-format_currencies_i18n}
# Cap 12.2 -- Formattiamo le valute

Formattiamo i prezzi per le varie valute, mantenendo la lingua impostata come default; l'italiano.

Risorse interne:

* 99-rails_references/i18n/02-format_date_time_i18n




## Apriamo il branch




## Creiamo la nuova colonna prezzo

Inseriamo la colonna prezzo nella tabella eg_post.

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g migration AddPriceToEgPosts price:decimal
```


ATTENZIONE: per gestire colonne con i prezzi e non avere problemi di arrotondamenti utiliziamo il data_type "DECIMAL(19, 4)"

Quindi modifichiamo il migrate creato inserendo "precisione", "scala" e che il valore di default sia zero e non "nil".

{caption: ".../db/migrate/xxx_add_price_to_eg_posts.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
class AddPriceToEgPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :eg_posts, :price, :decimal, precision: 19, scale: 4, default: 0
  end
end
```


eseguiamo il migrate 

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate
```




## Inseriamo nella white list del controller

inseriamo la nuova colonna ":price" nella white list del controller altrimenti i valori passati con il submit del form non sarebbero gestiti.

{id: "01-12-02_02", caption: ".../app/controllers/eg_posts_controller.rb -- codice 02", format: ruby, line-numbers: true, number-from: 71}
```
    # Never trust parameters from the scary internet, only allow the white list through.
    def eg_post_params
      params.require(:eg_post).permit(:meta_title, :meta_description, :headline, :incipit, :user_id, :price)
    end
```




## Inseriamo il nuovo campo nelle views

Inseriamo il nuovo campo ":price" nelle views "_form" e "show".

{id: "01-12-02_03", caption: ".../app/views/eg_posts/_form.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 3}
```
  <div class="field">
    <%= form.label :price %>
    <%= form.text_field :price %>
  </div>
```


{id: "01-12-02_04", caption: ".../app/views/eg_posts/show.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 3}
```
<p>
  <strong>Price:</strong>
  <%= @eg_post.price %>
</p>
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/eg_posts

Modifichiamo un articolo inserendo un valore nel campo price e vediamo su "show" che è correttamente gestito.




## Formattiamo/Traduciamo i prezzi

Il nuovo campo lavora correttamente ma non ha una buona formattazione. Gestiamola in questo paragrafo. Inoltre la formattazione la rendiamo flessibile per le varie lingue.

In Italia per dividere le migliaia si usa il "." e per le cifre decimali si usa la ",". Negli USA è il contrario. Ad esempio:

* Italia: 1.123.450,50
* USA: 1,123,450.50

Quindi formattiamo in maniera diversa il numero a seconda della lingua che usiamo.

Questo è già stato fatto e lo possiamo trovare nel sito ufficiale di Rails (come ci è anche suggerito nel locale di default en.yml)

# To learn more, please read the Rails Internationalization guide
# available at https://guides.rubyonrails.org/i18n.html.

Nella guida troviamo un riferimento a questo sito per esempi di traduzione in tutte le lingue:

https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale

e da questo possiamo prendere l'italiano

https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/it.yml

e da questo estrarci la parte di formattazione dei numeri


{id: "01-12-02_05", caption: ".../config/locales/it.yml -- codice 05", format: yaml, line-numbers: true, number-from: 4}
```
  number:
    currency:
      format:
        delimiter: "."
        format: "%n %u"
        precision: 2
        separator: ","
        significant: false
        strip_insignificant_zeros: false
        unit: "€"
    format:
      delimiter: "."
      precision: 2
      separator: ","
      significant: false
      strip_insignificant_zeros: false
    human:
      decimal_units:
        format: "%n %u"
        units:
          billion: Miliardi
          million: Milioni
          quadrillion: Biliardi
          thousand: Mila
          trillion: Bilioni
          unit: ''
      format:
        delimiter: ''
        precision: 3
        significant: true
        strip_insignificant_zeros: true
      storage_units:
        format: "%n %u"
        units:
          byte:
            one: Byte
            other: Byte
          gb: GB
          kb: KB
          mb: MB
          tb: TB
    percentage:
      format:
        delimiter: ''
        format: "%n%"
    precision:
      format:
        delimiter: ''
```

Siccome gestiamo la valuta a parte evitiamo che venga visualizzata modifichiamo in "currency -> format" da " unit: "€" " in " unit: '' ".




## Passaggio di argomenti/variabili alla traduzione

Possiamo anche passare argomenti nel metodo i18n translate in questo modo: "%{myvariable}"

{id: "01-12-02_06", caption: ".../config/locales/it.yml -- codice 06", format: yaml, line-numbers: true, number-from: 4}
```
  eg_posts:
    index:
      html_head_title: "Tutti gli articoli"
    show:
      html_head_title: "Art."
      price_for_reports: "Questo ci costa %{price} di soldini"
```

Possiamo variare la "precisione" e mostrare solo due cifre dopo la virgola anche se nel database saranno archiviate le 4 cifre dopo la virgola come definito nel migrate.

Aggiorniamo la views "show" per visualizzare le traduzioni 

{id: "01-12-02_07", caption: ".../app/views/eg_posts/show.html.erb -- codice 07", format: HTML+Mako, line-numbers: true, number-from: 12}
```
<p>
  <strong>Price:</strong>
  <%= @eg_post.price %>
  <br> numero formattato: <%= number_to_currency(@eg_post.price) %>
  <br> numero formattato con 3 decimali: <%= number_to_currency(@eg_post.price, precision: 3) %>
  <br> numero formattato con 4 decimali: <%= number_to_currency(@eg_post.price, precision: 4) %>
  <br> numero formattato con 5 decimali (oltre i 4 dichiarati nel migrate quindi la quinta cifra decimale è sempre zero perché nel submit del form rails arrotonda): <%= number_to_currency(@eg_post.price, precision: 5) %>
  <br> numero formattato con valuta: <%= number_to_currency(@eg_post.price)+" EUR" %>
  <br> numero formattato con frase: <%= t ".price_for_reports", price: number_to_currency(@eg_post.price, precision: 2)+" EUR" %>
  <br> numero formattato descrittivo: <%= t ".price_for_reports", price: number_to_human(@eg_post.price) %>
</p>
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/eg_posts

e vediamo su "show" le varie formattazioni del campo "price".




## Aggiorniamo il form

lato show adesso il numero è visualizzato con la formattazione italiana ma nel form si deve ancora usare il "." e non la "," per i decimali. Correggiamo.

{id: "01-12-02_08", caption: ".../app/views/eg_posts/show.html.erb -- codice 08", format: HTML+Mako, line-numbers: true, number-from: 12}
```
  <div class="field">
    <%= form.label :price %>
    <%#= form.text_field :price %>
    <%= form.number_field :price, step: :any %>
  </div>
```

Adesso è visualizzata sempre la virgola di default ma possiamo usare entrambi inserendo i valori.




## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "I18n currency field price on eg_posts"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku btep:master
$ heroku run rails db:migrate
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge btep
$ git branch -d btep
```




# Aggiorniamo github

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#01-08b-01_01)

{id="01-08b-01_01all", title=".../app/views/layouts/application.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```

```
