# <a name="top"></a> Cap 2.1 - Bootstrap Grid

Implementiamo la grid bootstrap nella nostra pagina `mockups/bs_grid`


## Risorse esterne

- esempi dal [sito ufficiale di BootStrap](https://getbootstrap.com/docs).
- [Bootstrap 5 tutorial - 20:01](https://www.youtube.com/watch?v=rQryOSyfXmI&list=PLl1gkwYU90QkvmT4uLM5jzLsotJZtLHgW)



## Apriamo il branch

continuiamo con il branch aperto nel capitolo precedente



## La Griglia

Il componente principale di bootstrap: la griglia *responsive*. Bootstrap include fra i suoi strumenti una griglia responsiva a 12 colonne talmente flessibile e potente che spesso viene utilizzata da sola.

La griglia è fatta di righe e colonne, le righe (`.row`) devono essere collocate all’interno di un contenitore che può essere a larghezza fissa (`.container`) o a larghezza fluida (`container-fluid`), questo garantisce il corretto allineamento e padding degli elementi interni.


La griglia ci permette di creare diversi scenari a seconda della dimensione degli apparati su cui sono visualizzati.
Ad esempio sul desktop ho due colonne ai lati (margin) Poi due colonne iniziali su una gallery e sull'altra due righe Title e Buy/box poi sotto description e Related.

Invece sul tablet non sono visualizzati i margini e tutti i blocchi sono uno sotto l'altro su una sola colonna.

Per creare un layout usiamo:

- Container (grigio)
- Row       (viola)
- Columns   (blu)

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_fig01-grid_overview.png)



## Grid: Breakpoints

I breakpoint sono le dimensioni, raggiunte le quali la griglia si modifica (responsive).

Breakpoint        | Class infix   | Dimensions
----------------- | ------------- | -----------
x-small           | none          | 0-576 px
small             | sm            | ≥ 576 px
medium            | md            | ≥ 768 px
large             | lg            | ≥ 992 px
extra large       | xl            | ≥ 1200 px
extra extra large | xxl           | ≥ 1400 px


> Affinché i Breakpoints funzionino è importante che sia presente il *viewport* `<meta name="viewport" content="width=device-width, initial-scale=1">` nella view.
> Per questo lo abbiamo inserito in *.../app/views/layouts/application.html.erb*.



## Esempio *raw*

Primo esempio della griglia di bootstrap con tutto il codice <html> da un esempio di uso di bootstrap senza Ruby on Rails.

***codice 01 - ...non rails html bs_grid_example.html - line:1***

```html+erb
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Bootstrap 5 Course</title>

    <style>
      [class*="container"] {
          background-color: #F433FF;
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_01-raw_html-bs_grid_example.html.erb)

Riadattiamo questo codice alla nostra applicazione su Ruby on Rails.



## Prepariamo un layout dedicato

Per gestire la parte `<style> [class*="container"] { ...` che è tra i tags `<head> ... </head>` creiamo un layout dedicato che chiamiamo *bs_demo*.

Duplichiamo il file `.../layouts/application.html.erb` e rinominiamo la copia `.../layouts/bs_demo.html.erb`. 

Inseriamo lo *style* nel view di *layout* personalizzato.

***codice 02 - .../app/views/layouts/bs_demo.html.erb - line:9***

```html+erb
    <style>
      [class*="container"] {
        background-color: #91A181;
        border: 1px solid #676E5F;
      }
      [class*="row"] {
        background-color: #E5E6D5;
        border: 1px solid #CCD5AB;
      }
      [class*="col"] {
        background-color: #FCDDFC;
        border: 1px solid #DA8D6E;
      }
    </style>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_02-views-layouts-bs_demo.html.erb)



## Creiamo la nuova view

Creiamo la nuova views `bs_grid` ed inseriamo una griglia minima; un container con due righe e due colonne.

***codice 03 - ...views/mockups/bs_grid.html.erb - line:1***

```html+erb
<div class="container p-3">
    <div class="row p-2">
        <div class="col-md-8">Main Content</div>
        <div class="col-md-4">Sidebar</div>
    </div>
    <div class="row p-2 text-center">
        <div class="col-md-8">Main Content Row2</div>
        <div class="col-md-4">Sidebar Row2</div>
    </div>
</div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_03-views-mockups-bs_grid.html.erb)



## Attiviamo instradamento

Facciamo in modo che la nuova view `bs_grid` utilizzi il controller layout 

***codice 04 - ...config/routes.rb - line:19***

```ruby
  get 'mockups/bs_grid'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_04-config-routes.rb)




## Attiviamo il nuovo layout sul controller

Facciamo in modo che la nuova view `bs_grid` utilizzi il layout `bs_demo`.

> Con il layout *application* in preview vedremmo le scritte ma non capiremmo la struttura della griglia.
> Per vederla assegnamo il nuovo layout *bs_demo*.

