# <a name="top"></a> Prepariamo la struttura per le pagine CDN Mockups

Creiamo un mockup che prende lo stile, nel nostro caso Tailwind Css, tramite CDN.
Questo non è consigliato per la produzione ma per creare dei mockups iniziali è molto utile.

(la struttura che creiamo è talmente generica che possiamo caricare anche Bootstrap tramite CDN o un altro framework)



## Creiamo il layout empty

Questo layout richiama la view senza aggiungere nient'altro.

***Codice 01 - .../app/views/layouts/empty.html.erb - linea:1***

```html
<%= yield %>
```

> `yeld` è il codice che richiama ed inserisce al suo posto tutto quello che ho nella vieww.
> Il layout infatti è normalmente usato per lasciare nella view solo quello che ho tra i tags `<body> ... </body>`
> Nel caso particolare di `cdnmockups` invece vogliamo gestire tutta la DOM, ossia la struttura HTML, all'interno delle singole views.



## Il `cdnmockups_controller` e le pagine statiche

Creiamo il controller `cdnmockups_controller` e le pagine statiche per fare le prove con Tailwind css.
Usiamo il `rails generator` che oltre al controller, attiva gli instradamenti e ci crea già anche le views, i tests_unit e l'helper.

> In *views/cdnmockups* mettiamo delle pagine statiche con dei segnaposto invece dei dati presi dal database.

```shell
❯ rails g controller Cdnmockups bs_base tw_base
```

Esempio:

```shell
❯ rails g controller Cdnmockups bs_base tw_base
      create  app/controllers/mockups_controller.rb
       route  get "mockups/bs_grid"
              get "mockups/bs_button"
              get "mockups/bs_navbar"
      invoke  erb
      create    app/views/mockups
      create    app/views/mockups/bs_grid.html.erb
      create    app/views/mockups/bs_button.html.erb
      create    app/views/mockups/bs_navbar.html.erb
      invoke  test_unit
      create    test/controllers/mockups_controller_test.rb
      invoke  helper
      create    app/helpers/mockups_helper.rb
```



## Assegnamo il layout empty alle pagine tramite il controller

Assegnamo singolarmente:

***Codice 02 - .../app/controllers/mockups_controller.rb - linea:1***

```ruby
class CdnmockupsController < ApplicationController

  def bs_base
      render layout: "empty"
  end

  def tw_base
      render layout: "empty"
  end
```

Assegnamolo a tutto il controller:

***Codice 03 - .../app/controllers/mockups_controller.rb - linea:1***

```ruby
class CdnmockupsController < ApplicationController
  layout "empty"

  def bs_base
  end

  def tw_base
  end
```

> Avendolo assegnato a tutto il controller non serve più esplicitare il `render layout: "..."` per ogni azione del controller.



## Vediamo le pagine views/cdnmokups/...

Troviamo tante views quante sono le azioni che abbiamo inserito nel `❯ rails g controller`, nel nostro caso sono due views.
Vediamone una a titolo di esempio.

***Codice 04 - .../app/views/mockups/bs_base.html.erb - linea:1***

```html
<h1>Cdnmockups#bs_base</h1>
<p>Find me in app/views/mockups/bs_base.html.erb</p>
```



## Vediamo gli instradamenti

***Codice 05 - .../config/routes.rb - linea:1***

```ruby
Rails.application.routes.draw do
  get "cdnmockups/bs_base"
  get "cdnmockups/tw_base"
```



## Facciamo partire il server

Verifichiamo di essere nella directory della nostra app `cd /Users/fb/ror/ubuntudream_bs/` e facciamo partire il server.
Invece di usare `rails s` usiamo `bin/dev` perché questo permette di far partire anche dei processi ausiliari, *"auxiliaries watcher processes"*, ad esempio nel caso di utilizzo di `esbuild` o di `tailwindcss`.

```shell
❯ bin/dev
```

Vediamo il risultato nel browser all'url: `http://127.0.0.1:3000/`



## Risorse esterne

- []()


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
