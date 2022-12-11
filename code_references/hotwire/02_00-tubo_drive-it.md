# <a name="top"></a> Cap hotwire.5 - Turbo Drive examples

Creiamo una nuova applicazione per fare degli esempi di hotwire.
In questo capitolo Cominciamo con Turbo Drive



## Risorse esterne

- [L3: Hotwire - Turbo Drive](https://school.mixandgo.com/targets/257)
- [L3: Hotwire - Turbo Frame](https://school.mixandgo.com/targets/258)
- [L3: Hotwire - Turbo Streams](https://school.mixandgo.com/targets/259)



## Creiamo una nuova app

```bash
$ rails new hotwireexample
$ cd hotwireexample
```



## Creiamo il site_controller, routes e relative views

Creiamo direttamente i files.

***code 01 - .../app/controllers/site_controller.rb - line:1***

```ruby
class SiteController < ApplicationController
  def first; end

  def second; end
end
```


***code 02 - .../config/routes.rb - line:2***

```ruby
  get "site/first"
  get "site/second"
```


***code 03 - .../app/views/site/first.html.erb - line:1***

```html+erb
<h1> first page </h1>

<%= link_to "Second page", site_second_path %>
```

***code 04 - .../app/views/site/second.html.erb - line:1***

```html+erb
<h1> second page </h1>
```



## Vediamo in preview

Partiamo dalla prima pagina `http://192.168.64.3:3000/site/first` 

- Attiviamo l'inspect nel tab network
- premiamo il link

Vediamo che è effettuata una richiesta di tipo *fetch*

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/02_fig01-turbo_drive-inspect_network_fetch.png)



## Disabilitiamo Turbo Drive

***code 05 - .../app/javascript/application.js - line:1***

```javascript
import {Turbo} from "@hotwired/turbo-rails"
import "controllers"

Turbo.session.drive = false;
```

> di default c'è semplicemente `import "@hotwired/turbo-rails"`.</br>
> Noi dichiariamo la variabile `Turbo` per poterne impostare i parametri: `import {Turbo} from "@hotwired/turbo-rails"`</br>
> Infatti chiamiamo la *session* di *Turbo drive* e la dichiariamo *false* per disabilitare Turbo drive



## Vediamo in preview

Partiamo dalla prima pagina `http://192.168.64.3:3000/site/first` 

- Attiviamo l'inspect nel tab network
- premiamo il link

Vediamo che adesso è effettuata una richiesta di tipo *document*. Ossia è ricarcata tutta la pagina.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/hotwire/02_fig02-turbo_drive-inspect_network_document.png)



## Riattiviamo Turbo Drive

Per riattivare Turbo Drive possiamo impostare la sessione su *true*

***code n/a - .../app/javascript/application.js - line:1***

```javascript
import {Turbo} from "@hotwired/turbo-rails"
import "controllers"

Turbo.session.drive = true;
```

Oppure tornare alla configurazione di default

***code 06 - .../app/javascript/application.js - line:1***

```javascript
import "@hotwired/turbo-rails"
import "controllers"
```


## Link_to disattivando Turbo Drive

Adesso che Turbo Drive è di nuovo attivo vediamo come disattivarlo solo in links specifici.

***code 07 - .../app/views/site/first.html.erb - line:3***

```html+erb
<%= link_to "Second page", site_second_path, data: {turbo: false} %>
```

> Anche se Turbo Drive è attivo globalmente non sarà utilizzato in questo link perché gli abbiamo detto esplicitamente nel link_to di essere disattivato.

Se guardiamo in inspect --> network vediamo che è effettuata una richiesta di tipo *document*

> Al posto di `data: {turbo: false}` possiamo usare `'data-turbo': false`



## Forms submit disattivando Turbo Drive

Per quanto riguarda il submit delle forms, il comportamento è un po' diverso. 
Quando fai il submit di un form, Turbo Drive si aspetta come risposta:

- un *redirect* --> Status 303
- un *Error status code* --> Status nel range dei 400 o 500

Se è un *redirect*, allora segue il redirect, carica la nuova pagina ed aggiorne la ***pagina attuale (current page)***  con il codice della nova pagina.

Se è un *Error status code*, allora Turbo Drive ti permette di mostrare i messaggi di errore di validazione (validation errors) o qualsiasi messaggio del genere.