# <a name="top"></a> Cap 5.2 - Convertiamo lo snipet javascript to stimulus controller


## Risorse esterne

- [Refactoring Javascript with Stimulus Values API & Defaults](https://gorails.com/episodes/refactoring-javascript-with-stimulus-values-api-defaults)




***code 01 - .../app/views/main/index.html.erb - line:1***

```html+erb
<h4><span id="countdown">...</span></h4>

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



## Creiamo lo Stimulus Controller

Iniziamo ad andare verso STIMULUS aggiungiamo

`<h1><span data-controller="countdown">...</span></h1>`

Questo richiama `.../app/javascript/controllers/countdown_controller`.
Creiamo questo file.

***code 02 - .../app/javascript/controllers/countdown_controller.js - line:1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

}
```


## Spostiamo valore *hard coded* da javascript ad html

Spostiamo il valore fisso della data dal codice javascript al tag html.

 ` var countDownDate = new Date("Nov 30, 2021 23:59:59").getTime();`

Per farlo lo aggiungiamo come attributo al nostro html:

`<h1><span data-controller="countdown" data-countdown-date-value="Nov 30, 2021 23:59:59">...</span></h1>`

Quindi aggiungiamo nel nostro controller stimulus la seguente voce 


***code n/a - .../app/javascript/controllers/countdown_controller.js - line:1***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    date: String,
  }

  connect() {
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