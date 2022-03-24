# Installiamo bootstrap tramite webpack



## Dall'asset pipeline a webpack

La migrazione dall'asset pipeline a webpack è stata impostata in maniera graduale. Inizialmente si è pensato di far gestire a webpack solo le librerie javascript (ed in realtà nasce per questo). 
Ed è per questo motivo che nel layouts/application il solo javascript è chiamato con il nuovo helper per webpack "javascript_pack_tag" invece lo stylesheet continua ad usare il vecchio helper per l'asset-pipeline "stylesheet_link_tag".

{id: "01-21-02_01", caption: ".../app/views/layouts/application.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 8}
```
    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
```

[tutto il codice](#01-21-02_01all)

I files del'asset-pipeline sono archiviati nella cartella ".../app/assets" mentre i file webpack sono gestiti nella cartella ".../app/javascript/packs". Come abbiamo detto nel file di default layouts/application si ha un riferimento al file "application.css" utilizzando stylesheet_link_tag (asset pipeline), invece al file "application.js" utilizzando javascript_pack_tag (webpacker).

Con webpacker il file principale "application.js" risiede nella cartella ".../app/javascript/packs" Questo perché Webpacker ora cercherà di compilare tutti i file javascript in questa directory. Questa è l'impostazione predefinita per Webpacker.




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

