# <a name="top"></a> Cap 2.1 - Bootstrap Grid

Implementiamo la grid bootstrap nella nostra pagina `mockups/bs_grid`


## Risorse esterne

- esempi dal [sito ufficiale di BootStrap](https://getbootstrap.com/docs).



## Apriamo il branch

continuiamo con il branch aperto nel capitolo precedente



## La Griglia

Il componente principale di bootstrap: la griglia *responsive*. Bootstrap include fra i suoi strumenti una griglia responsiva a 12 colonne talmente flessibile e potente che spesso viene utilizzata da sola.

La griglia è fatta di righe e colonne, le righe (`.row`) devono essere collocate all’interno di un contenitore che può essere a larghezza fissa (`.container`)
o a larghezza fluida (`container-fluid`), questo garantisce il corretto allineamento e padding degli elementi interni.


La griglia ci permette di creare diversi scenari a seconda della dimensione degli apparati su cui sono visualizzati.
Ad esempio sul desktop ho due colonne ai lati (margin) Poi due colonne iniziali su una gallery e sull'altra due righe Title e Buy/box poi sotto description e Related.

Invece sul tablet non sono visualizzati i margini e tutti i blocchi sono uno sotto l'altro su una sola colonna.

Per creare un layout usiamo:

- Container (grigio)
- Row       (viola)
- Columns   (blu)

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_fig01-grid_overview.png)


> Affinché i Breakpoints funzionino è importante che sia presente il *viewport* `<meta name="viewport" content="width=device-width, initial-scale=1">` nella view. (`.../app/views/layouts/application.html.erb`)



## Grid: Breakpoints

I breakpoint sono le dimensioni raggiunte le quali la griglia si modifica (responsive).

Breakpoint        | Class infix   | Dimensions
----------------- | ------------- | -----------
x-small           | none          | 0-576 px
small             | sm            | ≥ 576 px
medium            | md            | ≥ 768 px
large             | lg            | ≥ 992 px
extra large       | xl            | ≥ 1200 px
extra extra large | xxl           | ≥ 1400 px


## Layouts *empty* e *mockups*

Creiamo un layout completamente vuoto in modo che non aggiunge nulla al codice che inseriamo nella view.
Questo layout ci è utile nel caso in cui copiamo tutto il codice di una pagina web compresi i tag <html>, <header>, <body>, eccetera.

***codice 01 - .../app/views/layouts/empty.html.erb - line:1***

```html+erb
<%= yield %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/05_01-views-layouts-empty.html.erb)

> Il codice `<%= yield %>` passa tutto il codice presente nel *view*. Se non lo mettiamo nel browser si presente una pagina vuota perché tutto il codice che è nel *view* non viene passato.

> questo file è identico a "mailer.text.erb"

Nel layout *empty* non è attiva tutta la parte *bootstrap*. è solo un layout di "passaggio". Quello che invece usiamo nei nostri *mockups* è una struttura minima di layout che comprenda tutta la parte di *bootstrap*. Chiamiamo questo layout "*mockup*".

***codice 02 - .../app/views/layouts/mockup.html.erb - line:1***

```html+erb
<!DOCTYPE html>
<html>
  <head>
    <title>Mockups</title>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/05_02-views-layouts-mockup.html.erb)







## Esempio 1

- [Bootstrap 5 tutorial - 20:01](https://www.youtube.com/watch?v=rQryOSyfXmI&list=PLl1gkwYU90QkvmT4uLM5jzLsotJZtLHgW)

Creiamo una nuova views in *mockups*, la inseriamo nel *mockups_controller.rb* e nel *routes.rb*.

***codice 01 - .../app/views/mockups/bs_grid_a.html.erb - line:1***

```html+erb

```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/05_01-views-mockups-bs_grid_a.html.erb)



***codice 02 - .../app/controllers/mockups_controller.rb - line:1***

```ruby

```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/21-bootstrap/05_01-views-mockups-bs_grid_a.html.erb)






## Il *gutter*

Il *gutter* è lo spazio tra le righe (rows) e le colonne (columns) della griglia (grid).
In bootstrap 4 si usava la classe *.gutter* invece su bootstrap 5 si usa "*.g\**".

