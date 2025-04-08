# Blabla

Vediamo stimulus

> StimulusReflex è Stimulus con una libreria più ampia incluso action-cable.
> Con Rails 7 si può ancora usare ma l'opzione di default è hot-cable turbo e stimulus.



## Risorse esterne

- [How to add custom JS file to new rails 7 project](https://stackoverflow.com/questions/70548841/how-to-add-custom-js-file-to-new-rails-7-project)
- [Alpha preview: Modern JavaScript in Rails 7 without Webpack](https://www.youtube.com/watch?v=PtxZvFnL2i0)
- [rails-7-and-import-map-and-loading-custom-js-file](https://stackoverflow.com/questions/71288294/rails-7-and-import-map-and-loading-custom-js-file)

- [Refactoring Javascript with Stimulus Values API & Defaults](https://gorails.com/episodes/refactoring-javascript-with-stimulus-values-api-defaults?autoplay=1)



## Prepariamo la view per testare stimulus

Creiamo il file *mockups/stimulus_demo.html.erb*.

***code: 01 - .../app/views/mockups/stimulus_demo.html.erb - line:1***

```html+erb
<h1>Testiamo stimulus</h1>
```

Aggiungiamolo al *mockups_controller.rb*.

***code: 02 - .../app/controllers/mockups_controller.rb - line:1***

```ruby
def stimulus_demo
  render mockup
end
```

Instadiamolo.

***code: 03 - .../configure/routes.rb - line:1***

```ruby
  get 'mockups/stimulus_demo'
```



## Lo Stimulus Controller *hello*

Stimulus è già installato di default in Rails 7.
I files per gestirlo sono:

- *confing/importmap.rb*
- *javascript/application.js*
- *javascript/custom/uni_toggle.js*

Vediamo come richiamare il controller stimulus *hello_controller.js* che è installato di default in Rails 7.

Si parte da ***importmap.rb***. Vediamo che c'è la chiamata a ***stimulus*** ed è mappato anche il percorso agli stimulus controllers nel percorso *.../app/javascript/controllers*.

***code: 01 - .../config/importmap.rb - line:5***

```ruby
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
```

Poi passiamo ad ***application.js*** dove importiamo gli stimulus controllers.

***code: 02 - .../app/javascript/application.js - line:3***

```javascript
import "controllers"
```

Ed eccoci finalmente allo stimulus controller ***hello***

***code: 03 - .../app/javascript/controllers/hello_controller.js - line:1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World! by Flavio and Stimulus. ^_^"
  }
}
```

Nel controller importiamo stimulus, che abbiamo reso disponibile tramite iportmap. Magicamente il nome del controller è preso dal nome del file e non lo dobbiamo dichiarare all'interno del codice.

Quindi passiamo al codice html che richiama lo stimulus controller *hello*.

***code: 03 - .../app/views/mockups/stimulus_demo.html.erb - line:3***

```html+erb
<div data-controller="hello"></div><!-- This call the 'hello' stimulus controller: .../app/javascript/controllers/hello_controller.js -->
```

> la linea di codice che permette di caricare tutta la parte javascritp è `<%= javascript_importmap_tags %>` che abbiamo messo nel layout. Nel nostro caso il layout *mockups*.



## Lo Stimulus Controller *goodbye*

Creiamo un nuovo controller che chiamiamo *goodbye*.

***code: 03 - .../app/javascript/controllers/goodbye_controller.js - line:1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "Bye Bye World! Un arrivederci da Flavio."
  }
}
```

Non dobbiamo fare nulla su *application.js* ed *importmap* perché tutto quello che è dentro la cartella *javascript/controllers* è già mappato.

Aggiungiamo la chiamata sulla view.

***code: 03 - .../app/views/mockups/stimulus_demo.html.erb - line:3***

```html+erb
<div data-controller="goodbye"></div><!-- This call the 'hello' stimulus controller: .../app/javascript/controllers/goodbye_controller.js -->
```



## Annidiamo lo Stimulus Controller *goodbye*

Mettiamo lo stimulus controller goodbye in una sotto directory.

Creiamo la cartella *mycustomset* e spostiamoci *goodbye_controller.js*.

> La cartella la chiamiamo *mycustomset* e non *my_custom_set* altrimenti dovremmo richiamarla in modo più complicato perché gli underscore "_" gli creano problemi.

***code: 03 - .../app/javascript/controllers/mycustomset/goodbye_controller.js - line:1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "Bye Bye World! Un arrivederci da Flavio."
  }
}
```

Non dobbiamo fare nulla su *application.js* ed *importmap* perché tutto quello che è dentro la cartella *javascript/controllers* è già mappato.

Aggiorniamo la chiamata sulla view.

***code: 03 - .../app/views/mockups/stimulus_demo.html.erb - line:3***

```html+erb
<div data-controller="mycustomset--goodbye"></div><!-- This call the 'hello' stimulus controller: .../app/javascript/controllers/goodbye_controller.js -->
```

> Il percorso del file sulla sottodirectory invece del classico "/" è fatto con due dash "--".



## Mettiamo lo Stimulus Controller *goodbye* su una cartella diversa da *controllers*

Non funziona!

> I files che usano Stimulus lasciamoli all'interno della cartella *controllers*.



## Mettiamo del codice Javascript su una cartella diversa da *controllers*

Creiamo la nuova cartella *components* e ci creiamo un file *custom.js*.

***code: 03 - .../app/javascript/components/custom.js - line:1***

```javascript
blabla
```

Aggiorniamo la chiamata sulla view.

***code: 03 - .../app/views/mockups/stimulus_demo.html.erb - line:3***

```html+erb
blabla
```

Questo non basta. 
Aggiorniamo *importmap* aggiungendo la nuova cartella *components*.

***code: 01 - .../config/importmap.rb - line:5***

```ruby
pin_all_from "app/javascript/components", under: "comps"
```

Poi passiamo ad ***application.js*** dove importiamo gli stimulus controllers.

***code: 02 - .../app/javascript/application.js - line:3***

```javascript
import "comps/custom"
```