Aggiorniamo il conroller.

***codice 05 - ...controllers/mockups_controller.rb - line:8***

```ruby
  def bs_grid
    render layout: 'bs_demo'
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_05-controllers-mockups_controller.rb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

andiamo con il browser sull'URL:

- http://192.168.64.3:3000/mockups/bs_grid

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_fig02-bs_grid.png)



## Margine e Padding

Vediamo che il margine è spazio lasciato all'esterno dell'elemento a cui lo applichiamo.
il padding invece è spazio lasciato all'interno dell'elemento a cui lo applichiamo.

acronimo | descrizione
---------|-------------------------------------------------
ml-1     | margine left 1 unità
mt-1     | margine top 1 unità
mr-1     | margine right 1 unità
mb-1     | margine bottom 1 unità
my-1     | margine verticale (top+bottom) 1 unità
mx-1     | margine orizzontale (left+right) 1 unità
m-1      | margine globale (left+top+right+bottom) 1 unità
---      | ---  
pl-1     | padding left 1 unità
pt-1     | padding top 1 unità
pr-1     | padding right 1 unità
pb-1     | padding bottom 1 unità
py-1     | padding verticale (top+bottom) 1 unità
px-1     | padding orizzontale (left+right) 1 unità
p-1      | padding globale (left+top+right+bottom) 1 unità


> Se usiamo `my-2` su due righe adiacenti **non** si sommano i margini. Resta sempre di due unità.<br/>
> Lo stesso vale se diamo `mb-2` alla riga sopra e `mt-2` a quella sotto. Resta sempre di due unità.


Inseriamo margini e padding per rendere più evidente la griglia e per personalizzarci gli spazi tra le varie sezioni che creeremo di volta in volta ed in cui inseriamo vari esempi di griglia.

***codice 06 - ...views/mockups/bs_grid.html.erb - line:1***

```html+erb
<h1 class="my-3 text-center">Bootstrap Grid</h1>
<h2 class="my-3 text-center">Example 1</h2>
<hr class="my-2">
<div class="container p-3">
    <div class="row p-2">
        <div class="col">Prima colonna della riga uno</div>
        <div class="col">Seconda colonna della riga uno</div>
    </div>
    <div class="row p-5 text-center">
        <div class="col">Prima colonna della riga due</div>
        <div class="col">Seconda colonna della riga due</div>
        <div class="col">terza colonna della riga due</div>
    </div>
</div>
<hr class="my-2">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_06-views-mockups-bs_grid.html.erb)


![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_fig03-bs_grid.png)





## Il *gutter*

Il *gutter* è lo spazio delle ***sole*** colonne all'interno di una riga (row).

> Il *gutter* ***non*** ha effetto nella distanze in verticale tra le righe.

Il gutter verticale si ha solo quando le colonne di una stessa riga si mettono una sotto l'altra in risposta ad un comportamento *responsive*. (Ad esempio stringo il browser o visualizzo su uno smart-phone)

acronimo | descrizione
---------|-------------------------------------------------
gy-1     | spazio tra colonne in verticale (top+bottom) 1 unità
gx-1     | spazio tra colonne in orizzontale (left+right) 1 unità
g-1      | spazio tra colonne globale (left+top+right+bottom) 1 unità

> In bootstrap 4 si usava la classe *.gutter* invece su bootstrap 5 si usa "*.g\**".

Prestiamo attenzione quando usiamo il *gutter* perché l'area di influenza della colonna si estende anche al di fuori del container come vediamo nell'esempio in basso con `gy-4`.

Forziamo due colonne ad andare a capo sulla stessa riga impostando 24 unità invece delle 12 che sono previste sulla griglia da bootstrap.

***codice 06 - ...views/mockups/bs_grid.html.erb - line:1***

```html+erb
<h2 class="my-3 text-center">Gutter 1</h2>
<div class="container p-3">
  <div class="row gx-5 gy-4">
    <div class="col-6">
      Custom column padding
    </div>
    <div class="col-6">
      Custom column padding
    </div>
    <div class="col-6">
      Custom column padding
    </div>
    <div class="col-6">
      Custom column padding
    </div>
  </div>
</div>
<br/>
<div class="container p-3">
  <div class="row gx-5 gy-4">
    <div class="col-6">
      <div class="border bg-light">Custom column padding</div>
    </div>
    <div class="col-6">
      <div class="border bg-light">Custom column padding</div>
    </div>
    <div class="col-6">
      <div class="border bg-light">Custom column padding</div>
    </div>
    <div class="col-6">
      <div class="border bg-light">Custom column padding</div>
    </div>
  </div>
</div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_06-views-mockups-bs_grid.html.erb)


![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_fig04-bs_grid.png)



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
$ git push heroku bs:main
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout main
$ git merge bs
$ git branch -d bs
```




## Facciamo un backup su Github

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin main
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
