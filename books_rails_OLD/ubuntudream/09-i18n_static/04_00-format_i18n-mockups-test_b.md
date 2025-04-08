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

[Codice 01 - .../app/views/mockups/test_b.html.erb - linea: 5]()

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

Vediamo in azione la formattazione delle date in italiano ed in inglese

```html+erb
<h3>Date and Time / Data e Ora</h3>
<p>unformatted (Time.now) = <%= Time.now %></p>
<p>yaml short (Time.now) =  <%= l Time.now, format: :short %></p>
<p>yaml long (Time.now) = <%= l Time.now, format: :long %></p>
<p>yaml long ("...".to_datetime) = <%= l "2022-10-08 23:30:28 UTC".to_datetime, format: :long %></p>
<p>yaml long ("...".to_date) = <%= l "2022-10-08 23:30:28 UTC".to_date, format: :long %></p>
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
<h3>Currency / Soldi</h3>
numero non formattato = 123456789,12345
<br> numero formattato: <%= number_to_currency(123456789.12345) %>
<br> numero formattato con 3 decimali: <%= number_to_currency(123456789.12345, precision: 3) %>
<br> numero formattato con 4 decimali: <%= number_to_currency(123456789.12345, precision: 4) %>
<br> numero formattato con 5 decimali: <%= number_to_currency(123456789.12345, precision: 5) %>
```

> La *precisione (precision)* che diamo in formattazione è solo "visiva". <br/>
> Nel database saranno archiviate **4 cifre** dopo la virgola, così come definito nel migrate.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Format with i18n date and currency in the test_b view"
```



## Chiudiamo il branch e archiviamo su Github

```bash
$ git checkout main
$ git merge is
$ git branch -d is
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_00-change_language_by_url_browser-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/04_00-change_language_by_subdirectory-it.md)
