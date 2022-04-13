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


![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_fig03-bs_grid.png)





## Il *container*

Se non vogliamo lo spazio a destra e sinistra usiamo l'opzione `-fluid`.

***codice n/a - ...views/mockups/bs_grid.html.erb - line:20***

```html+erb
    <div class="container-fluid">
```

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_fig04-bs_grid-fluid.png)


Oppure possiamo usare l'opzione `-md`.
In questo caso fino al breakpoint *medium* il container si comporta come *-fluid* su dimensioni inferiori e torna ad applicare lo spazio a destra e a sinistra quando si raggiunge la dimensione medium o maggiore.

***codice n/a - ...views/mockups/bs_grid.html.erb - line:20***

```html+erb
    <div class="container-md">
```

> Chiaramente si possono usare tutti i breakpoints: `-sm`, `-md`, `-lg`, `-xl`, `-xxl`



## le colonne *columns*

Se lasci solo *col* quando stringi le colonne non si riordinano in basso per rispondere al responsive, ma restano tutte sulla stessa riga diventando sempre più piccole.

***codice n/a - ...views/mockups/bs_grid.html.erb - line:4***

```html+erb
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
```


Invece le colonne che hanno *col-sm* raggiunto il *breakpoint small* si mettono una sotto l'altra.

***codice n/a - ...views/mockups/bs_grid.html.erb - line:4***

```html+erb
<div class="container p-3">
    <div class="row p-2">
        <div class="col">Prima colonna della riga uno</div>
        <div class="col">Seconda colonna della riga uno</div>
    </div>
    <div class="row p-5 text-center">
        <div class="col-sm">Prima colonna della riga due</div>
        <div class="col-sm">Seconda colonna della riga due</div>
        <div class="col-sm">terza colonna della riga due</div>
    </div>
</div>
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

andiamo con il browser sull'URL:

- http://192.168.64.3:3000/mockups/bs_grid



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement bootstrap grid on mockups"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku bs:main
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge bs
$ git branch -d bs
```



## Facciamo un backup su Github

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
