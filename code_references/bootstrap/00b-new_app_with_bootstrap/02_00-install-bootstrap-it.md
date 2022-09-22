# <a name="top"></a> Cap 21.2 - Installiamo Bootstrap

In rails 7 non c'è più l'esigenza di passare per webpack ed è tornato in auge l'asset-pipe-line.

> Lo spiega bene lo sviluppatore rails *DAVID HEINEMEIER HANSSON (DHH)* nel suo post
> [Modern web apps without JavaScript bundling or transpiling - August 12, 2021](https://world.hey.com/dhh/modern-web-apps-without-javascript-bundling-or-transpiling-a20f2755)






Installare BOOTSTRAP ROMPE MOLTO I COGLIONI!!!
Meglio farlo funzionare da subito!!!!

```bash
rails new bl7_0 -j esbuild --css bootstrap --database=postgresql
```





## Risorse interne

- 99-rails_reference/boot_strap/01-bootstrap_intall



## Risorse esterne

- [GoRails #417 · October 11, 2021 - How to use Bootstrap with CSS bundling in Rails](https://gorails.com/episodes/bootstrap-css-bundling-rails?autoplay=1)
- [bootstrap sito ufficiale - Install RubyGems](https://getbootstrap.com/docs/5.1/getting-started/download/#rubygems)
- [How to add bootstrap 5 to an existing Rails 7 app](https://www.uday.net/add-bootstrap-5-to-an-existing-Rails-7-app)
> [Rails 7.0: Fulfilling a vision](https://rubyonrails.org/2021/12/15/Rails-7-fulfilling-a-vision)



https://stackoverflow.com/questions/70921378/how-to-install-jquery-and-bootstrap-in-rails-7-app-using-esbuild-without-webpac

And also tried to install by using

```bash
rails new app -j esbuild --css bootstrap
yarn add jquery
```

You start right! You just need some addition actions

Add to your app/javascript/application.js before JQuery libraries or JQuery scripts

```
import './add_jquery'
```

And create file app/javascript/add_jquery.js:

```
import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery
```

First line import library in local file (add_jquery.js)

Second and third lines make this library global

That's it

And you don't need jquery-rails and bootstrap-sass gems



## Apriamo il branch "BootStrap"

```bash
$ git checkout -b bs
```


## Gemma *bootstrap* vs *CSS bundling*

Perché installare bootstrap tramite la nuova gemma *CSS bundling* quando il sito ufficiale consiglia di installare *bootstrap*?

- Perché con questa gemma è più semplice anche la gestione di Javascript collegato a bootstrap.
- Perché questa è la gemma scelta di default da *rubyonrails.org* 

> [Rails 7.0: Fulfilling a vision](https://rubyonrails.org/2021/12/15/Rails-7-fulfilling-a-vision)
>
> [...] ...you can pre-configure your new Rails app to use any of them with `--css bootstrap` and it’ll use **cssbundling-rails**. [...]

Installing Bootstrap is easier than ever thanks to CSS Bundling in Rails now. It also wires up the Javascript so you don't have to do much of anything.


Questi due articoli invece vanno controcorrente ed usano `gem 'bootstrap'` e `gem "sassc-rails"`.

- [Rails 7, Bootstrap 5 and importmaps without nodejs](https://dev.to/coorasse/rails-7-bootstrap-5-and-importmaps-without-nodejs-4g8)
- [RAILS 7 BOOTSTRAP USING IMPORTMAP](https://jasonfleetwoodboldt.com/courses/stepping-up-rails/rails-7-bootstrap/)



## Installiamo bootstrap con la nuova gemma *CSS bundling*

Se avessimo voluto inserire bootstrap sin dall'inizio avremmo usato un comando tipo `$rails new app-name -j esbuild --css cssbundling-rails` ma avendo già creato la nostra app Rails 7, passiamo all'installazione manuale.

> Nel nostro caso un comando tipo `rails new app-name -j esbuild --css bootstrap --database postgresql`

Step 1

Installiamo le seguenti due gemme:

- `gem 'jsbundling-rails'  # needed for bootstrap javascript`
- `gem 'cssbundling-rails' # Install bootstrap 5`

> jsbundling-rails
>
> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/jsbundling-rails)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/rails/jsbundling-rails)

> cssbundling-rails
>
> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/cssbundling-rails)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/rails/cssbundling-rails)

***codice 01 - .../Gemfile - line:66***

```ruby
# Bundle and transpile JavaScript in Rails with esbuild
gem 'jsbundling-rails', '~> 1.0', '>= 1.0.2'

# Bundle and process CSS with Bootstrap in Rails via Node.js
gem 'cssbundling-rails', '~> 1.1'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_01-Gemfile)


Eseguiamo l'installazione delle gemme con bundle

```bash
$ bundle install
$ rails javascript:install:esbuild
$ rails css:install:bootstrap
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (bs)$bundle install
Fetching gem metadata from https://rubygems.org/..........
Resolving dependencies....
Using rake 13.0.6
Using concurrent-ruby 1.1.9
Using i18n 1.10.0
Using minitest 5.15.0
Using tzinfo 2.0.4
Using activesupport 7.0.2.2
Using builder 3.2.4
Using erubi 1.10.0
Using racc 1.6.0
Using nokogiri 1.13.3 (x86_64-linux)
Using rails-dom-testing 2.0.3
Using crass 1.0.6
Using loofah 2.14.0
Using rails-html-sanitizer 1.4.2
Using actionview 7.0.2.2
Using rack 2.2.3
Using rack-test 1.1.0
Using actionpack 7.0.2.2
Using nio4r 2.5.8
Using websocket-extensions 0.1.5
Using websocket-driver 0.7.5
Using actioncable 7.0.2.2
Using globalid 1.0.0
Using activejob 7.0.2.2
Using activemodel 7.0.2.2
Using activerecord 7.0.2.2
Using marcel 1.0.2
Using mini_mime 1.1.2
Using activestorage 7.0.2.2
Using mail 2.7.1
Using digest 3.1.0
Using io-wait 0.2.1
Using timeout 0.2.0
Using net-protocol 0.1.2
Using strscan 3.0.1
Using net-imap 0.2.3
Using net-pop 0.1.1
Using net-smtp 0.3.1
Using actionmailbox 7.0.2.2
Using actionmailer 7.0.2.2
Using actiontext 7.0.2.2
Using public_suffix 4.0.6
Using addressable 2.8.0
Using aws-eventstream 1.2.0
Using aws-partitions 1.568.0
Using aws-sigv4 1.4.0
Using jmespath 1.6.1
Using aws-sdk-core 3.130.0
Using aws-sdk-kms 1.55.0
Using aws-sdk-s3 1.113.0
Using bcrypt 3.1.16
Using bindex 0.8.1
Using msgpack 1.4.5
Using bootsnap 1.10.3
Using bundler 2.3.7
Using matrix 0.4.2
Using regexp_parser 2.2.1
Using xpath 3.2.0
Using capybara 3.36.0
Using childprocess 4.1.0
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.5.4
Using railties 7.0.2.2
Fetching cssbundling-rails 1.1.0
Installing cssbundling-rails 1.1.0
Using io-console 0.5.11
Using reline 0.3.1
Using irb 1.4.1
Using debug 1.4.0
Using orm_adapter 0.5.0
Using responders 3.0.1
Using warden 1.2.9
Using devise 4.8.1
Using ffi 1.15.5
Using mini_magick 4.11.0
Using ruby-vips 2.1.4
Using image_processing 1.12.2
Using importmap-rails 1.0.3
Using jbuilder 2.11.5
Fetching jsbundling-rails 1.0.2
Installing jsbundling-rails 1.0.2
Using pagy 5.10.1
Using pg 1.3.3
Using puma 5.6.2
Using pundit 2.2.0
Using rails 7.0.2.2
Using rexml 3.2.5
Using rubyzip 2.3.2
Using selenium-webdriver 4.1.0
Using sprockets 4.0.3
Using sprockets-rails 3.4.2
Using stimulus-rails 1.0.4
Using turbo-rails 1.0.1
Using web-console 4.2.0
Using webdrivers 5.0.0
Bundle complete! 23 Gemfile dependencies, 94 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
ubuntu@ubuntufla:~/bl7_0 (bs)$rails javascript:install:esbuild
Compile into app/assets/builds
      create  app/assets/builds
      create  app/assets/builds/.keep
      append  app/assets/config/manifest.js
      append  .gitignore
      append  .gitignore
Add JavaScript include tag in application layout
      insert  app/views/layouts/application.html.erb
Add default package.json
      create  package.json
Add default Procfile.dev
      create  Procfile.dev
Ensure foreman is installed
         run  gem install foreman from "."
Fetching foreman-0.87.2.gem
Successfully installed foreman-0.87.2
Parsing documentation for foreman-0.87.2
Installing ri documentation for foreman-0.87.2
Done installing documentation for foreman after 1 seconds
1 gem installed
Add bin/dev to start foreman
      create  bin/dev
Install esbuild
         run  yarn add esbuild from "."
yarn add v1.22.17
info No lockfile found.
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
[4/4] Building fresh packages...
success Saved lockfile.
warning Your current version of Yarn is out of date. The latest version is "1.22.18", while you're on "1.22.17".
info To upgrade, run the following command:
$ curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
success Saved 2 new dependencies.
info Direct dependencies
└─ esbuild@0.14.27
info All dependencies
├─ esbuild-linux-64@0.14.27
└─ esbuild@0.14.27
Done in 7.46s.
Add build script
         run  npm set-script build "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds" from "."
         run  yarn build from "."
yarn run v1.22.17
$ esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds
✘ [ERROR] Could not resolve "@hotwired/turbo-rails"

    app/javascript/application.js:2:7:
      2 │ import "@hotwired/turbo-rails"
        ╵        ~~~~~~~~~~~~~~~~~~~~~~~

  You can mark the path "@hotwired/turbo-rails" as external to exclude it from the bundle, which
  will remove this error.

✘ [ERROR] Could not resolve "controllers"

    app/javascript/application.js:3:7:
      3 │ import "controllers"
        ╵        ~~~~~~~~~~~~~

  Use the relative path "./controllers" to reference the file "app/javascript/controllers/index.js".
  Without the leading "./", the path "controllers" is being interpreted as a package path instead.

✘ [ERROR] Could not resolve "trix"

    app/javascript/application.js:4:7:
      4 │ import "trix"
        ╵        ~~~~~~

  You can mark the path "trix" as external to exclude it from the bundle, which will remove this
  error.

✘ [ERROR] Could not resolve "@rails/actiontext"

    app/javascript/application.js:5:7:
      5 │ import "@rails/actiontext"
        ╵        ~~~~~~~~~~~~~~~~~~~

  You can mark the path "@rails/actiontext" as external to exclude it from the bundle, which will
  remove this error.

4 errors
node:child_process:869
    throw err;
    ^

Error: Command failed: /home/ubuntu/bl7_0/node_modules/esbuild-linux-64/bin/esbuild app/javascript/application.js --bundle --sourcemap --outdir=app/assets/builds
    at checkExecSyncError (node:child_process:828:11)
    at Object.execFileSync (node:child_process:866:15)
    at Object.<anonymous> (/home/ubuntu/bl7_0/node_modules/esbuild/bin/esbuild:172:28)
    at Module._compile (node:internal/modules/cjs/loader:1103:14)
    at Object.Module._extensions..js (node:internal/modules/cjs/loader:1157:10)
    at Module.load (node:internal/modules/cjs/loader:981:32)
    at Function.Module._load (node:internal/modules/cjs/loader:822:12)
    at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:77:12)
    at node:internal/main/run_main_module:17:47 {
  status: 1,
  signal: null,
  output: [ null, null, null ],
  pid: 1816,
  stdout: null,
  stderr: null
}
error Command failed with exit code 1.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
ubuntu@ubuntufla:~/bl7_0 (bs)$rails css:install:bootstrap
Build into app/assets/builds
       exist  app/assets/builds
   identical  app/assets/builds/.keep
File unchanged! The supplied flag value not found!  app/assets/config/manifest.js
Stop linking stylesheets automatically
        gsub  app/assets/config/manifest.js
File unchanged! The supplied flag value not found!  .gitignore
File unchanged! The supplied flag value not found!  .gitignore
Remove app/assets/stylesheets/application.css so build output can take over
      remove  app/assets/stylesheets/application.css
Add stylesheet link tag in application layout
File unchanged! The supplied flag value not found!  app/views/layouts/application.html.erb
      append  Procfile.dev
Add bin/dev to start foreman
   identical  bin/dev
Install Bootstrap with Bootstrap Icons and Popperjs/core
      create  app/assets/stylesheets/application.bootstrap.scss
         run  yarn add sass bootstrap bootstrap-icons @popperjs/core from "."
yarn add v1.22.17
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
[4/4] Building fresh packages...
success Saved lockfile.
success Saved 20 new dependencies.
info Direct dependencies
├─ @popperjs/core@2.11.4
├─ bootstrap-icons@1.8.1
├─ bootstrap@5.1.3
└─ sass@1.49.9
info All dependencies
├─ @popperjs/core@2.11.4
├─ anymatch@3.1.2
├─ binary-extensions@2.2.0
├─ bootstrap-icons@1.8.1
├─ bootstrap@5.1.3
├─ braces@3.0.2
├─ chokidar@3.5.3
├─ fill-range@7.0.1
├─ glob-parent@5.1.2
├─ immutable@4.0.0
├─ is-binary-path@2.1.0
├─ is-extglob@2.1.1
├─ is-glob@4.0.3
├─ is-number@7.0.0
├─ normalize-path@3.0.0
├─ picomatch@2.3.1
├─ readdirp@3.6.0
├─ sass@1.49.9
├─ source-map-js@1.0.2
└─ to-regex-range@5.0.1
Done in 6.24s.
      insert  config/initializers/assets.rb
Appending Bootstrap JavaScript import to default entry point
      append  app/javascript/application.js
Add build:css script
         run  npm set-script build:css "sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules" from "."
         run  yarn build:css from "."
yarn run v1.22.17
$ sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules
Done in 4.51s.
ubuntu@ubuntufla:~/bl7_0 (bs)$
```



Vediamo che sul file *package.json* abbiamo i due percorsi per *esbuild* e *sass - bootstrap.scss*.

***codice 02 - .../package.json - line:66***

```json
  "scripts": {
    "build": "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds",
    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules"
  }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_02-package.json)



Vediamo che sul file *bin/dev* abbiamo *foreman* che esegue il file *Procfile.dev*.

***codice 03 - .../bin/dev.json - line:66***

```ruby
foreman start -f Procfile.dev "$@"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_03-bin-dev)


Vediamo che sul file *Procfile.dev* abbiamo, oltre a *rails server* anche *yarn* che fa partire la parte javascript e css che usa bootstrap.

***codice 04 - .../Procfile.dev - line:66***

```ruby
web: bin/rails server -p 3000
js: yarn build --watch
css: yarn build:css --watch
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_04-procfile.dev)



## Vediamo l'asset-pipe-line *app/assets*

Vediamo che sulla cartella *app/assets/stylesheets* abbiamo il file *application.bootstrap.scss*.

***codice 05 - .../app/assets/stylesheets/application.bootstrap.scss - line:01***

```scss
@import 'bootstrap/scss/bootstrap';
@import 'bootstrap-icons/font/bootstrap-icons';
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_05-assets-stylesheets-application_bootrap.scss)


Nella cartella *app/assets/builds* abbiamo l'uscita del codice finale *css*.

Nella cartella *app/assets/config* abbiamo la configurazione dell'asset-pipeline nel *manifest.js*.

***codice 06 - .../app/assets/config/manifest.js - line:01***

```javascript
//= link_tree ../images
//= link_tree ../../javascript .js
//= link_tree ../../../vendor/javascript .js
//= link_tree ../builds
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_06-assets-config-manifest.js)

