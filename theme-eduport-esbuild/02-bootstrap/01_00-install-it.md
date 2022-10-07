# <a name="top"></a> Cap 3.1 - Installiamo Bootstrap

Già installato in fase iniziale.
**Non** sfruttiamo importmap, ma al momento importmap è ancora troppo giovane.
Inoltre con importmap è meglio usare Propshaft al posto di Sprocket.
Quindi tutto un nuovo ambiente che aspetto di implementare con Rails 8.


## Risorse interne

- []()



## Risorse esterne

-[]()



## Verifichiamo la gemma `bootstrap`

Vediamo che gemma è stata inserita.

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/bootstrap)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/twbs/bootstrap-rubygem)

**Non** è inserita!
Questa gemma è pensata per `importmap` che noi non stiamo usando perché abbiamo inserito l'opzione `-j esbuild --css bootstrap` in fase di creazione della nuova applicazione Rails.

Invece abbiamo `jsbundling-rails` e `cssbundling-rails`.

***code 03 - .../Gemfile - line:18***

```ruby
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"
```

***code 03 - ...continua - line:27***

```ruby
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/theme-eduport-esbuild/02-bootstrap/01_01-gemfile.rb)



## Vediamo lo stylesheets

Verifichiamo lo stylesheets.

L'estensione del file stylesheets/application è già `.scss` e non `.css` come avviene di default.
Questo perché BootStrap sfrutta Sass (Scss).

Inoltre il file non è semplicemente `application` ma è stato rinominato `application.bootstrap`.

***code 02 - .../app/assets/stylesheets/application.bootstrap.scss - line:01***

```scss
@import 'bootstrap/scss/bootstrap';
@import 'bootstrap-icons/font/bootstrap-icons';
```

> Non ci sono le linee di commento iniziali e neanche i comandi `*= require_tree .` e `*= require_self` che invece sono presenti nel file di "default". Questo perché con BootStrap non li usiamo.



## Vediamo il javascript

Verifichiamo il javascript.

***code 03 - .../app/javascript/application.js - line: 1***

```javascript
// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
```



## Vediamo la pre-compilazione della libreria

Verifichiamo l'inserimento nell'initializer per precompilare l'asset-pipeline.

***code 04 - .../config/initializers/assets.rb - line: 8***

```ruby
Rails.application.config.assets.paths << Rails.root.join("node_modules/bootstrap-icons/font")
```

> C'è solo la chiamata alle icone di BootStrap.



## Vediamo il layout principale

Verifichiamo il layout di default.

***code 05 - .../app/views/layouts/application.html.erb - line:01***

```html+erb
<!DOCTYPE html>
<html>
  <head>
    <title>EduportEsbuild</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_include_tag "application", "data-turbo-track": "reload", defer: true %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```


## Fine verifiche

Abbiamo verificato i files principali per lavorare con BootStrap.

> Non ho visto dove è definito "popper" per i pop-up ma credo sia dentro la gemma `jsbundling-rails`.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_00-gemfile_ruby_version.md)
