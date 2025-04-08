# <a name="top"></a> Cap 3.1 - Installiamo Bootstrap

Installiamo subito Bootstrap perché è quello che mi ha creato maggiori difficoltà e spesso ho dovuto ripartire da capo con l'applicazione quindi è meglio levarcelo subito dai coioni.

In questo capitolo diamo i comandi secchi senza tante spiegazioni.
Per approfondimenti vedi:

- [code_references/bootstrap/...]

> Il progetto HEY del fondatore di rails usa "propshaft" con "Dart Sass" ma questo forse lo proverò su Rails 8.0 perché ci sono diversi tutorials che dicono sia difficile configurare "Dart Sass"...
> Essendo riuscito a far funzionare "proshaft" con i bundlers "cssbundling-rails e jsbundling-rails" su rails 7.1 resto con questa configurazione.



## Risorse interne

- [code_references/bootstrap/...]



## Risorse esterne

- [code_references/bootstrap/...]
- [Bootstrap 5 + esbuild in Ruby on Rails 7 - usiamo il secondo metodo](https://www.youtube.com/watch?v=jyqjecyCv3A)

tra gli altri visti che non hanno funzionato:
-[Rails 7, Bootstrap 5 e importmaps](https://www.youtube.com/watch?v=ZZAVy67YfPY)

risorse per propahft:
- [Rails "bin/dev" and "rails server"](https://stackoverflow.com/questions/77991991/rails-bin-dev-and-rails-server)
- [Propshaft Rails - Best practices on how to load multiple css files](https://discuss.rubyonrails.org/t/propshaft-rails-best-practices-on-how-to-load-multiple-css-files/80630)
- [How to use CSS in Rails 7 - An Overview](https://learnetto.com/tutorials/how-to-use-css-in-rails-7)
- [Propshaft](https://github.com/rails/propshaft)
- [Propshaft - upgrading](https://github.com/rails/propshaft/blob/main/UPGRADING.md)



## Installiamo la gemma `cssbundling-rails`

```shell
$ bundle add cssbundling-rails
$ ./bin/rails css:install:bootstrap
$ rails s -b 192.168.64.4
```

> il comando `./bin/rails css:install:bootstrap` tra le altre cose crea lo script `.bin/dev` che è quello che useremo al posto di `rails -s`.

Abbiamo la parte css di bootstrap, ma ci manca la parte javascript.



## Installiamo la gemma `jsbundling-rails`

```shell
$ bundle add jsbundling-rails
$ ./bin/rails javascript:install:esbuild
# prende errori.
```

### Risolviamo gli errori

Installiamo con yarn due librerie

```shell
$ yarn add @hotwired/turbo-rails
$ yarn add @hotwired/stimulus
```

Modifichiamo un riga nel file `javascript/application.js` come suggerito dall'errore.

[Codice 01 - .../app/javascript/application.js - linea: 3]()

```javascript
import "./controllers"
```

Sostituiamo tutto il codice nel file `javascript/controllers/index.js`.

[Codice 02 - .../app/javascript/controllers/index.js - linea: 1]()

```javascript
// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application";
```

Togliamo una riga nel file `layouts/application.html.erb`.

[Codice 03 - .../app/views/layouts/application.html.erb - linea: 10]()

```diff
- <%= javasctipt_impormap_tags %>
# togliamo l'intera riga
```

Se non usavamo `-a propshaft` avremmo dovuto fare anche questo cambio:
Togliamo due righe nel file `assets/config/manifest.js`.

[Codice 04 - .../app/assets/config/manifest.js - linea: 2]()

```diff
- //= link_tree ../../javascript .js
- //= link_tree ../../../vendor/javascript .js
# togliamo le intere due righe
```

Adesso possiamo lanciare di nuovo lo script

```shell
./bin/rails javascript:install:esbuild
# adesso non prende più errori
$ rails s -b 192.168.64.4
```

E questa volta non abbiamo errori.
Adesso funziona tutto.

Nel prossimo capitolo verifichiamo i vari componenti di bootsrap.



## Asset-pipeline con propshaft

Al posto di sprocket usiamo propshaft che sarà il default da rails 8.0
Propshaft itself only supports plain CSS. You can write CSS in application.css and any other CSS files in app/assets/stylesheets.


### Non usiamo `@import`

You can also add assets from other directories by configuring config.assets.paths.
You can use `@import` statements.
For example, if you have custom.css you can import it in appplication.css:

```
@import url('/custom.css');
```

However, *there's a problem* with this (as of Feb 2024). In development mode, the browser will *cache application.css*. 
So your imported CSS will load the first time. But if you make *changes in custom.css, they won't show up on subsequent reloads*.


### Usiamo invece `stylesheet tag`

A workaround is to **avoid imports** and **instead** include a **stylesheet tag** per stylesheet **in your view** file:

```html+erb
<%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
<%= stylesheet_link_tag "custom", "data-turbo-track": "reload" %>
```


### Dove mettere i files css

- `assets/stylesheets`
- `vendor/assets/stylesheets`

You can also use any CSS files in **vendor/assets/stylesheets**. For example, if you have simple.css in that directory, you can link to it without changing any configuration:

```
<%= stylesheet_link_tag "simple", "data-turbo-track": "reload" %>
```

Da non usare:
You can also include all stylesheets that are available with a single tag:

```
<%= stylesheet_link_tag :all, "data-turbo-track": "reload" %>
```

However, *if the order of the stylesheets is important for your app, using :all may not work well*.



## Su propshaft `./bin/dev` sostituisce `rails s`

Cosa succede eseguendo `./bin/dev`

If you have a rails app with esbuild and bootstrap, this is what happens when you run `./bin/dev`:

```
bin/dev
|
`-> foreman start -f Procfile.dev
    |
    `-> bin/rails server
    |
    `-> yarn build --watch
    |   `-> node_modules/.bin/esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets --watch
    |
    `-> yarn build:css --watch
        `-> node_modules/.bin/sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules --watch
```

You can see what commands you have configured to run in `Procfile.dev`:

```ruby
# Procfile.dev

web: unset PORT && bin/rails s
js: yarn build --watch
css: yarn build:css --watch
```

Yarn will run your commands from package.json:

```json
// package.json
...
  "scripts": {
    "build": "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets",
    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules"
  }
}
```

Notice that compiled js and css are saved into `app/assets/builds` which is where rails will look for your assets, *if you never run bin/dev that directory would be empty* and you will get errors about missing assets or your assets will not update when you make any changes.

Now I understand that `./bin/dev` refreshes js/css files ..., is this the only reason I should use "./bin/dev" instead of "rails server"

If js and css is the only thing you have in your Procfile.dev then yes, you could run bin/rails server by itself if you're not working on any frontend assets (you could run all those commands separately if you want).

In case it's not clear, *`bin/dev` is for development only*. In production, your assets are precompiled only once, there is no need to watch for changes. If you add other commands to Procfile.dev then you should probably already know what to do with them in production.



## Aggiorniamo `Procfile.dev` per inserire l'opzione `-b 192.168.64.4` in `.bin/dev`

Per far partire il server, invece di usare `$ rails s`, usiamo:

```shell
$ ./bin/dev
```

Come facciamo ad inserire l'opzione `$ rails s -b 192.168.64.4` ?
La inseriamo nel file `Procfile.dev`

[Codice xx - .../Procfile.dev - linea: 1]()

```shell
web: env RUBY_DEBUG_OPEN=true bin/rails server -b 192.168.64.4
css: yarn watch:css
js: yarn build --watch
```