> ATTENZIONE: dobbiamo togliere 2 righe.

Step 2

app/assets/config/manifest.js file should have only the following. (It had 2 extra lines which I had to delete because I was getting errors).

//= link_tree ../images
//= link_tree ../builds

Quindi il file diventa:

***codice 07 - .../app/assets/config/manifest.js - line:01***

```javascript
//= link_tree ../images
//= link_tree ../builds
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_07-assets-config-manifest.js)



## Eseguiamo YARN

Lanciamo il *build:css* con *yarn* che eseguirà il comando *sass* per installare *bootrstrap.scss* e posizionarlo nell'output dell'asset-pipeline *builds*.

```bash
$ yarn run build:css
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0 (bs)$yarn run build:css
yarn run v1.22.17
$ sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules
Done in 4.49s.
ubuntu@ubuntufla:~/bl7_0 (bs)$
```

Infatti vediamo che adesso nella cartella  *app/assets/builds* abbiamo il file *application.css* con tutto lo stile css di bootstrap.

***codice 08 - .../app/assets/builds/application.css - line:01***

```scss
@charset "UTF-8";
/*!
 * Bootstrap v5.1.3 (https://getbootstrap.com/)
 * Copyright 2011-2021 The Bootstrap Authors
 * Copyright 2011-2021 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/main/LICENSE)
 */
