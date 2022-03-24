# <a name="top"></a> Cap 21.3 - Tests di funzionamento di Bootstrap

Completiamo la parte di installazione di boostrap aggiungendo la funzionalità "inline" per il css solo lato development perché ci aiuta in fase di debug. Inoltre aggiungiamo le icone.



## Apriamo il branch



## TURN ON INLINE SOURCE MAPS (SO WE CAN DEBUG RAILS 7 BOOTSTRAP)

Inline Source Maps
With SassC-Rails, it's also extremely easy to turn on inline source maps. Simply add the following configuration to your development.rb file:

in config/environments/development.rb add this line:

 config.sass.inline_source_maps = true

Also, the sassc-rails gem README advises this note as well:

After adding this config line, you may need to clear your assets cache (rm -r tmp/cache/assets), stop spring, and restart your rails server. You may also wish to disable line comments (config.sass.line_comments = false).

Note, as indicated, these source maps are inline. They will not generate additional files or anything like that. Instead, they will be appended to the compiled application.css file.



## Verifichiamo il tooltip
questo ha bisogno anche di javascript per il mouse-hover



## Verifichiamo il toast
questo ha bisogno anche di javascritp



## Verifichiamo il menu (nav_bar)
questo ha bisogno anche di javascript




##



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






## Vediamo le icone di bootstrap

Vediamo che sulla cartella *app/assets/stylesheets* abbiamo il file *application.bootstrap.scss*.

***codice 05 - .../app/assets/stylesheets/application.bootstrap.scss - line:01***

```scss
@import 'bootstrap/scss/bootstrap';
@import 'bootstrap-icons/font/bootstrap-icons';
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/02_05-assets-stylesheets-application_bootrap.scss)


