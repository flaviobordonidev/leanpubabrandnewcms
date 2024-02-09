# <a name="top"></a> Cap 4.3 - Cambio lingua tramite parametro su URL o da lingua browser

Cambiamo la lingua della nostra applicazione tramite `params` dell'URL. 
Lo facciamo usando `params[:locale]`. Ad esempio per l'italiano usiamo l'ulr: `www.miodominio.com?locale=it`



## Risorse interne

-[code_references/i18n_static_config_locale_yaml/03_00-change_language_by_url_browser]()



## Risorse esterne

- [GoRails i18n](https://gorails.com/episodes/how-to-use-rails-i18n?autoplay=1&ck_subscriber_id=361075866)



## Cambio da params dell'url

Per attivare il cambio della lingua lavoriamo su `application_controller.rb`.
Impostiamo il cambio della lingua tramite `params[:locale]` nell'url.


Se è passato nell'url un valore di `params[:locale]` diverso dalle lingue impostate, nel nostro caso diverso da `it` o `en`, riceviamo un errore.
Evitiamo di avere l'errore ed invece di avere l'errore passiamo il *default_locale* (che nel nostro caso è l'italiano).

*** Codice 01 - .../app/controllers/application_controller.rb - linea: 8 ***

```ruby
  def set_locale
    case params[:locale]
    when "it", "en"
      I18n.locale = params[:locale]
    else
      I18n.locale = I18n.default_locale
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_02-controllers-application_controller.rb)




## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Adesso, se nell'url del browser non inseriamo nessun `params[:locale]` abbiamo la lingua italiana (che è quella impostata di default). Per passare alla lingua inglese dobbiamo passare il `params[:locale]` con il valore `en` e lo facciamo inserendo nell'URL il parametro `locale=en`.
Inoltre qualsiasi altro valore diamo a `params[:locale]` sarà presentata la lingua italiana, che è quella impostata di default.

- http://192.168.64.3:3000/mockups/page_a
- http://192.168.64.3:3000/mockups/page_a?locale=en
- http://192.168.64.3:3000/mockups/page_a?locale=es



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "set locale via url"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_00-change_language_by_url_browser-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/04_00-change_language_by_subdirectory-it.md)
