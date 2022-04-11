# <a name="top"></a> Cap 2.1 - Tooltips



## Risorse esterne

- [Bootstrap 5 tutorial - crash course for beginners in 1.5H (stable release May 2021)](https://www.youtube.com/watch?v=rQryOSyfXmI&list=PLl1gkwYU90QkvmT4uLM5jzLsotJZtLHgW)
- https://github.com/mdbootstrap/mdb-ui-kit



## Attiviamo i *tooltips*

Di default non è attivo il codice javascript perché crea una piccola caduta di prestazioni.
Seguiamo le indicazioni per attivarlo. Prendiamo il codice da [Sito bootstrap: components - tooltips](https://getbootstrap.com/docs/5.1/components/tooltips/#example-enable-tooltips-everywhere) e lo inseriamo nella parte javascript della nostra applicazione.

***codice 02 - .../app/javasctipt/application.js - line:5***

```javascript
document.addEventListener("turbo:load", () => {
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })
})
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/03_01-views-layouts-application.html.erb)

> Il codice lo abbiamo dovuto copiare dentro l'evento *listener* di *turbo*: `document.addEventListener("turbo:load", () => { ... })`.


Per far funzionare javascript in locale dobbiamo fare il precompile.

```bash
$ rails assets:precompile
```

Copiamo poi sulla nostra view *page_a* il codice dei quattro pulsanti con *tooltip* in alto, a destra, in basso e a sinistra.

***codice 03 - .../app/views/mockups/page_a.html.erb - line:55***

```html
<button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="top" title="Tooltip on top">
  Tooltip on top
</button>
<button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="right" title="Tooltip on right">
  Tooltip on right
</button>
<button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Tooltip on bottom">
  Tooltip on bottom
</button>
<button type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="left" title="Tooltip on left">
  Tooltip on left
</button>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/03_01-views-layouts-application.html.erb)



<h1>Hello World</h1>
<button type="button" class="btn btn-secondary" data-toggle="tooltip" data-placement="top" title="Tooltip on top">
  Tooltip on top
</button>