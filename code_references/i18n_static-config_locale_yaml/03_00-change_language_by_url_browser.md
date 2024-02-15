# <a name="top"></a> Cap 4.3 - Cambio lingua tramite parametro su URL o da lingua browser

Cambiamo la lingua della nostra applicazione nei seguenti due modi:

- tramite `params` dell'URL
- tramite impostazione del browser
- tramite scelta dell'utente (questa la implementiamo più avanti su 04-users-authentication)

Cambiamo la lingua usando `params[:locale]` ad esempio per l'italiano usiamo l'ulr: 

- www.miodominio.com?locale=it



## Risorse interne

- [ubuntudream/04-i18n_static/03_00-change_language_by_url_browser]()



## Risorse esterne

- [GoRails i18n](https://gorails.com/episodes/how-to-use-rails-i18n?autoplay=1&ck_subscriber_id=361075866)
- [Rails Internationalization (I18n) API](https://guides.rubyonrails.org/i18n.html)
- [Rails I18n, check if translation exists?](https://stackoverflow.com/questions/12353416/rails-i18n-check-if-translation-exists/12353485#12353485)



## Passo 1 - Cambio fisso da codice (hard-coded)

Per attivare il cambio della lingua lavoriamo su `application_controller.rb`. 

Facciamo un primo passo impostando in modo rigido da codice la visualizzazione in inglese che **sovrascrive** la lingua di *default_locale* che abbiamo impostato essere l'italiano.

***Codice 01 - .../app/controllers/application_controller.rb - linea:02***

```ruby
  before_action :set_locale

  #-----------------------------------------------------------------------------
  private

  #set language for internationalization
  def set_locale
    I18n.locale = :en
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_01-controllers-application_controller.rb)

> Per impostare la lingua a livello di *application_controller*, la guida di Rails consiglia di usare *around_action* per impostare il *locale* ma noi usiamo il *before_action* perché *around_action* non funziona per le traduzioni di *devise*.

> *around_action* dà un livello di sicurezza maggiore e questo era importante fino a qualche anno fa perché *I18n.locale =* non era *tread-safe*, ma oggi lo è e quindi possiamo usare tranquillamente un *before_action*.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

Sul browser vediamo che, al posto dei segnoposto, ora c'è la lingua inglese.

- http://192.168.64.3:3000/mockups/page_a



## Passo 2 - Cambio da params dell'url

Impostiamo il cambio della lingua tramite `params[:locale]` nell'url.

***Codice 02 - .../app/controllers/application_controller.rb - linea:08***

```ruby
  def set_locale
    I18n.locale = params[:locale]
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_02-controllers-application_controller.rb)

> Su rails 6 era utile impostare anche la condizione di *or*, data dal doppio *pipe* "||", per il caso in cui non fosse inserito nell'url il `params[:locale]`.<br/>
> `I18n.locale = params[:locale] || I18n.default_locale` <br/>
> Ma su rails 7 si può anche non mettere e funziona tutto.



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Adesso, se nell'url del browser non inseriamo nessun `params[:locale]` abbiamo la lingua italiana (che è quella impostata di default). Per passare alla lingua inglese dobbiamo passare il `params[:locale]` con il valore `en` e lo facciamo inserendo nell'URL il parametro `locale=en`.

- http://192.168.64.3:3000/mockups/page_a
- http://192.168.64.3:3000/mockups/page_a?locale=en 



## Debug

Se è passato nell'url un valore di `params[:locale]` diverso dalle lingue impostate, nel nostro caso diverso da `it` o `en`, riceviamo un errore.

Evitiamo di avere l'errore ed invece di avere l'errore passiamo il *default_locale* (che nel nostro caso è l'italiano).

***Codice 03 - .../app/controllers/application_controller.rb - linea:08***

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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_03-controllers-application_controller.rb)



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Adesso, sul browser, per la lingua inglese dobbiamo passare nell'URL il parametro `locale=en`.
Qualsiasi altro valore diamo sarà presentata la lingua italiana, che è quella impostata di default.

- http://192.168.64.3:3000/mockups/page_a
- http://192.168.64.3:3000/mockups/page_a?locale=en 
- http://192.168.64.3:3000/mockups/page_a?locale=es



## Passo 3 - Inseriamo links per cambiare `params[:locale]`

Aggiungiamo due links per cambiare la lingua assegnando il relativo valore a `params[:locale]`.

***Codice 04 - .../app/views/mockups/page_a.html.erb - linea:06***

```html+erb
  <%= link_to "Inglese", params.permit(:locale).merge(locale: 'en') %> |
  <%= link_to "Italiano", params.permit(:locale).merge(locale: 'it') %> 
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_04-views-mockups-page_a.html.erb)


Per la didattica: Uno switch semplice che ci riporta sempre alla pagina principale: </br>

***Codice n/a - .../app/views/mockups/page_a.html.erb - linea:06***

```html+erb
<ul>
  <li><%= link_to "english", root_paht(locale: :en) %></li>
  <li><%= link_to "italiano", root_paht(locale: :it) %></li>
</ul>
```

## Selezioniamo la lingua dalle impostazione del browser

Se non passiamo nell'URL il `params[:locale]`, lo impostiamo prendendo la lingua da come è impostato il nostro browser.

Per far questo usiamo il parametro `Accept-Language` del `HTTP headers`.

> Per approfondimenti vedi [Mozilla Accept-Language](developer.mozzilla.org/en-US/docs/Web/Headers/Accept-Language)

La stringa che è passata ha la lingua principale con due caratteri minuscoli e poi eventuali sotto-gruppi ed anche una variabile per dare un "peso" che indica le preferenze delle varie lingue.

Vediamo un esempio di stringa di `Accept-Language`:

- Accept-Language : fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7, *;q=0.5

Noi applichiamo una semplice funzione di regex `[a-z]{2}` per prendere solo le lingue principali; quelle con i due caratteri in minuscolo.

Per testare la funzione regex possiamo usare **[rubular.com](https://rubular.com/)**.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_fig01-rubular_regex_verifier.png)

Inseriamo quindi la linea di codice che assegna a `params[:locale]` la stringa con le due lettere minuscole della lingua del browser, se `params[:locale]` non è presente nell'url.

***Codice 05 - .../app/controllers/application_controller.rb - linea:14***

```ruby
      params[:locale] = request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first if params[:locale].blank?
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_05-controllers-application_controller.rb)

> la funzione `fetch('A', 'B')` prende `'A'` se presente altrimenti prende `'B'`, nel nostro caso se non è presente `HTTP_ACCEPT_LANGUAGE` è passatta una stringa vuota `''`. <br/>
> Se è impostato il francese otterremo "fr", se è l'inglese otterremo "en", se italiano otterremo "it", ecc...



## Verifichiamo preview

```bash
$ rails s
```

Non mettiamo nessun `?locale=` nell'url e cambiamo le impostazioni di lingua del browser con la *Google chrome Extension: Locale Switcher*.

- https://mycloud9path.amazonaws.com/mockups/page_a

Vediamo che cambiando la lingua in inglese otteniamo la traduzione in inglese, per tutte le altre invece abbiamo l'italiano che è la lingua di default.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_fig02-browser_language_en.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_fig03-browser_language_it.png)



## Manteniamo il parametro :locale attraverso i links

Facciamo in modo che cliccando su un nuovo link ci portiamo appresso il parametro :locale.

***Codice 05 - .../app/controllers/application_controller.rb - linea:14***

```ruby
    #keep the locale through links
    def default_url_options(options = {})
      {locale: I18n.locale}
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-internationalization_i18n/03_06-controllers-application_controller.rb)

> queste linee di codice mantengono il parametro :locale nell'url anche se clicchiamo su un link che non lo richiama specificamente.

> Per verificarlo dobbiamo creare un link che ci manda ad esempio alla pagina mockups/page_b e vediamo che senza il codice in alto ci perdiamo la lingua impostata, invece con il codice in alto è mantenuta la lingua impostata.



## Salviamo su Git

```bash
$ git add -A
$ git commit -m "set locale via url"
```


## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge cl
$ git branch -d cl
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



## publichiamo su render.com

Andiamo sulla web GUI e premiamo il pulsante del render.

> In realtà quando facciamo il push su github, render.com in automatico fa partire il deploy.



## Verifichiamo in produzione

- https://myapp-1-blabla.herokuapp.com/



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/03_00-change_language_by_url_browser-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/06-mockups_i18n/04_00-change_language_by_subdirectory-it.md)
