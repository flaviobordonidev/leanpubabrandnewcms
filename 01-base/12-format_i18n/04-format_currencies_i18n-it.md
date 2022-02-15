# <a name="top"></a> Cap 12.3 - Formattiamo le valute

Formattiamo i prezzi per le varie valute.



## Risorse interne

- [99-rails_references/i18n/02-format_date_time_i18n]



## Risorse esterne

- [Rails Internationalization guide](https://guides.rubyonrails.org/i18n.html)



## Apriamo il branch "Formats i18n Currency"

```bash
$ git checkout -b fic
```



## Formattiamo/Traduciamo i prezzi

Il nuovo campo lavora correttamente ma non ha una buona formattazione. Gestiamola in questo paragrafo. Inoltre la formattazione la rendiamo flessibile per le varie lingue.

In Italia per dividere le migliaia si usa il "." e per le cifre decimali si usa la ",". Negli USA è il contrario. Ad esempio:

- Italia: 1.123.450,50
- USA: 1,123,450.50

Quindi formattiamo in maniera diversa il numero a seconda della lingua che usiamo.

Questo è già stato fatto e lo possiamo trovare nel sito ufficiale di Rails (come ci è anche suggerito nel locale di default en.yml)

# To learn more, please read the Rails Internationalization guide
# available at https://guides.rubyonrails.org/i18n.html.

Nella guida troviamo un riferimento a questo sito per esempi di traduzione in tutte le lingue:

https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale

e da questo possiamo prendere l'italiano

https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/it.yml

e da questo estrarci la parte di formattazione dei numeri


***codice 05 - .../config/locales/it.yml - line: 4***

```yaml
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

Possiamo anche passare argomenti nel metodo i18n translate in questo modo: *%{myvariable}*.

***codice 06 - .../config/locales/it.yml - line: 4***

```yaml
  eg_posts:
    index:
      html_head_title: "Tutti gli articoli"
    show:
      html_head_title: "Art."
      price_for_reports: "Questo ci costa %{price} di soldini"
```

Possiamo variare la *precisione* e mostrare solo due cifre dopo la virgola anche se nel database saranno archiviate le 4 cifre dopo la virgola come definito nel migrate.

Aggiorniamo la views *show* per visualizzare le traduzioni.

***codice 07 - .../app/views/eg_posts/show.html.erb - line: 12***

```html+erb
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

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

- https://mycloud9path.amazonaws.com/eg_posts

e vediamo su *show* le varie formattazioni del campo *price*.



## Aggiorniamo il form

lato show adesso il numero è visualizzato con la formattazione italiana ma nel form si deve ancora usare il "." e non la "," per i decimali. Correggiamo.

***codice 08 - .../app/views/eg_posts/show.html.erb - line: 12***

```html+erb
  <div class="field">
    <%= form.label :price %>
    <%#= form.text_field :price %>
    <%= form.number_field :price, step: :any %>
  </div>
```

Adesso è visualizzata sempre la virgola di default ma possiamo usare entrambi inserendo i valori.


## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "I18n currency field price on eg_posts"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku btep:master
$ heroku run rails db:migrate
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge btep
$ git branch -d btep
```



## Facciamo un backup su Github

```bash
$ git push origin master
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
