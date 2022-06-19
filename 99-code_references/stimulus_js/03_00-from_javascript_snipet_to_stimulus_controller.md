# <a name="top"></a> Cap 5.2 - Convertiamo lo snipet javascript to stimulus controller

In questa applicazione abbiamo un timer che fa un countdown da una data futura preimpostata.
Lo snippet è scritto in javascript e noi facciamo un refactory per portarlo in stimulus.



## Risorse esterne

- [GoRails: Refactoring Javascript with Stimulus Values API & Defaults](https://gorails.com/episodes/refactoring-javascript-with-stimulus-values-api-defaults)



## Lo snippet iniziale

Di seguito il codice che funziona. La data preimpostata è "Nov 30, 2022 23:59:59".

***code 01 - .../app/views/main/index.html.erb - line:1***

```html+erb
<h4><span id="countdown">...</span></h4>

<script>
  // Set the date we're counting down to
  var countDownDate = new Date("Nov 30, 2022 23:59:59").getTime();
  // Update the count down every 1 second
  var x = setInterval(function() {
    // Get todays date and time
    var now = new Date().getTime();
    // Find the distance between now and the count down date
    var distance = countDownDate - now;
    // Time calculations for days, hours, minutes and seconds
    var days = Math.floor(distance / (1000 * 60 * 60 * 24));
    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((distance % (1000 * 60)) / 1000);
    // Display the result in the element with id="demo"
    document.getElementById("countdown").innerHTML = "Deal ends in " + days + "d " + hours + "h "
      + minutes + "m " + seconds + "s";
    // If the count down is finished, write some text
    if (distance < 0) {
      clearInterval(x);
      document.getElementById("countdown").innerHTML = "EXPIRED";
    }
  }, 1000);
</script>
```



## Creiamo lo Stimulus Controller

Iniziamo ad andare verso STIMULUS aggiungiamo alla view una riga che richiama uno stimulus controller.

***code n/a - .../app/views/main/index.html.erb - line:2***

```html+erb
<h1><span data-controller="countdown">...</span></h1>
```

L'attributo `data-controller="countdown"` richiama `.../app/javascript/controllers/countdown_controller`.

> Senza lo *stimulus controller* in preview visualizziamo i tre puntini `...`.
> Volendo possiamo anche togliere i tre puntini e non vediamo nulla visualizzato.

Creiamo il file `countdown_controller.js` e ci copiamo il codice di `hello_controller.js`.

***code 02 - .../app/javascript/controllers/countdown_controller.js - line:1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }
}
```

> adesso nel preview al posto dei tre puntini `...` visualizziamo la scritta `Hello World!`



## Spostiamo il valore *hard coded* da stimulus ad html

Spostiamo il valore fisso `"Hello World!"` dal codice stimulus al tag html.

***code n/a - .../app/views/main/index.html.erb - line:2***

```html+erb
<h1><span data-controller="countdown" data-countdown-message-value="Hello World!">...</span></h1>
```

> Secondo la convenzione stimulus abbiamo: <br/>
> - `data-countdown` per trovare lo *stimulus controller* da usare: `countdown_controller.js` <br/>
> - `-message-value` per definire la variabile `this.messageValue`

Quindi nel nostro *stimulus controller* abbiamo:

***code n/a - .../app/javascript/controllers/countdown_controller.js - line:1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    message: String
  }

  connect() {
    this.element.textContent = this.messageValue
  }
}
```

> Per far funzionare la variabile `this.messageValue` dobbiamo definire la tipologia di valore negli `static values`. <br/>
> Da notare che negli `static values` usiamo solo `message` e non `messageValue`

> Riassumendo quando per stimulus definiamo in html `data-countdown-message-value` stiamo riferendoci a `data-<nome_stimulus_controller>-<nome_variabile_static>-value`.



## Spostiamo il valore *hard coded* della data finale per il countdown

Facciamo lo stesso fatto per la stringa `"Hello World!"` ma questa volta lavorando sullo snippet javascript. Spostiamo il valore fisso della data dal codice javascript al tag html (passando per stimulus).

***code n/a - .../app/views/main/index.html.erb - line:7***

```html+erb
  var countDownDate = new Date("Nov 30, 2022 23:59:59").getTime();
```

Per farlo lo aggiungiamo come attributo al nostro html:


***code n/a - .../app/views/main/index.html.erb - line:2***

```html+erb
<h1><span data-controller="countdown" data-countdown-message-value="Hello World!" data-countdown-date-value="Nov 30, 2022 23:59:59">...</span></h1>
```

Quindi lo passiamo al controller stimulus.

***code n/a - .../app/javascript/controllers/countdown_controller.js - line:1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    message: String,
    date: String
  }

  connect() {
    this.element.textContent = this.messageValue
    this.endTime = new Date(this.dateValue).getTime()
    console.log(this.endTime)
  }
}
```

> la riga `this.endTime = new Date(this.dateValue).getTime()` riprende quello che nello snipbet javascript (<script>...</script>) è: <br/>
>   `var countDownDate = new Date("Nov 30, 2021 23:59:59").getTime();`


Aggiungiamo anche la riga `console.log(countDownDate);` nel view main/index

***code 03 - .../app/views/main/index.html.erb - line:1***

```html+erb

    console.log(countDownDate);
```

Andiamo nel preview del browser e vediamo che nell javascript console abbiamo la log









***code 02 - .../app/views/main/index.html.erb - line:1***

```html+erb
<h4><span id="countdown">...</span></h4>

<h1><span data-controller="countdown" data-countdown-message-value="HELLO WORLD ${minutes} minutes ${seconds} seconds" data-countdown-date-value="Nov 30, 2021 23:59:59">...</span></h1>

<script>
  // Set the date we're counting down to
  var countDownDate = new Date("Nov 30, 2021 23:59:59").getTime();
  // Update the count down every 1 second
  var x = setInterval(function() {
    // Get todays date and time
    var now = new Date().getTime();
    // Find the distance between now and the count down date
    var distance = countDownDate - now;
    // Time calculations for days, hours, minutes and seconds
    var days = Math.floor(distance / (1000 * 60 * 60 * 24));
    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((distance % (1000 * 60)) / 1000);
    // Display the result in the element with id="demo"
    document.getElementById("countdown").innerHTML = "Deal ends in " + days + "d " + hours + "h "
      + minutes + "m " + seconds + "s";
    // If the count down is finished, write some text
    if (distance < 0) {
      clearInterval(x);
      document.getElementById("countdown").innerHTML = "EXPIRED";
    }
  }, 1000);
</script>
```