Esempio:

```html+erb
<div class="row g-5">
  <div class="col">...</div>
  <div class="col">...</div>
  <div class="col">...</div>
</div>
```

> se esprimo solo il valore `g-5` è applicato sia in orizzontale che in verticale
> altrimenti posso usare `gx-0` o `gy-0`

Esempio:
In questo esempio quando stringo il browser e le colonne vanno a capo, lo spazio tra le due righe di colonne è con un *gutter di 5*. 

```html+erb
<div class="container">
  <div class="row g-5">
    <div class="col-6">1</div>
    <div class="col-6">2</div>
    <div class="col-6">3</div>
    <div class="col-6">4</div>
  </div>
</div>
```

> Abbiamo forzato il rimando a capo assegnando un totale di "24" e non di "12" nella riga. <br/>
> Questo **non** è il modo corretto di usare la griglia ed è stato messo solo a scopo didattico.

Il seguente esempio è più corretto:

<div class="container">
  <div class="row g-5">
    <div class="col-lg-3 col-md-6">1</div>
    <div class="col-lg-3 col-md-6">2</div>
    <div class="col-lg-3 col-md-6">3</div>
    <div class="col-lg-3 col-md-6">4</div>
  </div>
</div>

> In questo caso su schermo largo le ho tutte e 4 allineate su schermo medio due sopra e due sotto e su schermo piccolo tutte una sotto l'altra.



## Il *container*

Se non vogliamo lo spazio a destra e sinistra usiamo l'opzione `-fluid`.

Esempio:

```html+erb
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-8">Main Content</div>
        <div class="col-md-4">Sidebar</div>
      </div>
    </div>
```


Oppure possiamo usare l'opzione `-md`.
In questo caso fino al brackpoint *medium* il container si comporta come *-fluid* su dimensioni inferiori e torna ad applicare lo spazio a destra e a sinistra quando si raggiunge la dime.

Esempio:

```html+erb
    <div class="container-md">
      <div class="row">
        <div class="col-md-8">Main Content</div>
        <div class="col-md-4">Sidebar</div>
      </div>
    </div>
```

> Chiaramente si possono usare tutti i breakpoints: `-sm`, `-md`, `-lg`, `-xl`, `-xxl`



## le colonne *columns*

Se lasci solo *col* quando stringi le colonne non si riordinano in basso per rispondere al responsive, ma restano tutte sulla stessa riga diventando sempre più piccole.

```html+erb
    <div class="container-md">
      <div class="row">
        <div class="col">1</div>
        <div class="col">2</div>
        <div class="col">3</div>
      </div>
      <div class="row">
        <div class="col-sm">1</div>
        <div class="col-sm">2</div>
      </div>
    </div>
```

> Invece le colonne che hanno *col-sm* raggiunto il *breakpoint small* si mettono una sotto l'altra.





## Usiamo uno stile per visualizzare la griglia di bootstrap

Al fine di comprendere meglio come funzionano le griglie aggiungiamo uno stile di debug che ne evidenzi la struttura.

Potremmo creare un file "".../app/javascript/stylesheets/debug_bootstrap_grid.scss" ed aggiungerlo a ".../app/javascript/stylesheets/application.scss" con il comando "@import "./debug_bootstrap_grid";" ma essendo il codice di stile una sola semplice riga è più semplice inserirla direttamente in "application.scss".

{id: "01-21-03_01", caption: ".../app/javascript/stylesheets/application.scss -- codice 07", format: JavaScript, line-numbers: true, number-from: 1}
```
// highlight bootstrap grid for Debug
.row > div { min-height:100px; border:1px solid red;}
```

