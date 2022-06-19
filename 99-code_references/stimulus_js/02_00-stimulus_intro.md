# <a name="top"></a> Cap ajax_asynchronous_javascript - Stimulus javascript framework introudction

Introduciamo il framework "stimulus".
A modest JavaScript framework for the HTML you already have.
Stimulus continuously watches the page, kicking in as soon as **attributes** appear or disappear. 



## Risorse esterne

- [GoRails: Stimulus JS Framework Introduction](https://gorails.com/episodes/stimulus-js-framework-introduction?autoplay=1)
- [GoRails: How to use Stimulus JS 2.0](https://www.youtube.com/watch?v=AEPIotNWFOM)

- [main site](https://stimulus.hotwired.dev/)
- [handbook](https://stimulus.hotwired.dev/handbook/introduction)
- [references](https://stimulus.hotwired.dev/reference/controllers)
- [github: stimulus - sourcecode](https://github.com/hotwired/stimulus)
- [community](https://discuss.hotwired.dev/)

- [Lista di eventi](https://www.w3schools.com/tags/ref_eventattributes.asp)



## Cos'è Stimulus

Stimulus è un'alternativa a Jquery.
Stimulus si concentra solo sull'intercettare ed il rispondere agli *eventi*.
**Non** fa *ajax requests*, non *handles states*, non *render html*. (Queste sono cose di *turbo* e *hot wire*)



## Come funziona

Lato HTML dobbiamo semplicemente inserire dei *data attributes* tipo:

- `data-controller`
- `data-target`
- `data-action`

e lato javascript implementiamo il relativo *stimulus controller* con funzioni e variabili.

> Nella versione 2.0 la parte `data-target` è cambiata. <br/>
> usiamo `data-[stimulus_controller_name]-target="[variable_name]"` invece di `data-target="[stimulus_controller_name]-[variable_name]"` <br/>
> Ad esempio se abbiamo uno *stimulus controller* che si chiama `hello_controller.js` e vogliamo usare una variabile che chiamiamo `foobar` lato html useremo questo *data attribute*: `data-hello-target="foobar"` invece di `data-target="hello.foobar"`.

 
## L'esempio *myhello*

Creiamo il nostro primo codice stimulus.
Useremo uno *stimulus controller* che chiamiamo *myhello*.

***codice 01 - .../app/views/pages/stimulus_hello.html.erb - line:1***

```html+erb
<div data-controller="myhello">
  <label>My first name</label>
  <input data-myhello-target="first_name" type="text">
  <button data-action="click->myhello#log">put in the Log of javascript console</button>
</div>
```

> `data-controller` -> `data-controller="myhello"` -> Nome *stimulus controller* : `myhello` <br/>
> `data-target` -> `data-myhello-target="first_name"` ->  Nome variabile : `first_name` <br/>
> `data-action` -> `data-action="click->myhello#log"` -> Tipo di azione (nome evento): `click`

> Esempi di eventi comuni: onclick, onsubmit, onpaste, onkeyup, ...
> [Lista di eventi](https://www.w3schools.com/tags/ref_eventattributes.asp)

Creiamo lo *stimulus controller* `myhello`.

***codice 02 - .../app/javascript/controllers/myhello_controller.js - line:1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  log(){
    console.log(this.targets.find("first_name").value)
  }

}
```

> `data-action="click->myhello#log"` indica a stimulus che sull'evento `click` chiamiamo il metodo `log` dello *stimulus controller* `myhello`.

> `log(){...}` <- il metodo `log` nello *stimulus controller* `myhello`.

> `this.targets.find("first_name").value` <- prende il valore della variabile `first_name`.





## Creiamo un data-action sull'input

Facciamo in modo che non si possa incollare (paste) nessun valore sul campo input "first_name".

***codice 01 - .../app/views/pages/stimulus_hello.html.erb - line:1***

```html+erb
<div data-controller="myhello">
  <label>My first name</label>
  <input data-myhello-target="first_name" type="text" data-action="paste->myhello#paste">
  <button data-action="click->myhello#log">put in the Log of javascript console</button>
</div>
```

Aggiungiamo il metodo `paste` allo *stimulus controller* `myhello`.

***codice 02 - .../app/javascript/controllers/myhello_controller.js - line:1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  log(){
    console.log(this.targets.find("first_name").value)
  }

  paste(event){
    event.preventDefault()
    console.log("paste are not allowed")
  }

}
```


## Lo *state* delle variabili su *stimulus*

Parliamo dello "state" di questi componenti, osssia di come mantenere delle variabili con dei valori.
Lo *state* è molto diverso da quello che conosciamo su "react" o "vue" perché lì è basato su jason.
Invece in *stimulus* ti incoraggiano ad usare *html data attributes* per farlo.

Ad esempio, se vogliamo passare un valore di default per il nome, lo facciamo come *data attribute* `data-myhello-name="Flavio"`


```html+erb
<div data-controller="myhello" data-myhello-name="Flavio">
  <label>My first name</label>
  <input data-myhello-target="first_name" type="text" data-action="paste->myhello#paste">
  <button data-action="click->myhello#log">put in the Log of javascript console</button>
</div>
```

E nello *stimulus controller*.


***codice 02 - .../app/javascript/controllers/myhello_controller.js - line:1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  initialize(){
    this.nameElement.value = this.name
  }

  log(){
    console.log(this.targets.find("first_name").value)
  }

  paste(event){
    event.preventDefault()
    console.log("paste are not allowed")
  }

  get(name){
    if (this.data.has("name")){
      return this.data.get.("name")
    } else {
      return "Default name"
    }
  }

  get nameElement(){
    return this.targets.find("first_name")
  }

}
```

> Che differenza c'è tra `data-myhello-name="Flavio"` e `data-myhello-target="first_name"`? <br/>
> nel caso di `data-...-target` la stringa dopo il segno di uguale `=` è il *nome della variabile*. <br/>
> nel caso di `data-...-name` il *nome della variabile* è `name` e la stringa dopo il segno di uguale `=` è il *valore della variabile*.



## Facciamolo su un form

prendiamo un form in html (più avanti useremo il form_with rails).

ed usiamo il `data-action="submit->myhello#log"`

<form data-controller="myhello">
  <label for="fname">First name:</label><br>
  <input type="text" id="fname" name="fname" value="John"><br>
  <label for="lname">Last name:</label><br>
  <input type="text" id="lname" name="lname" value="Doe"><br><br>
  <input type="submit" value="Submit">
</form>







***codice 01 - ...non rails html index-4.html - line:1***

```html+erb
<div data-controller="hello">
  <input data-hello-target="name" type="text">
  <button data-action="click->hello#greet">Greet</button>
  <span data-hello-target="output"></span>
</div>
```

Then write a compatible controller. Stimulus brings it to life automatically:


***codice 01 - ...non rails html index-4.html - line:1***

```javascript
// hello_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "name", "output" ]

  greet() {
    this.outputTarget.textContent =
      `Hello, ${this.nameTarget.value}!`
  }
}
```

> `import { Controller } from "@hotwired/stimulus"` <- questo importa la classe *Stimulus Controller*

> `default class extends Controller` <- questo definisce una *unnamed class* che estende da *Stimulus Controller*. 

> `export default class extends Controller` <- questo esporta la *unnamed class* in modo che, quando l'auto-load la carica, siamo in grado di prendere questa classe e renderla accessibile da altre parti. 

> `export default class extends Controller {` ... `}` <- tra le parentesi graffe inseriamo il nostro codice che vogliamo utilizzare.


Riassumendo:

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  //Qui inseriamo il nostro codice

}
```



## GoRails Example (stimulus 1.0 vs stimulus 2.0)

Lavoriamo sulla view.

***codice n/a Stimulus 1.0 - ...app/views/site/index.html - line:1***

```html+erb
<div data-controller="hello">
  <input data-target="hello.name" type="text">
  <button data-action="click->hello#log">Log</button>
</div>
```

In questo vecchio esempio il *namespaces* era sul nome della variabile `hello.name`.
Nella nuova versione è stato spostato nel *data-attribute*.

> `data-target` <- questo lo usa stimulus per definire la variabile.
>
> è importante il namespace `"hello.name"` per far capire che siamo sullo *stimulus controller*  `hello_controller.js`

> Nella nuova versione invece usiamo:
> `data-hello-target` per far capire che usiamo la variabile `target` dello *stimulus controller* `hello_controller.js`


Vediamo il `data-action`:
> `click->hello#log`
> `click` è il tipo di evento sul *button*
> `hello#log` interviene lo *stimulus controller*  `hello_controller.js` e chiama la funzione/metodo *log*.
> (la funzione/metodo su stimulus è chiamata: *action*)



***codice n/a - ...app/javascript/controllers/hello_controller.js - line:1***

```javascript
import { Controller } from "stimulus"

export default class extends Controller {
  log() {
    console.log(this.targets.find("name").value)
  }
}
```

> `this.targets.find("name")` -> prende `data-target="hello.name"`
> `this.targets.find("name").value` -> prende il valore del campo imput `data-target="hello.name"`



## Parte finale dell'esempio GoRails


***codice n/a - ...app/views/site/index.html - line:1***

```html+erb
<div data-controller="hello" data-hello-name="Chris">
  <input data-target="hello.name" type="text" data-action="paste->hello#paste">
  <button data-action="click->hello#log">Log</button>
</div>
```




***codice n/a - ...app/javascript/controllers/hello_controller.js - line:1***

```javascript
import { Controller } from "stimulus"

export default class extends Controller {
  initialize() {
    this.nameElement.value = this.name
  }

  log(event) {
    console.log(this.nameElement.value)
  }

  paste(event) {
    event.preventDefault()
    console.log("pastes are not allowed")
  }

  get name() {
    if (this.data.has("name")) {
      return this.data.get("name")
    } else {
      return "Default User"
    }
  }

  get nameElement() {
    return this.targets.find("name")
  }
}
```
