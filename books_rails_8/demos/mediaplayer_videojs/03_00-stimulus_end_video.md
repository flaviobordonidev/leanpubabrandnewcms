# <a name="top"></a> Implementiamo stimulus controller

[25/05/10]
Utiliziamo un controller stimulus per gestire gli eventi di `videojs` ad iniziare dall'intercettare la fine del video.



## Crea un controller Stimulus

```shell
❯ bin/rails generate stimulus video
```

Questo genera `app/javascript/controllers/video_controller.js`
Inseriamoci il seguente codice per intercettare la fine del video.

***Codice 01 - .../app/javascript/controllers/video_controller.js - linea:14***

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("ended", this.onEnded)
  }

  disconnect() {
    this.element.removeEventListener("ended", this.onEnded)
  }

  onEnded = () => {
    console.log("🎬 Il video è finito!")
    // qui puoi fare altro: ad es. inviare un evento, mostrare un messaggio, ecc.
  }
}
```



## Collega il controller alla view

Nel tag <video> mettiamo i parametri richiesti da `video.js`.

***Codice 02 - .../app/views/articles/show.html.erb - linea:24***

```html
<video
  id="my-video"
  class="video-js vjs-theme-forest"
  data-controller="video"
  controls
  preload="auto"
  width="640"
  height="264"
  data-setup="{}">
  <source src="<%= video_path('demo.mp4') %>" type="video/mp4" />
</video>
```

Appena il video finisce, nel console log vedrai: 🎬 Il video è finito!



## Facciamo partire il server

```shell
❯ bin/dev
```

Vediamo il risultato nel browser all'url: `http://127.0.0.1:3000/`

Funziona!


## Risorse esterne

-[]()

---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)