[tutto il codice](#01-21-03_01all)




## Vediamo tre esempi di griglia con contenitore normale

Adesso che abbiamo reso la griglia visibile possiamo implementiamo tre esempi di griglia con il contenitore standard.

{id: "01-21-03_02", caption: ".../app/views/mockups/page_a.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 2}
```
<p>-Esempio-1-</p>

<!-- contenitore responsivo a larghezze fisse -->
<div class="container">
  <div class="row">
    <div class="col-lg-12">
    </div>
  </div>
</div>

<p>-Esempio-2-</p>

<div class="container">
  <div class="row">
    <div class="col-lg-6">
    </div>
    <div class="col-lg-6">
    </div>
  </div>
  <div class="row">
    <div class="col-lg-4">
    </div>
    <div class="col-lg-4">
    </div>
    <div class="col-lg-4">
    </div>
  </div>
</div>


<p>-Esempio-3-</p>

<div class="container">
  <div class="row">
    <div class="col">
      1 of 2
    </div>
    <div class="col">
      2 of 2
    </div>
  </div>
  <div class="row">
    <div class="col">
      1 of 3
    </div>
    <div class="col">
      2 of 3
    </div>
    <div class="col">
      3 of 3
    </div>
  </div>
</div>
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

andiamo con il browser sull'URL:

* https://mycloud9path.amazonaws.com/mockups/page_a




## Vediamo i tre esempi di griglia con contenitore fluido

Adesso rendiamo fluido il container

{id: "01-21-03_03", caption: ".../app/views/mockups/page_a.html.erb -- codice 03", format: HTML+Mako, line-numbers: true, number-from: 2}
```
<p>-Esempio-1-</p>

<!-- contenitore responsivo fluido -->
<div class="container-fluid">
  <div class="row">
    <div class="col-lg-12">
    </div>
  </div>
</div>

<p>-Esempio-2-</p>

<div class="container-fluid">
  <div class="row">
    <div class="col-lg-6">
    </div>
    <div class="col-lg-6">
    </div>
  </div>
  <div class="row">
    <div class="col-lg-4">
    </div>
    <div class="col-lg-4">
    </div>
    <div class="col-lg-4">
    </div>
  </div>
</div>


<p>-Esempio-3-</p>

<div class="container-fluid">
  <div class="row">
    <div class="col">
      1 of 2
    </div>
    <div class="col">
      2 of 2
    </div>
  </div>
  <div class="row">
    <div class="col">
      1 of 3
    </div>
    <div class="col">
      2 of 3
    </div>
    <div class="col">
      3 of 3
    </div>
  </div>
</div>
```




## Usiamo la griglia per formattare la nostra pagina 

Adesso usiamo la griglia per formattare la nostra pagina_a 

{id: "01-21-03_04", caption: ".../app/views/mockups/page_a.html.erb -- codice 04", format: HTML+Mako, line-numbers: true, number-from: 2}
```
<div class="container-fluid">
  <div class="row">
    <div class="col-lg-12">
      <h1> <%= t ".headline" %> </h1>
      <p> <%= t ".first_paragraph" %> </p>
      <br>
```

Ci siamo divertiti a distribuire i contenuti all'interno di una griglia con quattro righe e varie colonne




## Togliamo evidenziazione della griglia

Adesso che al nostra pagina funziona possiamo rimuovere la colorazione della griglia commentanto la linea di stile.


{id: "01-21-03_01", caption: ".../app/javascript/stylesheets/application.scss -- codice 07", format: JavaScript, line-numbers: true, number-from: 1}
```
// highlight bootstrap grid for Debug
//.row > div { min-height:100px; border:1px solid red;}
```




## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Implement bootstrap grid on mockups page_a"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku bs:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge bs
$ git branch -d bs
```




## Facciamo un backup su Github

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#02-01-03_01)

{id="02-01-03_01all", title=".../app/assets/stylesheets/debug_bootstrap_grid.css", lang=ruby, line-numbers=on, starting-line-number=1}
```
.row > div { min-height:100px; border:1px solid red;}
```




[Codice 02](#02-01-03_02all)

{id="02-01-03_02", title=".../app/assets/stylesheets/application.scss", lang=ruby, line-numbers=on, starting-line-number=17}
```
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, or any plugin's
 * vendor/assets/stylesheets directory can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any other CSS/SCSS
 * files in this directory. Styles in this file should be added after the last require_* statement.
 * It is generally better to create a new file per style scope.
 *
 */

// Custom bootstrap variables must be set or imported *before* bootstrap.
@import "bootstrap";
@import "debug_bootstrap_grid";
```




---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
