# <a name="top"></a> Cap 21.3 - Completiamo l'installazione di Bootstrap

Completiamo la parte di installazione di boostrap aggiungendo la funzionalità "inline" per il css solo lato development perché ci aiuta in fase di debug. Inoltre aggiungiamo le icone.


## Risorse esterne

- [Bootstrap sito ufficiale: Starter template](https://getbootstrap.com/docs/5.1/getting-started/introduction/#starter-template)




## Apriamo il branch

Lo abbiamo lasciato aperto nei capitoli precedenti.


## Verifichiamo il *viewpoint*

Così come consigliato nel [Bootstrap sito ufficiale: Starter template](https://getbootstrap.com/docs/5.1/getting-started/introduction/#starter-template) è importante assegnare il ***viewport*** perché è questo che gestisce la parte **responsive** di bootstrap.
Se non c'è quando stringo la finestra del browser invece di avere l'*hamburger menu* il *nav_bar* resta uguale e si attiva le barra di scorrimento laterale sotto alla finestra del browser.

Verifichiamo che sia presente nel layout.

***codice 01 - .../app/views/layouts/application.html.erb - line:5***

```html+erb
    <meta name="viewport" content="width=device-width, initial-scale=1">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/03_01-views-layouts-application.html.erb)



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




## TURN ON INLINE SOURCE MAPS (SO WE CAN DEBUG RAILS 7 BOOTSTRAP)

- [TURN ON INLINE SOURCE MAPS](https://jasonfleetwoodboldt.com/courses/stepping-up-rails/rails-7-bootstrap/)
- [sassc-rails gem README](https://github.com/sass/sassc-rails)

Inline Source Maps
With SassC-Rails, it's also extremely easy to turn on inline source maps. Simply add the following configuration to your development.rb file.

***codice 03 - .../config/environments/development.rb - line:55***

```ruby
 config.sass.inline_source_maps = true
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/03_01-views-layouts-application.html.erb)


After adding this config line, you may need to clear your assets cache.

```bash
$ rm -r tmp/cache/assets
 ```

Stop spring, and restart your rails server. 

You may also wish to disable line comments (config.sass.line_comments = false).

***codice n/a - .../config/environments/development.rb - line:55***

```ruby
 config.sass.line_comments = false
```

Note, as indicated, these source maps are inline. They will not generate additional files or anything like that. Instead, they will be appended to the compiled application.css file.


What is a source map?
A source map is a file that maps from the transformed source to the original source, enabling the browser to reconstruct the original source and present the reconstructed original in the debugger.

Why an *inline* source map?
Today I learned that it is possible to include source maps directly into your minified JavaScript file instead of having them in a separate example.min.map file. I wonder: why would anybody want to do something like that?

- The benefit of having source maps is clear to me: one can for example debug errors with the original, non-compressed source files while running the minified files. 
- The benefit of minimization is also clear: the size of source files is greatly reduced, making it quicker for browsers to download.

So why on Earth I would want to include the source maps into the minified file, given that the maps have size even greater than the minified code itself?

I searched around and the only reason I could see that people inline source maps is for use in development. Inlined source maps should not be used in production.

The rational for inlining the source maps with your minified files is that the browser is parsing the exact same JavaScript in development and production. Some minifiers like Closure Compiler do more than 'just' minify the code. Using the advanced options it can also do things like: dead code removal, function inlining, or aggressive variable renaming. This makes the minified code (potentially) functionally different than the source file.



## Verifichiamo il toast
questo ha bisogno anche di javascritp







## Vediamo le icone di bootstrap

Vediamo che sulla cartella *app/assets/stylesheets* abbiamo il file *application.bootstrap.scss*.

***codice 05 - .../app/assets/stylesheets/application.bootstrap.scss - line:01***

```scss
@import 'bootstrap/scss/bootstrap';
@import 'bootstrap-icons/font/bootstrap-icons';
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_05-assets-stylesheets-application_bootrap.scss)


