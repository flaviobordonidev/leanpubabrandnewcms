# <a name="top"></a> Cap 2.6 - Formattiamo le valute

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

Gestiamo la formattazione per la valuta.
Inoltre la formattazione la rendiamo flessibile per le varie lingue.

> In Italia per dividere le migliaia si usa il punto `.` e per le cifre decimali si usa la virgola `,`. 
> Negli USA è il contrario. Ad esempio:
>
> - Italia: 1.123.450,50
> - USA: 1,123,450.50

Queste formattazioni le abbiamo già acquisite con i files *.yml* che abbiamo scaricato nei capitoli precedenti.

***codice n/a - .../config/locales/en.yml - line: 208***

```yaml
  number:
    currency:
      format:
        delimiter: ","
        format: "%u%n"
        precision: 2
        separator: "."
        significant: false
        strip_insignificant_zeros: false
        unit: "$"
```

***codice n/a - .../config/locales/it.yml - line: 208***

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
```

> se vogliamo che **non** sia visualizzato il simbolo della valuta ('€', '$', ...) variamo *currency -> format -> unit:* da *"€"* a *""*.



## Passaggio di argomenti/variabili alla traduzione

Possiamo anche passare argomenti nel metodo i18n translate in questo modo: *%{myvariable}*.

***codice 01 - .../config/locales/it.yml - line: 218***

```yaml
        price_for_reports: "Questo ci costa %{price} di soldini"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/04_01-config-locales-it.yml)


***codice 02 - .../config/locales/en.yml - line: 218***

```yaml
        price_for_reports: "This costs us %{price} of pennies"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/04_02-config-locales-en.yml)


Aggiorniamo il partial *_eg_post* per visualizzare le traduzioni nelle views *index* e *show*.

***codice 03 - .../app/views/eg_posts/_eg_post.html.erb - line:22***

```html+erb
  <p>
    <strong>Price:</strong>
    <%= eg_post.price %>
    <br> numero formattato: <%= number_to_currency(eg_post.price) %>
    <br> numero formattato con 3 decimali: <%= number_to_currency(eg_post.price, precision: 3) %>
    <br> numero formattato con 4 decimali: <%= number_to_currency(eg_post.price, precision: 4) %>
    <br> numero formattato con 5 decimali: <%= number_to_currency(eg_post.price, precision: 5) %>
    (nel database abbiamo dichiarato 4 decimali quindi la quinta cifra decimale sarà sempre zero)
    <br> numero formattato con frase: <%= t "number.currency.format.price_for_reports", price: number_to_currency(eg_post.price, precision: 2) %>
    <br> numero formattato descrittivo con frase: <%= t "number.currency.format.price_for_reports", price: number_to_human(eg_post.price) %>
  </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/04_03-views-eg_posts-_eg_post.html.erb)

> La *precisione (precision)* che diamo in formattazione è solo "visiva". <br/>
> Nel database saranno archiviate **4 cifre** dopo la virgola, così come definito nel migrate.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b  192.168.64.3
```

apriamolo il browser sull'URL:

- http://192.168.64.3:3000/eg_posts

e vediamo su *show* le varie formattazioni del campo *price*.



## Aggiorniamo il form

Il prezzo lo visualizziamo correttamente adesso lavoriamo lato *immissione (input)* sul *_form*.

***codice 04 - .../app/views/eg_posts/_form.html.erb - line:34***

```html+erb
  <div class="field">
    <%= form.label :price %>
    <%#= form.text_field :price %>
    <%= form.number_field :price, step: :any %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/04_04-views-eg_posts-_form.html.erb)

> l'opzione `step: :any` ci permette di inserire i decimali, altrimenti potremmo mettere solo numeri interi.
>
> Per l'immissione usiamo un campo numerico `form.number_field`. <br/>
> Non usiamo la traduzione perché dovremmo lavorare sul front-end con javascript.
> Comunque nel campo numerico possiamo usare sia la "," che il "." come separatore di decimali.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b  192.168.64.3
```

apriamolo il browser sull'URL:

- http://192.168.64.3:3000/eg_posts

Vediamo che il campo *price* mostra un formato differente a seconda della lingua.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Format i18n price field on eg_posts"
```


## Chiudiamo il branch

Se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge fic
$ git branch -d fic
```



## Facciamo un backup su Github

```bash
$ git push origin main
```



## Pubblichiamo su Heroku

```bash
$ git push heroku fic:main
```

> Il comando `$ heroku run rails db:migrate` non serve perché non abbiamo modificato la struttura del database.



## Verifichiamo in produzione

Inseriamo nell'url del browser: `https://myapp-1-blabla.herokuapp.com/`



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/12-format_i18n/03_00-eg_posts_add_price-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/01_00-roles-overview-it.md)
