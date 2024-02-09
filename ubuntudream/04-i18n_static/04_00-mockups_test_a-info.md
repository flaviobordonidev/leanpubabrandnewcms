# <a name="top"></a> Cap 1.2 - Aggiungiamo informazioni statiche a Mockups test_a

Inseriamo alcune informazioni nella pagina views `mockups/test_a.html.erb` che traduremo nei prossimi paragrafi.
Al momento, per semplicità, le informazioni che inseriamo non le prendiamo dinamicamente dal database ma le scriviamo staticamente nel codice.
Aggiungeremo informazioni dei seguenti tipi/formati:

- data 
- valuta (prezzi in € e $)
- menu a cascata 



## Risorse interne

-[code_references/i18n_static_config_locale_yaml/03_00-change_language_by_url_browser]()



## Risorse esterne

- []()



## Inseriamo links per cambiare il `params[:locale]`

Aggiungiamo due links per cambiare la lingua assegnando il relativo valore a `params[:locale]`.

*** Codice 01 - .../app/views/mockups/page_a.html.erb - linea: 5 ***

```html
<p>
  <%= link_to "Inglese", params.permit(:locale).merge(locale: 'en') %> |
  <%= link_to "Italiano", params.permit(:locale).merge(locale: 'it') %> 
</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_04-views-mockups-page_a.html.erb)



## Inseriamo dei dati da tradurre

Inseriamo testo, data e valuta.

*** Codice 02 - .../app/views/mockups/page_a.html.erb - linea: 13 ***

```html
<p> testo = "Sono Flavio, quando avevo 5 anni camminavo per la spiaggia" </p>
<p> Data = 01/01/1975 </p>
<p> Soldi = 123456789,12345 </p>
<p> Soldi = 499999999,99999 </p>
<p> Soldi (come li direbbe una persona) = 499999999,99999 </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/02_02-views-layouts-basic.html.erb)



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "Set data to test_a view"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_00-change_language_by_url_browser-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/04_00-change_language_by_subdirectory-it.md)
