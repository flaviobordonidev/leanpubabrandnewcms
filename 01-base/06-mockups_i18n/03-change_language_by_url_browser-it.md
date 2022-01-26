{id: 01-base-06-mockups_i18n-03-change_language_by_url_browser}
# Cap 6.3 -- Cambio lingua tramite parametro su URL o da lingua browser

Cambiomo la lingua della nostra applicazione nei seguenti due modi:

* tramite "params" dell'URL
* tramite impostazione del browser

* tramite scelta dell'utente (questa la implementiamo più avanti al capitolo 8 su authentication_i18n)


Cambiamo la lingua usando "params[:locale]" ad esempio per l'italiano usiamo l'ulr: 

* www.miodominio.com?locale=it



Risorse web:

* [GoRails i18n](https://gorails.com/episodes/how-to-use-rails-i18n?autoplay=1&ck_subscriber_id=361075866)




## Apriamo il branch

non serve perché è rimasto aperto dal capitolo precedente




## Cambio fisso da codice (hard-coded)

Per impostare la lingua nella nosta applicazione, la guida di Rails consiglia di usare “around_action” per impostare il "locale" ma noi usiamo il before_action perché "around_action" non funziona per le traduzioni di “devise”. “around_action” da un livello di sicurezza maggiore e questo era importante fino a qualche anno fa perché “I18n.locale =“ non era tread-safe, ma oggi lo è e quindi possiamo usare tranquillamente un “before_action”.
Avendo impostato il default in italiano adesso impostiamo la visualizzazione in inglese.

{id: "01-06-03_01", caption: ".../app/controllers/appllication_controller.rb -- codice 01", format: ruby, line-numbers: true, number-from: 19}
```
before_action :set_locale

.
.
.

  #-----------------------------------------------------------------------------
  private
  
    #set language for internationalization
    def set_locale
      I18n.locale = :en
    end
```

[tutto il codice](#01-06-03_01all)




## Cambio da params dell'url

Impostiamo il cambio della lingua dal parametro "locale" nell'url.

{id: "01-06-03_02", caption: ".../app/controllers/appllication_controller.rb -- codice 02", format: ruby, line-numbers: true, number-from: 19}
```
      I18n.locale = params[:locale]
```

verifichiamo

* www.miodominio.com?locale=en

Se diamo un valore differente abbiamo un errore, per ovviare impostiamo il default_locale come alternativa.

{caption: ".../app/controllers/appllication_controller.rb -- continua", format: ruby, line-numbers: true, number-from: 19}
```
      I18n.locale = params[:locale] || I18n.default_locale
```

[tutto il codice](#01-06-03_02all)




## Cambio da impostazione browser

Cambiamo la lingua a seconda di come è impostato il nostro browser. 
Per far questo si usa il parametro "Accept-Language" del "HTTP headers".
Per approfondimenti vedi [Mozilla Accept-Language](developer.mozzilla.org/en-US/docs/Web/Headers/Accept-Language)

La stringa che è passata ha la lingua principale con due caratteri minuscoli e poi eventuali sotto-gruppi ed anche una variabile per dare un "peso" che indica le preferenze delle varie lingue.
Ad esempio la stringa:

* Accept-Language : fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7, *;q=0.5

Noi applichiamo una semplice funzione di regex per prendere solo le lingue principali; quelle con i due caratteri in minuscolo:

* [a-z]{2}

Per testare la funzione regex si può usare rubular.com

Prepariamo quindi il metodo "locale_from_header" che ci restituisce una stringa con le due lettere minuscole da passare a I18n.locale.

{id: "01-06-03_03", caption: ".../app/controllers/appllication_controller.rb -- codice 03", format: ruby, line-numbers: true, number-from: 19}
```
  def locale_from_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  end
```

fetch('A', 'B') prende il 'A' se presente altrimenti prende 'B', nel nostro caso se non è presente HTTP_ACCEPT_LANGUAGE è passatta una stringa vuota ''.

Se è impostato il francese otterremo "fr", se è l'inglese otterremo "en", se italiano otterremo "it", ecc...

Aggiungiamo quindi questo metodo come alternativa al "params" già impostato


{id: "01-06-03_03", caption: ".../app/controllers/appllication_controller.rb -- codice 03", format: ruby, line-numbers: true, number-from: 19}
```
      I18n.locale = params[:locale] || locale_from_header || I18n.default_locale
```

[tutto il codice](#01-06-03_02all)