:root {
  --bs-blue: #0d6efd;
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_08-assets-builds-application.css)


E con questo l'installazione è CONCLUSA!.
Nel prossimo capitolo vediamo se funziona *_^


---
---


Step 3

Most importatnt step is as follows: (I was getting errors).

Remove code <%= javascript_importmap_tags %> from app/views/layouts/application.html.erb

For whatever installation I tried earlier there is still a file config/importmap.rb But I think it is useless now, once I removed the code above.

I will have to investigate how to use importmap, but for the time being I am going to keep config/importmap.rb as it is in the codebase.


Step 4

Start the server as 

$ ./bin/dev

$rails s ( This did not work in rendering JavaScript. Not sure why. I need to investigate. Also, I am not sure what is the difference in $./bin/dev Vs. $rails server. I must found out.)

Note: I found out the following.

In the rails 7, the new way of running the server is to execute ./bin/dev command. This will spin up few processes, that includes — starts of the the server, and watcher process that observes the CSS an JS files.











## Il pulsante con tooltip per verificare installazione bootstrap

Aggiungiamo al nostro mockups/page_a un pulsante con la gestione del tooltip preso dagli esempi di bootsnap. Così possiamo verificare l'avvenuta installazione di bootstrap per la parte javascript.

{id: "01-21-02_02", caption: ".../app/views/mockups/page_a.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 34}
```
<p>---</p>

<h1>Hello World</h1>
<button type="button" class="btn btn-secondary" data-toggle="tooltip" data-placement="top" title="Tooltip on top">
  Tooltip on top
</button>
```

[tutto il codice](#01-21-02_02all)

Al momento se andiamo sopra con il mouse nel nuovo pulsante non appare nessun tooltip sopra al pulsante perché bootstrap non è installato.




## Installiamo BootStrap

Installiamo Bootstrap come framework di front-end. Possiamo installarlo tramite asset-pipeline o il webpack. Come già spiegato noi usiamo webpack. Esegui il seguente comando "yarn" per installare Bootstrap insieme ad altre 2 librerie dalle quali Bootstrap dipende.

{caption: "terminal", format: bash, line-numbers: false}
```
$ yarn add bootstrap jquery popper.js


user_fb:~/environment/bl6_0 (bs) $ yarn add bootstrap jquery popper.js
yarn add v1.19.1
[1/4] Resolving packages...
warning popper.js@1.16.1: You can find the new Popper v2 at @popperjs/core, this package is dedicated to the legacy v1
[2/4] Fetching packages...
info fsevents@1.2.9: The platform "linux" is incompatible with this module.
info "fsevents@1.2.9" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
warning " > webpack-dev-server@3.8.2" has unmet peer dependency "webpack@^4.0.0".
warning "webpack-dev-server > webpack-dev-middleware@3.7.2" has unmet peer dependency "webpack@^4.0.0".
[4/4] Building fresh packages...
success Saved lockfile.
success Saved 3 new dependencies.
info Direct dependencies
├─ bootstrap@4.4.1
├─ jquery@3.4.1
└─ popper.js@1.16.1
info All dependencies
├─ bootstrap@4.4.1
├─ jquery@3.4.1
└─ popper.js@1.16.1
Done in 5.67s.
```

Questo comando ha installato automaticamente l'ultimo pacchetto bootstrap nei registri di "yarn" ed ha aggiunto le sue dipendenze comprese le loro versioni nel file "package.json". Jquery e popper.js sono librerie da cui dipende bootstrap, specialmente nel loro reparto Javascript.


Una volta installato, verifichiamo il file ".../package.json" per vedere che siano state installate le versioni giuste. Il file "package.json" è simile al file "gemfile.lock" in quanto aiuta l'app a tenere traccia di tutti i plugin installati.

{id: "01-21-02_03", caption: ".../package.json -- codice 03", format: json, line-numbers: true, number-from: 1}
```
{
  "name": "bl6_0",
  "private": true,
  "dependencies": {
    "@rails/actioncable": "^6.0.0-alpha",
    "@rails/actiontext": "^6.0.0",
    "@rails/activestorage": "^6.0.0-alpha",
    "@rails/ujs": "^6.0.0-alpha",
    "@rails/webpacker": "^4.0.7",
    "bootstrap": "^4.4.1",
    "jquery": "^3.4.1",
    "popper.js": "^1.16.1",
    "trix": "^1.0.0",
    "turbolinks": "^5.2.0"
  },
  "version": "0.1.0",
  "devDependencies": {
    "webpack-dev-server": "^3.8.2"
  }
}
```

Possiamo vedere che nel file si fa riferimento a "bootstrap 4.4.1", "jquery 3.4.1" e "popper.js 1.16.1".




## Implementiamo Jquery e Popper
we need to add the dependencies of bootstrap. 
Aggiungiamo le dipendenze di bootstrap (jquery e popper). Per farlo implementiamo nel file ".../config/webpack/environment.js" la mappatura delle librerie Jquery e Popper tramite il plugin "Provide". In modo da permettere ai files javascript di interpretare correttametne gli alias "$", "Jquery" e "Popper". 

{id: "01-21-02_03", caption: ".../config/webpack/environment.js -- codice 03", format: JavaScript, line-numbers: true, number-from: 1}
```
const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)

module.exports = environment
```

Come possiamo vedere, stiamo utilizzando la funzione "ProvidePlugin" di Webpack per aggiungere le librerie per le dipendenze di bootstrap in tutti i pacchetti javascript invece di doverle importare ovunque.

Nota: Non abbiamo usato il ";" alla fine delle linee di codice perché nelle ultime versioni di javascript è opzionale.




## Implementiamo javascript

Aggiungiamo la chiamata a "bootstrap" nel file application.js ed inseriamo il codice per attivare il tooltip.

{id: "01-21-02_03", caption: ".../app/javascript/packs/application.js -- codice 03", format: JavaScript, line-numbers: true, number-from: 1}
```
require("bootstrap")

// javascript code for Bootstrap tooltip
document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
})
...

[tutto il codice](#01-21-02_03all)




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

* https://mycloud9path.amazonaws.com/mockups/page_a

Non abbiamo ancora la formattazione BootStrap perché non abbiamo implementato la parte di stylesheet ma se posizioniamo il cursore sopra il pulsante "tooltip" vediamo che si visualizza la finestrella con la scritta "tooltip". Questa è attivata dalla parte JavaScript di BootStrap.

Nei prossimi paragrafi importiamo lo stylesheet di BootStrap.




## Implementiamo stylesheet

Per lo stile potremmo continuare ad usare l'asset pipeline ma preferiamo migrare anche questa parte a webpack. Per farlo aggiorniamo il file principale in "application.js"

{id: "01-21-02_04", caption: ".../app/javascript/packs/application.js -- codice 04", format: JavaScript, line-numbers: true, number-from: 1}
```
//Stylesheets
require("../stylesheets/application.scss")
...

[tutto il codice](#01-21-02_04all)

Questo codice aggiunge il nostro foglio di stile personalizzato "application.scss" (questo file possiamo chiamarlo come vogliamo e metterlo in qualsiasi cartella, basta che indichiamo il percorso). Per la nostra applicazione lo abbiamo chiamato "application.scss" perché Rails normalmente chiama così i files principali (o di default.).
Per la posizione abbiamo creato una cartella stylesheets dentro la cartella di webpack "javascript". E' una forzatura come posizione perché lo stylesheet non è direttamente legato allo javascript ma in questo caso vogliamo evidenziare che lo stile è gestito da webpack e non dall'asset-pipeline.

Creiamo quindi la nuova cartella "stylesheets" dentro la cartella ".../app/javascript". Mettiamo nella cartella appena creata il file "application.scss".


{id: "01-21-02_05", caption: ".../app/javascript/stylesheets/application.scss -- codice 05", format: ruby, line-numbers: true, number-from: 1}
```
//@import "~bootstrap/scss/bootstrap"; // never forget the semicolon at the end
@import "bootstrap/scss/bootstrap"; // never forget the semicolon at the end

h1 { 
  color: red;
}
```

Nota: Nel caso dello stylesheet il ";" è ancora obbligatorio.
Nota: invece la tilde "~" nel comando di "@import" è facoltativa. Potevamo usare: @import "~bootstrap/scss/bootstrap"; 


Avendo inserito il "require("../stylesheets/application.scss")" in "javascript/packs/application.js" possiamo commentare il "stylesheet_link_tag".

{id: "01-21-02_06", caption: ".../app/views/layouts/application.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 8}
```
    <%#= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
```

Così funziona tutto in locale.


ATTENZIONE: questo non funziona quando andiamo in produzione su heroku. Su Heroku serve "stylesheet_pack_tag"

{id: "01-21-02_06", caption: ".../app/views/layouts/application.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 8}
```
    <%#= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
```

Adesso lo style funziona anche su heroku.




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

* https://mycloud9path.amazonaws.com/mockups/page_a

Adesso possiamo vedere che è attiva anche la parte Stylesheets di BootStrap.




## Piccolo refactoring lato stylesheet

Creiamo il file stylesheet "custom.scss" in cui mettiamo tutto il nostro codice di stile personalizzato.

{id: "01-21-02_07", caption: ".../app/javascript/stylesheets/application.scss -- codice 07", format: JavaScript, line-numbers: true, number-from: 1}
```
@import "bootstrap/scss/bootstrap"; // never forget the semicolon at the end
@import "./custom";
```

Dentro il file "application.scss" archiviamo tutte le chiamate alle librerie css. 

{id: "01-21-02_08", caption: ".../app/javascript/stylesheets/custom.scss -- codice 08", format: JavaScript, line-numbers: true, number-from: 1}
```
h1 { 
  color: green;
}
```




## Salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "install bootstrap via webpacker"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku bs:master
```




## Chiudiamo il branch

lo chiudiamo nel prossimo capitolo dopo aver conferma che bootstrap funziona correttamente




## Il codice del capitolo







---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/01_00-bootstrap_story-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/03_00-grid_examples-it.md)
