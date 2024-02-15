# <a name="top"></a> Cap 4.4 - Le formattazioni di base per le lingue

Aggiungiamo informazioni statiche a Mockups test_a e successivamente implementiamo i files .yml per l'inglese e l'italiano.

Inseriamo alcune informazioni nella pagina views `mockups/test_a.html.erb` che traduciamo nei prossimi paragrafi.
Al momento, per semplicità, le informazioni che inseriamo non le prendiamo dinamicamente dal database ma le scriviamo staticamente nel codice.
Aggiungeremo informazioni dei seguenti tipi/formati:

- links
- data
- valuta (prezzi in € e $)
- menu a cascata 



## Risorse interne

- [code_references/i18n_static-config_locale_yaml/03_00-change_language_by_url_browser]()
- [code_references/i18n_static-config_locale_yaml/05_00-default_format_i18n-it]()
- [code_references-i18n_static-config_locale_yaml-06_00-format_date_time_i18n]()
- [code_references/ruby-data_types_and_i18n/02_00-date_time]()



## Inseriamo links per cambiare il `params[:locale]`

Aggiungiamo due links per cambiare la lingua assegnando il relativo valore a `params[:locale]`.

[Codice 01 - .../app/views/mockups/page_a.html.erb - linea: 5]()

```html
<p>
  <%= link_to t("mockups.test_a.link_to_english"), params.permit(:locale).merge(locale: 'en') %> |
  <%= link_to t("mockups.test_a.link_to_italian"), params.permit(:locale).merge(locale: 'it') %>
</p>
```

[Codice 02 - .../config/locales/en.yml - linea: 35]()

```yml
      link_to_english: "English"
      link_to_italian: "Italian"
```

[Codice 03 - .../config/locales/it.yml - linea: 35]()

```yml
      link_to_english: "Inglese"
      link_to_italian: "Italiano"
```



## I formati di lingue preimpostati

Esistono dei files .yml già compilati dalla comunity sulle varie lingue. 
A partire da questi abbiamo preparato i seguenti due files, uno per la lingua italiana ed uno per la lingua inglese.

[Codice 05 - .../config/locales/it.yml - linea: 35]()

```yml
it:
  activerecord:
    attributes:
      user:
        name: "Nome utente" # fallback for when label is nil
```

[Codice 06 - .../config/locales/en.yml - linea: 35]()

```yml
en:
  activerecord:
    attributes:
      user:
        name: "User name" # fallback for when label is nil
```


Per approfondimenti vedi:

- [code_references/i18n_static_config_locale_yaml/05_00-default_format_i18n-it]()



## Traduciamo le date su mockups/test_a

la formattazione delle date nelle varie lingue
Abbiamo aggiunto i due files `it` e `en` con le formattazioni già impostate. 
Adesso entriamo più in profondità nella formattazione delle *date*.

```html+erb
<p> data: Sat, 08 Oct 2022 23:30:28.257872000 UTC +00:00  </p>

<p>
  <%= Time.now.strftime("day %d %^B %Y") %>
  <%= Time.now.strftime("%A %d %^B %Y at %H:%M and %S seconds") %>
  <br>
  <%= l Time.now, format: :long %>
  <br>
  <%= l Time.now, format: :short %>
</p>
```

> `l` è l'helper per la formattazine della data


Per approfondimento vedi:

- [code_references-i18n_static_config_locale_yaml-06_00-format_date_time_i18n]()



## Formattiamo/Traduciamo i prezzi

Formattiamo le valute
Formattiamo i prezzi per le varie valute.

[Codice 04 - .../app/views/mockups/page_a.html.erb - linea: 13]()

```html
<p> Soldi = 123456789,12345 </p>
<p> Soldi = 499999999,99999 </p>
<p> Soldi (come li direbbe una persona) = 499999999,99999 </p>
```

## Passaggio di argomenti alla traduzione

Possiamo anche passare argomenti nel metodo i18n translate in questo modo: *%{myvariable}*.

***codice 01 - .../config/locales/it.yml - line: 218***

```yaml
        price_for_reports: "Questo ci costa %{price} di soldini"
```

***codice 02 - .../config/locales/en.yml - line: 218***

```yaml
        price_for_reports: "This costs us %{price} of pennies"
```

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

> La *precisione (precision)* che diamo in formattazione è solo "visiva". <br/>
> Nel database saranno archiviate **4 cifre** dopo la virgola, così come definito nel migrate.



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "Format with i18n the data in the test_a view"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_00-change_language_by_url_browser-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/04_00-change_language_by_subdirectory-it.md)
