# <a name="top"></a> Cap 6.4 - Cambio della lingua come sottodirectory dell'URL

> Questo capitolo non lo usiamo nella nostra applicazione perché ci complica la gestione delle routes. 
> Preferiamo usare params[:locale]. 

Comunque, a scopo didattico, questo capitolo tratta come cambiare la lingua con degli urls tipo:

- www.miodominio.com/it
- www.miodominio.com/en



## Implementiamo sulle routes

Mettiamo la selezione della lingua all'interno dell'URL. Così avremo

- localhost:3000/it
- localhost:3000/en

Per far questo mettiamo tutti i nostri percorsi "routes" dentro un blocco "scope".

***code 01 - ...config/routes.rb - line: 2***

```ruby
scope "(:locale)", locale: /en|it/ do
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/04_01-config-routes.rb)

potevamo lasciare uno scope più ampio 

```ruby
scope "(:locale)" do
```

ma questo mi creava un problema di sicurezza. Molto meglio verificare che sia passato un "locale" valido. 
Nel nostro caso o *it* o *en* che ho gestito nei miei files *.yml* con la traduzione.

può essere necessario riavviare il webserver per permettere a Rails di caricare il file *it.yml*.

```bash
$ rails s     (per ripartire)
```



## Verifichiamo preview

**CTRL+C** per stoppare, e poi ripartiamo.

```bash
$ sudo service postgresql start
$ rails s
```

Sul browser vediamo che ...

- https://mycloud9path.amazonaws.com/mockups/page_a





```bash
$ git add -A
$ git commit -m "set i18n static at the end of the URL"
```



## Risolvo problema sui link_to

Avere un blocco *scope* su routes mi crea un problema sul comportamento di default di Rails di tutti i links. 
Per risolverlo associamo il *default_url_options*.

***codice 02 - .../app/controllers/application_controller.rb - line: 21*** 

```ruby
def default_url_options(options = {})
  {locale: I18n.locale}
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/04_01-config-routes.rb)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03-change_language_by_url_browser-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/01-devise_story-it.md)
