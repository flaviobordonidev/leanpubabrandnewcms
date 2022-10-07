# Stimulus


ATTENZIONE! già installato in 01-base/30-nested_forms_with_stimulus
in questo capitolo implementare solo le differenze ossia ## Inizializiamo stimulus per application




Un JavaScript framework focalizzato nella gestione degli eventi in un modo organizzato. Si sposa bene con Turbolinks ed in pratica rimpiazza jquery. 


Risorse web:

* https://gorails.com/episodes?q=stimulus
* https://github.com/gorails-screencasts/dynamic-nested-forms-with-stimulusjs
* https://www.driftingruby.com/episodes/nested-forms-from-scratch-with-stimulusjs
* https://stackoverflow.com/questions/58205387/rails-nesteds-forms-with-dynamic-fields




## Cos'è turbolinks

è uno strumento per velocizzare il caricamento delle pagine.
Nasce perché si notò che riprodurre il front-end tramite javascript era molto più veloce nel riprodurre la pagina html piuttosto che mandare la "get request" e far ricaricare tutta la pagina dal browser che ricaricava anche tutta la parte javascript e css.
Turbolinks nasce per dare la velocità che si aveva con la "single page" evitando tutta la sua complessità.
Turbolinks intercetta l'evento click ed invece di ricaricare tutta la pagina la aggiorna attraverso ajax. 




## Cos'è stimulus

* https://github.com/stimulusjs/stimulus

A modest JavaScript framework for the HTML you already have
Stimulus is a JavaScript framework with modest ambitions. It doesn't seek to take over your entire front-end—in fact, it's not concerned with rendering HTML at all. Instead, it's designed to augment your HTML with just enough behavior to make it shine. Stimulus pairs beautifully with Turbolinks to provide a complete solution for fast, compelling applications with a minimal amount of effort.

Stimulus è progettato principalmente per prendere "events" che accadono in html ed eseguire del javascript.
Basicamente quello che facciamo è definire dei "data attributes" (ad esempio: data-controller, data-target, data-action, ...) in html e questi sono automaticamente collegati e gestiti da stimulus all'interno di "stimulus controller" files. Questo mantiene organizzato e strutturato il nostro codice e ci evita di creare un javascript "spaghetti code".

Ha tutte le carte in regola per poter diventare una "gemma ufficiale" di una futura versione di Rails.




## Apriamo il branch "Install Stimulus"

{title="terminal", lang=bash, line-numbers=off}
```
$ git checkout -b is
```




## Installiamo Stimulus

seguiamo il manuale di Stimulus

