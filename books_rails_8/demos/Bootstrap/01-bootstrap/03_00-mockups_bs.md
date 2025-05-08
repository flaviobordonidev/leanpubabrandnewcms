# <a name="top"></a> Mockups per verifica componenti BootStrap

Creiamo la cartella `mockups` in cui inserire i files statici in cui gestiamo solo la grafica della parte front-end:
- Ai files dedicati ai componenti di default bootstrap mettiamo il prefisso `bs_`.
- Ai files dedicati alla nostra applicazione UbuntuDream mettiamo il prefisso `ud_`.

> *mockups* è una directory in cui mettiamo delle pagine statiche con dei segnaposto invece dei dati presi dal database.

Creiamo poi anche dei `layouts` dedicati ai mockups:
- `.../app/views/layouts/mockups` che è una copia del layout di default `application`. Questo ci permette di modificare `application` mano a mano che l'applicazione evolve e lasciare invariata la parte dei `mockups`.
- `.../app/views/layouts/mockups_js` quì aggiungo i puntamenti ai files javascript messi direttamente in `.../pubblic`



## Generiamo il controller Mockups

Generiamo il controller Mockups con azioni e relative views per fare le prove di componenti bootstrap su pagine statiche (pagine che non prendono dati dal database).

Il controller `mockups_controller` è più per lo sviluppatore, o meglio per il web designer, per tenere da parte i bozzetti statici dell'applicazione.

Iniziamo inserendo le seguenti 3 pagine per alcuni componenti di default di bootstrap:
- `bs_grid`
- `bs_button`
- `bs_navbar`

Usiamo il `rails generator` che oltre al controller, attiva gli instradamenti e ci crea già anche le views, i tests_unit e l'helper.

```shell
$ rails g controller Mockups bs_grid bs_button bs_navbar
```

Esempio:

```shell
❯ rails g controller Mockups bs_grid bs_button bs_navbar
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



## Vediamo il controller mockups_controller

***Codice 01 - .../app/controllers/mockups_controller.rb - linea:1***

```ruby
class MockupsController < ApplicationController
  def bs_grid
  end

  def bs_button
  end

  def bs_navbar
  end
end
```


## Vediamo le pagine views/mokups/bs_...

***Codice 02 - .../app/views/mockups/bs_grid.html.erb - linea:1***

```html
<h1>Mockups#bs_grid</h1>
<p>Find me in app/views/mockups/bs_grid.html.erb</p>
```


***Codice 03 - .../app/views/mockups/bs_button.html.erb - linea:1***

```html
<h1>Mockups#bs_button</h1>
<p>Find me in app/views/mockups/bs_button.html.erb</p>
```


***Codice 04 - .../app/views/mockups/bs_frontend.html.erb - linea:1***

```html
<h1>Mockups#bs_navbar</h1>
<p>Find me in app/views/mockups/bs_navbar.html.erb</p>
```



## Vediamo gli instradamenti

***Codice 05 - .../config/routes.rb - linea:1***

```ruby
Rails.application.routes.draw do
  get "mockups/bs_grid"
  get "mockups/bs_button"
  get "mockups/bs_navbar"
```

***Codice 05 - .../config/routes.rb - linea:17***

```ruby
  root "mockups#bs_grid"
```



## Creiamo il custom layout mockup

Questo layout, che è una copia dell'application layout di default, è dedicato ai mockups. 

***Codice 06 - .../views/layouts/mockup.html.erb - linea:1***

```html
<!DOCTYPE html>
<html>
  <head>
    <title><%= content_for(:title) || "Ubuntudream Bs" %></title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="mobile-web-app-capable" content="yes">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= yield :head %>

    <%# Enable PWA manifest for installable apps (make sure to enable in config/routes.rb too!) %>
    <%#= tag.link rel: "manifest", href: pwa_manifest_path(format: :json) %>

    <link rel="icon" href="/icon.png" type="image/png">
    <link rel="icon" href="/icon.svg" type="image/svg+xml">
    <link rel="apple-touch-icon" href="/icon.png">

    <%# Includes all stylesheet files in app/assets/stylesheets %>
    <%= stylesheet_link_tag :app, "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
  </head>

  <body>
    <h1>CUSTOM LAYOUT PER I MOCKUPS</h1>
    <%= yield %>
  </body>
</html>
```

> Ho aggiunto la riga  `<h1>CUSTOM LAYOUT PER I MOCKUPS</h1>` per fare un test ma poi la tolgo



## Assegnamo il layout mockups alle pagine tramite il controller

Assegnamo singolarmente:

***Codice 07 - .../app/controllers/mockups_controller.rb - linea:1***

```ruby
class MockupsController < ApplicationController

  def bs_grid
      render layout: "mockup"
  end
```

Assegnamolo a tutto il controller:

***Codice 08 - .../app/controllers/mockups_controller.rb - linea:1***

```ruby
class MockupsController < ApplicationController
  layout "mockup"

  def bs_grid
  end
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
