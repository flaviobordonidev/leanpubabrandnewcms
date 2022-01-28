# <a name="top"></a> Cap 6.3 - Cambio lingua tramite parametro su URL o da lingua browser

Cambiamo la lingua della nostra applicazione nei seguenti due modi:

- tramite "params" dell'URL
- tramite impostazione del browser
- tramite scelta dell'utente (questa la implementiamo più avanti al capitolo 8 su authentication_i18n)

Cambiamo la lingua usando "params[:locale]" ad esempio per l'italiano usiamo l'ulr: 

- www.miodominio.com?locale=it



## Risorse web:

- [GoRails i18n](https://gorails.com/episodes/how-to-use-rails-i18n?autoplay=1&ck_subscriber_id=361075866)



## Apriamo il branch

non serve perché è rimasto aperto dal capitolo precedente



## Passo 1 - Cambio fisso da codice (hard-coded)

Per il cambio dinamico della lingua useremo *application_controller.rb*. Facciamo un primo passo impostando in modo rigido da codice la visualizzazione in inglese che sovrascrive la lingua di *default_locale* che abbiamo impostato essere quella in italiano.

Per impostare la lingua a livello di *application_controller*, la guida di Rails consiglia di usare *around_action* per impostare il *locale* ma noi usiamo il *before_action* perché *around_action* non funziona per le traduzioni di *devise*.

> *around_action* da un livello di sicurezza maggiore e questo era importante fino a qualche anno fa perché *I18n.locale =* non era *tread-safe*, ma oggi lo è e quindi possiamo usare tranquillamente un *before_action*.

***codice 01 - .../app/controllers/application_controller.rb - line: 2***

```ruby
  before_action :set_locale

  #-----------------------------------------------------------------------------
  private
  
    #set language for internationalization
    def set_locale
      I18n.locale = :en
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_01-controllers-application_controller.rb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

Sul browser vediamo che, al posto dei segnoposto, ora c'è la lingua inglese.

- https://mycloud9path.amazonaws.com/mockups/page_a



## Passo 2 - Cambio da params dell'url

Impostiamo il cambio della lingua dal parametro *locale* nell'url.

***codice 02 - .../app/controllers/application_controller.rb - line: 8***

```ruby
    def set_locale
      I18n.locale = params[:locale]
    end
```

> Su rails 6 era utile impostare anche la condizione di "or" (*||*) per impostare il default_locale in caso non fosse passato il parametro *locale=* sull'url.
> `I18n.locale = params[:locale] || I18n.default_locale`



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

Adesso, sul browser, per la lingua inglese dobbiamo passare nell'URL il parametro *locale=en*.

- https://mycloud9path.amazonaws.com/mockups/page_a
- https://mycloud9path.amazonaws.com/mockups/page_a?locale=en 


## Debug

Se diamo un valore differente da *it* o *en* abbiamo un errore, per ovviare impostiamo il *default_locale* come alternativa.

***codice 03 - .../app/controllers/application_controller.rb - line: 8***

```ruby
    def set_locale
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_02-controllers-appllication_controller.rb)



## Cambiamo da impostazione browser

Cambiamo la lingua a seconda di come è impostato il nostro browser. 
Per far questo si usa il parametro "Accept-Language" del "HTTP headers".
Per approfondimenti vedi [Mozilla Accept-Language](developer.mozzilla.org/en-US/docs/Web/Headers/Accept-Language)

La stringa che è passata ha la lingua principale con due caratteri minuscoli e poi eventuali sotto-gruppi ed anche una variabile per dare un "peso" che indica le preferenze delle varie lingue.
Ad esempio la stringa:

- Accept-Language : fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7, *;q=0.5

Noi applichiamo una semplice funzione di regex per prendere solo le lingue principali; quelle con i due caratteri in minuscolo:

- [a-z]{2}

Per testare la funzione regex si può usare rubular.com

Prepariamo quindi il metodo "locale_from_header" che ci restituisce una stringa con le due lettere minuscole da passare a I18n.locale.

***codice 03 - .../app/controllers/appllication_controller.rb - line: 1***

```ruby
  def locale_from_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  end
```

fetch('A', 'B') prende il 'A' se presente altrimenti prende 'B', nel nostro caso se non è presente HTTP_ACCEPT_LANGUAGE è passatta una stringa vuota ''.

Se è impostato il francese otterremo "fr", se è l'inglese otterremo "en", se italiano otterremo "it", ecc...

Aggiungiamo quindi questo metodo come alternativa al "params" già impostato

***codice 03 - .../app/controllers/appllication_controller.rb - line: 1***

```
      I18n.locale = params[:locale] || locale_from_header || I18n.default_locale
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_02-controllers-appllication_controller.rb)



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "set locale via url"
```



## publichiamo su heroku

```bash
$ git push heroku mi:main
```



## Verifichiamo in produzione

- https://myapp-1-blabla.herokuapp.com/

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/02_fig02-heroku_i18n_page_a.png)



## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo






---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/01-mockups_i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03-change_language_by_url_browser-it.md)