* [Stimulus: manuale](https://stimulusjs.org/handbook/installing)
* [Stimulus: github](https://github.com/stimulusjs/stimulus)

Usiamo webpacker per installare Stimulus.

Da dentro la directoy della nostra app usiamo il comando "bundle exec rails webpacker:install:..."

{caption: "terminal", format: bash, line-numbers: false}
```
$ cd elisinfo
$ bundle exec rails webpacker:install:stimulus


user_fb:~/environment/elisinfo (gs) $ bundle exec rails webpacker:install:stimulus
Appending Stimulus setup code to /home/ubuntu/environment/elisinfo/app/javascript/packs/application.js
      append  app/javascript/packs/application.js
Creating controllers directory
      create  app/javascript/controllers
      create  app/javascript/controllers/hello_controller.js
      create  app/javascript/controllers/index.js
Installing all Stimulus dependencies
         run  yarn add stimulus from "."
yarn add v1.22.4
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@2.1.3: The platform "linux" is incompatible with this module.
info "fsevents@2.1.3" is an optional dependency and failed compatibility check. Excluding it from installation.
info fsevents@1.2.13: The platform "linux" is incompatible with this module.
info "fsevents@1.2.13" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
warning " > webpack-dev-server@3.11.0" has unmet peer dependency "webpack@^4.0.0 || ^5.0.0".
warning "webpack-dev-server > webpack-dev-middleware@3.7.2" has unmet peer dependency "webpack@^4.0.0".
[4/4] Building fresh packages...
success Saved 1 new dependency.
info Direct dependencies
└─ stimulus@1.1.1
info All dependencies
└─ stimulus@1.1.1
Done in 4.51s.
Webpacker now supports Stimulus.js 🎉
```

Attenzione: questo comando già inserisce la cartella javascript/controllers con alcuni files al suo interno.
Nel nostro esempio non usiamo quella cartella ma preferiamo usarer javascript/packs/controllers.


In altenativa potevamo utilizzare il comando "yarn add ..." 

{caption: "terminal", format: bash, line-numbers: false}
```
$ cd elisinfo
$ yarn upgrade
$ yarn add stimulus


user_fb:~/environment/elisinfo (gs) $ yarn add stimulus
yarn add v1.22.4
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@1.2.9: The platform "linux" is incompatible with this module.
info "fsevents@1.2.9" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
warning " > webpack-dev-server@3.8.2" has unmet peer dependency "webpack@^4.0.0".
warning "webpack-dev-server > webpack-dev-middleware@3.7.2" has unmet peer dependency "webpack@^4.0.0".
[4/4] Building fresh packages...
success Saved lockfile.
success Saved 5 new dependencies.
info Direct dependencies
└─ stimulus@1.1.1
info All dependencies
├─ @stimulus/core@1.1.1
├─ @stimulus/multimap@1.1.1
├─ @stimulus/mutation-observers@1.1.1
├─ @stimulus/webpack-helpers@1.1.1
└─ stimulus@1.1.1
Done in 6.64s.
```





## Inizializiamo stimulus per mockups

Faremo delle prove nella nostra view "mockups/page_a" e quindi inizializiamo stimulus per essere referenziato/collegato a questa pagina.

Assicuriamoci che sul "layouts" che vogliamo usare ci sia "javascript_pack_tag" e non "javascript_include_tag". Nel nostro caso è il layout "mockup".

{id: "01-03-01_01", caption: ".../views/layouts/mockup.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 9}
```
    <%#= javascript_include_tag 'application_mockup', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application_mockup', 'data-turbolinks-track': 'reload' %>
```

Volendo possiamo lasciare entrambe le chiamate.

* javascript_include_tag -> richiama l'asset-pipeline (.../app/assets/javascripts/)
* javascript_pack_tag -> richiama webpack (.../app/javascript/packs)


Nel file "application_mockup" di webpack inizializiamo stimulus.

{id: "01-03-01_02", caption: ".../javascript/packs/application_mockup.js -- codice 02", format: JavaScript, line-numbers: true, number-from: 22}
```
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
```


Creiamo la cartella "controllers" in app/javascript/packs e creiamo un nuovo file al suo interno che nominiamo "hello_controller.js". Stimulus vuole il suffisso "_controller" e l'estensione ".js".
E adesso inseriamo del codice

{id: "01-03-01_02", caption: ".../javascript/packs/controllers/hello_controller.js -- codice 03", format: JavaScript, line-numbers: true, number-from: 1}
```
import { Controller } from "stimulus"

export default class extends Controller {
  // qui il codice per rispondere agli eventi delle pagine html
}
```


Andiamo sulla nostra "page_a" ed aggiungiamo una nuova "row" in fondo alla nostra griglia bootstrap e giochiamo con stimulus. Creiamo un div che referenziamo/colleghiamo al nostro "hello_controller.js" attraverso "data-controller="hello"". Dentro mettiamo un input che referenziamo con "data-target="hello.name"". Da notare che non mettiamo solo "name" ma dobbiamo mettere il prefisso "hello." in modo da indicare che appartiene allo stimulus controller "hello_controller.js" (namespacing).
Infine creiamo il pulsante che su evento click mi esegue l'azione "log" del mio "hello_controller.js".

{id: "01-03-01_01", caption: ".../views/mockups/page_a.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<div data-controller="hello">
  <input data-target="hello.name" type="text">
  <button data-action="click->hello#log">Log</button>
</div>
```


Torniamo al nostro stimulus controller "hello_controller.js" ed aggiungiamo l'azione "log".

{id: "01-03-01_02", caption: ".../javascript/packs/controllers/hello_controller.js -- codice 05", format: JavaScript, line-numbers: true, number-from: 1}
```
import { Controller } from "stimulus"

export default class extends Controller {
  log(){
    console.log(this.targets.find("name").value)
  }
}
```

Analiziamo il codice di questa azione:

* this          -> verifica nel "data-controller="hello""
* .targets      -> tutti i "data-target" 
* .find("name") -> trova quello che si chiama "hello.name" 
* .value        -> ne prende il valore
* console.log(  -> lo passa alla log della console




## Verifichiamo preview

{title="terminal", lang=bash, line-numbers=off}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/mockups/page_b

Apriamo nel browser google chrome "view->developer->JavaScript Console", scriviamo qualcosa nel nuovo campo input e premiamo il pulsante "Log". Vedremo apparire nella "JavaScript Console" il testo che abbiamo inserito nel campo input.




## archiviamo su git

{title="terminal", lang=bash, line-numbers=off}
```
$ git add -A
$ git commit -m "Install stimulus"
```




## Pubblichiamo su heroku

{title="terminal", lang=bash, line-numbers=off}
```
$ git push heroku is:master
```




## Chiudiamo il branch

lo lasciamo aperto. Lo chiudiamo nei prossimi capitoli.




## Il codice del capitolo

