# <a name="top"></a> Cap 3.1 - Installiamo Bootstrap

In rails 7 non c'è più l'esigenza di passare per webpack ed è tornato in auge l'asset-pipeline.
Inoltre nell'asset-pipeline al posto di *Sprockets* adesso c'è il più leggero *Propshaft*.

Inoltre si usa `importmap`.



## Risorse interne

- []()



## Risorse esterne

- [Installing Bootstrap Rails 7: A Step-by-Step Guide](https://medium.com/@gjuliao32/installing-bootstrap-rails-7-a-step-by-step-guide-0fc4a843d94f)

- [Rails UJS not firing with Rails 7](https://stackoverflow.com/questions/70767231/rails-ujs-not-firing-with-rails-7)
- [Behind The Scenes: Rails UJS](https://www.ombulabs.com/blog/learning/javascript/behind-the-scenes-rails-ujs.html)
- [Idiomatic Sass processing in Rails 7 - sassc-rails is deprecated](https://stackoverflow.com/questions/71231622/idiomatic-sass-processing-in-rails-7)

- [The Plan for Rails 8](https://fly.io/ruby-dispatch/the-plan-for-rails-8/)
- [Bootstrap 5 in Rails 7 - importmaps & sprockets](https://blog.eq8.eu/til/how-to-use-bootstrap-5-in-rails-7.html)
- [Adding Bootstrap To Rails 7 Using Import map And Solve The Dropdown Problem](https://www.youtube.com/watch?v=tSu8xF0A2ek)
- [Rails 7, Bootstrap 5 e importmaps](https://www.youtube.com/watch?v=ZZAVy67YfPY)



## Cos'è impportmap

Da Rails 7 la gemma `importmap` è installata di default ed in ogni nuova applicazione è presente il suo file di configurazione.

[Codice 01 - .../config/importmap.rb - line: 51]()

```ruby
# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
```

Inportmap è un "indice di libreria" che ti permette di puntare a varie librerie o tramite CDN (quindi repositories remoti) o facendo il download dei pacchetti che ti servono rendondoli disponibili alla nostra applicazione.

Per usare queste librerie, o pacchetti, dobbiamo dire alla nostra applicazione di importarli.

Ad esempio se andiamo sulla cartella *javascript* vediamo alcuni esempi di import.

[Codice 02 - .../app/javascript/application.js - line: 1]()

```javascript
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
```



## Installiamo la gemma `bootstrap`

Adesso iniziamo ad installare *bootstrap*. Partiamo dalla gemma rails.

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/bootstrap)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/twbs/bootstrap-rubygem)

[Codice 03 - .../Gemfile - line:47]()

```ruby
# HTML, CSS, and JavaScript framework 
gem 'bootstrap', '~> 5.3', '>= 5.3.2'

# To process CSS
gem "sassc-rails"
gem 'cssbundling-rails'

# To process Javascript
gem 'jsbundling-rails'
```

- `gem "sassc-rails"` è deprecato ma fino a rails 7.1 ancora serve.
- `gem 'cssbundling-rails'` sostituirà sassc-rails ma ancora non funziona da solo.
- `gem 'jsbundling-rails'` forse potevo evitarlo perché useremo *rails/ujs* con *importmap* nei prossimi paragrafi.

> To process Javascript ci sarebbe la gemma `gem 'jsbundling-rails'` ma noi useremo *rails/ujs* con *importmap* nei prossimi paragrafi.


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```

Esempio

```shell
ubuntu@ub22fla:~/ubuntudream (main)$bundle install
Fetching gem metadata from https://rubygems.org/.........
Resolving dependencies...
Fetching ffi 1.16.3
Installing ffi 1.16.3 with native extensions
Fetching jsbundling-rails 1.3.0
Installing jsbundling-rails 1.3.0
Fetching sassc 2.4.0
Installing sassc 2.4.0 with native extensions
Fetching tilt 2.3.0
Installing tilt 2.3.0
Fetching sassc-rails 2.1.2
Installing sassc-rails 2.1.2
Bundle complete! 18 Gemfile dependencies, 92 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```



## Installiamo `bootstrap`

```shell
$ rails css:install:bootstrap
```

Esempio:

```shell
ubuntu@ub22fla:~/ubuntudream (main)$rails css:install:bootstrap
       apply  /home/ubuntu/.rvm/gems/ruby-3.3.0/gems/cssbundling-rails-1.4.0/lib/install/bootstrap/install.rb
       apply    /home/ubuntu/.rvm/gems/ruby-3.3.0/gems/cssbundling-rails-1.4.0/lib/install/install.rb
    Build into app/assets/builds
      create      app/assets/builds
      create      app/assets/builds/.keep
      append      app/assets/config/manifest.js
    Stop linking stylesheets automatically
        gsub      app/assets/config/manifest.js
      append      .gitignore
      append      .gitignore
    Remove app/assets/stylesheets/application.css so build output can take over
      remove      app/assets/stylesheets/application.css
    Add stylesheet link tag in application layout
   unchanged      app/views/layouts/application.html.erb
    Add default package.json
      create      package.json
    Add default Procfile.dev
      create      Procfile.dev
    Ensure foreman is installed
         run      gem install foreman from "."
Fetching foreman-0.87.2.gem
Successfully installed foreman-0.87.2
Parsing documentation for foreman-0.87.2
Installing ri documentation for foreman-0.87.2
Done installing documentation for foreman after 0 seconds
1 gem installed

A new release of RubyGems is available: 3.5.3 → 3.5.6!
Run `gem update --system 3.5.6` to update your installation.

    Add bin/dev to start foreman
      create      bin/dev
  Install Bootstrap with Bootstrap Icons, Popperjs/core and Autoprefixer
      create    app/assets/stylesheets/application.bootstrap.scss
         run    yarn add sass bootstrap bootstrap-icons @popperjs/core postcss postcss-cli autoprefixer nodemon from "."
yarn add v1.22.21
info No lockfile found.
(node:26677) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
(Use `node --trace-deprecation ...` to show where the warning was created)
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
[4/4] Building fresh packages...
success Saved lockfile.
success Saved 94 new dependencies.
info Direct dependencies
├─ @popperjs/core@2.11.8
├─ autoprefixer@10.4.17
├─ bootstrap-icons@1.11.3
├─ bootstrap@5.3.2
├─ nodemon@3.0.3
├─ postcss-cli@11.0.0
├─ postcss@8.4.35
└─ sass@1.71.0
info All dependencies
├─ @nodelib/fs.scandir@2.1.5
├─ @nodelib/fs.stat@2.0.5
├─ @nodelib/fs.walk@1.2.8
├─ @popperjs/core@2.11.8
├─ @sindresorhus/merge-streams@2.2.1
├─ abbrev@1.1.1
├─ ansi-regex@5.0.1
├─ ansi-styles@4.3.0
├─ anymatch@3.1.3
├─ autoprefixer@10.4.17
├─ balanced-match@1.0.2
├─ binary-extensions@2.2.0
├─ bootstrap-icons@1.11.3
├─ bootstrap@5.3.2
├─ brace-expansion@1.1.11
├─ braces@3.0.2
├─ browserslist@4.23.0
├─ caniuse-lite@1.0.30001587
├─ chokidar@3.6.0
├─ cliui@8.0.1
├─ color-convert@2.0.1
├─ color-name@1.1.4
├─ concat-map@0.0.1
├─ debug@4.3.4
├─ dependency-graph@0.11.0
├─ electron-to-chromium@1.4.673
├─ emoji-regex@8.0.0
├─ fast-glob@3.3.2
├─ fastq@1.17.1
├─ fill-range@7.0.1
├─ fraction.js@4.3.7
├─ fs-extra@11.2.0
├─ get-caller-file@2.0.5
├─ get-stdin@9.0.0
├─ glob-parent@5.1.2
├─ globby@14.0.1
├─ graceful-fs@4.2.11
├─ has-flag@3.0.0
├─ ignore-by-default@1.0.1
├─ ignore@5.3.1
├─ immutable@4.3.5
├─ is-binary-path@2.1.0
├─ is-extglob@2.1.1
├─ is-fullwidth-code-point@3.0.0
├─ is-glob@4.0.3
├─ is-number@7.0.0
├─ jsonfile@6.1.0
├─ lilconfig@3.1.0
├─ lru-cache@6.0.0
├─ merge2@1.4.1
├─ micromatch@4.0.5
├─ minimatch@3.1.2
├─ ms@2.1.2
├─ nanoid@3.3.7
├─ node-releases@2.0.14
├─ nodemon@3.0.3
├─ nopt@1.0.10
├─ normalize-path@3.0.0
├─ normalize-range@0.1.2
├─ path-type@5.0.0
├─ picomatch@2.3.1
├─ pify@2.3.0
├─ postcss-cli@11.0.0
├─ postcss-load-config@5.0.3
├─ postcss-reporter@7.1.0
├─ postcss-value-parser@4.2.0
├─ postcss@8.4.35
├─ pretty-hrtime@1.0.3
├─ pstree.remy@1.1.8
├─ queue-microtask@1.2.3
├─ read-cache@1.0.0
├─ readdirp@3.6.0
├─ require-directory@2.1.1
├─ reusify@1.0.4
├─ run-parallel@1.2.0
├─ sass@1.71.0
├─ simple-update-notifier@2.0.0
├─ slash@5.1.0
├─ source-map-js@1.0.2
├─ string-width@4.2.3
├─ strip-ansi@6.0.1
├─ supports-color@5.5.0
├─ thenby@1.3.4
├─ to-regex-range@5.0.1
├─ touch@3.1.0
├─ undefsafe@2.0.5
├─ unicorn-magic@0.1.0
├─ update-browserslist-db@1.0.13
├─ wrap-ansi@7.0.0
├─ y18n@5.0.8
├─ yallist@4.0.0
├─ yaml@2.3.4
├─ yargs-parser@21.1.1
└─ yargs@17.7.2
Done in 9.59s.
      insert    config/initializers/assets.rb
  Appending Bootstrap JavaScript import to default entry point
      append    app/javascript/application.js
  Pin Bootstrap
      append    config/importmap.rb
      insert    config/initializers/assets.rb
      append    config/initializers/assets.rb
  Add build:css:compile script
         run    npm pkg set scripts.build:css:compile="sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules" from "."
         run    yarn build:css:compile from "."
yarn run v1.22.21
$ sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules
Done in 1.45s.
  Add build:css:prefix script
         run    npm pkg set scripts.build:css:prefix="postcss ./app/assets/builds/application.css --use=autoprefixer --output=./app/assets/builds/application.css" from "."
         run    yarn build:css:prefix from "."
yarn run v1.22.21
$ postcss ./app/assets/builds/application.css --use=autoprefixer --output=./app/assets/builds/application.css
Done in 0.60s.
  Add build:css script
         run    npm pkg set scripts.build:css="yarn build:css:compile && yarn build:css:prefix" from "."
         run    yarn build:css from "."
yarn run v1.22.21
$ yarn build:css:compile && yarn build:css:prefix
$ sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules
$ postcss ./app/assets/builds/application.css --use=autoprefixer --output=./app/assets/builds/application.css
Done in 2.13s.
  Add watch:css script
         run    npm pkg set scripts.watch:css="nodemon --watch ./app/assets/stylesheets/ --ext scss --exec \"yarn build:css\"" from "."
        gsub    Procfile.dev
         run  bundle install
Bundle complete! 18 Gemfile dependencies, 92 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```




## Pin Rails/ujs to Importmap

To ensure that Rails’ Unobtrusive JavaScript (UJS) is included in your importmap, run the following command:

```shell
$ ./bin/importmap pin @rails/ujs
```

This step is essential for Rails to work smoothly with Bootstrap.

Esempio:

```shell
ubuntu@ub22fla:~/ubuntudream (main)$./bin/importmap pin @rails/ujs
Pinning "@rails/ujs" to vendor/javascript/@rails/ujs.js via download from https://ga.jspm.io/npm:@rails/ujs@7.1.3/app/assets/javascripts/rails-ujs.esm.js
ubuntu@ub22fla:~/ubuntudream (main)$
```



## Rails UJS

Unobtrusive JavaScript (UJS) is a web development approach that focuses on minimizing the intrusion of JavaScript code into the HTML content of web pages. By keeping the structure (HTML), presentation (CSS), and behavior (JavaScript) separate, this approach makes the code more maintainable, readable, and reusable.

Rails UJS (Unobtrusive JavaScript) is a library that comes bundled with Rails and helps you create unobtrusive JavaScript in your Rails applications. It achieves this by automatically adding JavaScript functionality to HTML elements based on their attributes.

Consider the following example:

```html+rails
<%= link_to "Delete Post", post_path(@post), method: :delete, data: { confirm: "Are you sure?" } %>
```

In this example, we're using the link_to helper to create a link that deletes a post. The method: :delete attribute tells Rails that this link should send a DELETE request, and the data: { confirm: "Are you sure?" } attribute tells Rails to show a confirmation dialog before proceeding.

Rails UJS automatically handles these attributes, adding the necessary JavaScript functionality to the link without you having to write any JavaScript code yourself.

In pratica Rails UJS ci attiva il "confirm ..." ed altre funzionalità Ajax nei form come remote: true.


When we want to have a *link*, a *button* or a *form* do an AJAX request instead of a standard request, we use, for example: remote: true. 
We have other options like *disable_with: "...loading"*, *confirm: "Are you sure?"* and *method: :post*, the helper methods won’t do anything related to JavaScript but will just add a *data- attribute*.

Rails UJS will read those data attributes during specific events to trigger the enhanced behavior.

```html
link_to "Example", "#", remote: true
=> "<a href='#' data-remote>Example</a>"

button_tag 'Example2', disable_with: "Are you sure?"
=> "<button data-disable-with='Are you sure?'>Example2</button>"
```



## Configure JavaScript

In your `javascript/application.js` file, add the following lines to import Rails UJS and start it:

```javascript
import Rails from “@rails/ujs”
Rails.start()
```

This will enable the JavaScript functionality required for Bootstrap.



## Pin Bootstrap to Importmap

To include Bootstrap in your importmap, run:

```shell
$ ./bin/importmap pin bootstrap
```

Esempio

```shell
ubuntu@ub22fla:~/ubuntudream (main)$./bin/importmap pin bootstrap
Pinning "bootstrap" to vendor/javascript/bootstrap.js via download from https://ga.jspm.io/npm:bootstrap@5.3.2/dist/js/bootstrap.esm.js
Pinning "@popperjs/core" to vendor/javascript/@popperjs/core.js via download from https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js
```



## Specify Bootstrap Version

In your importmap, replace the Bootstrap entry with the following line to specify the Bootstrap version you want to use (in this case, Bootstrap 5.3.2 from a CDN):

bootstrap to: “https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"

This will ensure that your Rails application loads the correct Bootstrap version.














## Importiamo bootstrap nel nostro stylesheets

Innanzitutto, siccome abbiamo attivato Sass (Scss), dobbiamo cambiare l'estensione del file stylesheets/application da `.css` a `.scss`.

Prima                         | Dopo
| :---                        | :--- 
`stylesheets/application.css` | `stylesheets/application.scss`

> be sure you replace your `application.css` with `application.scss`. 
> (That means app/assets/stylesheets/application.css should not exist!)


Adesso aggiorniamo il file.

[Code 04 - .../app/assets/stylesheets/application.scss - line:01]()

```scss
@import "bootstrap";
```

> Nota:
> Cancelliamo le due righe:<br/>
> `*= require_tree .`<br/>
> `*= require_self`<br/>
> perché non sono un semplice commento ma dei comandi che non ci servono.



## Aggiungiamo Bootstrap 5 JS al nostro progetto Rails via importmaps

```bash
$ bin/importmap pin bootstrap --download
```

> l'opzione `--download` scarica localmente la libreria.
> se non la usavamo si creava un puntamento ai CDN (repositories remoti)

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (main)$bin/importmap pin bootstrap --download
Pinning "bootstrap" to vendor/javascript/bootstrap.js via download from https://ga.jspm.io/npm:bootstrap@5.2.1/dist/js/bootstrap.esm.js
Pinning "@popperjs/core" to vendor/javascript/@popperjs/core.js via download from https://ga.jspm.io/npm:@popperjs/core@2.11.6/lib/index.js
ubuntu@ubuntufla:~/ubuntudream (main)$
```

L'esecuzione del comando aggiunge il codice JS, le librerie, e le righe per bootstrap and popperjs su config/importmaps.rb

[Codice n/a - .../config/importmap.rb - line: 51]()

```ruby
pin "bootstrap" # @5.2.1
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.6
```

> `popper` è una libreria di javascript che è utilizzata per il componenete `tooltips` di BootStrap.

ATTENZIONE!
CON LE DUE RIGHE IN ALTO **NON** FUNZIONA!!! (Anche se a vederle sembrano giuste)

Dobbiamo cambiarle:

[Codice 05 - .../config/importmap.rb - line: 51]()

```ruby
pin "popper", to: "popper.js", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true
```

> Non mi è chiaro perché così funziona ma mi adeguo *_* <br/>
> Anche le istruzioni su github della gemma bootstrap riportano righe simili...


Se **NON** avessimo fatto il download avremmo avuto delle chiamate differenti al CDN `ga.jspm.io` che è quello di default. Ad oggi una delle due ha anche un problema infatti consigliano di usare un CDN differente. Nell'esempio di seguito è usato il CDN `unpkg.com`.

Quick Note:
For some reason popperjs acts broken in my Rails7 project when I load it from default ga.jspm.io CDN. That’s why I recommend to load it from unpkg.com:

[Codice n/a - .../config/importmap.rb - line:1]()

```ruby
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.2/dist/esm/index.js" # use unpkg.com as ga.jspm.io contains a broken popper package
```



## Attiviamo le librerie

Then you need to just import bootstrap and popper in your application.js

[Codice 06 - .../app/javascript/application.js - line: 1]()

```javascript
import "popper"
import "bootstrap"
```



## Implementiamo pre-compilazione della libreria

Vamos necessitar que essas bibilotecas se compilem de alguma forma en desarollo para poterla utilizarla.
Para poderse servirla dallo asset-pipeline.

[Codice 07 - .../config/initializers/assets.rb - linea: 1]()

```ruby
Rails.application.config.assets.precompile += %w( bootstrap.min.js popper.js )
```

Abbiamo finito per l'installazione


## Layout files

Make sure your layout (app/views/application.html.erb) contains:

[Codice 08 - .../app/views/layouts/application.html.erb - linea: 1]()

```html+erb
<%# ... %>
<head>
<%# ... %>
<%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>  <%# this loads Sprockets/Rails asset pipeline %>
    <%= javascript_importmap_tags %> <%#  this loads JS from importmaps %>
    <%# ... %>
  </head>
  <!-- ... -->
```
