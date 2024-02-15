# <a name="top"></a> Cap 4.3 - Cambio lingua tramite parametro su URL o da lingua browser

Cambiamo la lingua della nostra applicazione tramite il parametro `locale` nell'URL. 
Ad esempio per impostare l'italiano usiamo: `www.miodominio.com?locale=it`

> Il valore passato al parametro `locale` lo ritroviamo nella variabile `params[:locale]`.



## Risorse interne

-[code_references/i18n_static_config_locale_yaml/03_00-change_language_by_url_browser]()



## Cambio da params dell'url

Per attivare il cambio della lingua lavoriamo su `application_controller.rb`.
Impostiamo il cambio della lingua tramite `params[:locale]` nell'url.

> Se è passato nell'url un valore di `params[:locale]` diverso dalle lingue impostate, nel nostro caso diverso da `it` o `en`, invece di riceviamo un errore, richiamiamo il `default_locale`.

[Codice 01 - .../app/controllers/application_controller.rb - linea: 8]()

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



## Verifichiamo preview

Adesso proviamo di nuovo il preview

```shell
$ rails s -b 192.168.64.4
```

E lo visualizziamo nel browser agli url:

- `http://192.168.64.4:3000/mockups/test_a`
- `http://192.168.64.4:3000/mockups/test_a?locale=en`
- `http://192.168.64.4:3000/mockups/test_a?locale=it`
- `http://192.168.64.4:3000/mockups/test_a?locale=es`

> Se nell'url del browser non inseriamo nessun `params[:locale]` abbiamo la lingua italiana (che è quella impostata di default). 
> Per passare alla lingua inglese dobbiamo passare il `params[:locale]` con il valore `en` e lo facciamo inserendo nell'URL il parametro `locale=en`.
> Inoltre qualsiasi altro valore diamo a `params[:locale]` sarà presentata la lingua italiana, che è quella impostata di default.



## Salviamo su Git

```shell
$ git add -A
$ git commit -m "set locale via url"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_00-change_language_by_url_browser-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/04_00-change_language_by_subdirectory-it.md)
