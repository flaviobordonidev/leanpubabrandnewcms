# <a name="top"></a> Cap 2.1 - Bootstrap Gutter

Per completare la gestione della griglia in ambito *responsive* è importante vedere l'uso del parametro *gutter*.



## Risorse esterne

- [sito ufficiale di BootStrap: Gutters](https://getbootstrap.com/docs/5.1/layout/gutters/).



## Apriamo il branch

continuiamo con il branch aperto nel capitolo precedente



## Il *gutter*

Il *gutter* è lo spazio delle ***sole*** colonne all'interno di una riga (row).

> Il *gutter* ***non*** ha effetto nella distanze in verticale tra le righe.

Il gutter verticale si ha solo quando le colonne di una stessa riga si mettono una sotto l'altra in risposta ad un comportamento *responsive*. (Ad esempio stringo il browser o visualizzo su uno smart-phone.)

acronimo | descrizione
---------|-------------------------------------------------
gy-1     | spazio tra colonne in verticale (top+bottom) 1 unità
gx-1     | spazio tra colonne in orizzontale (left+right) 1 unità
g-1      | spazio tra colonne globale (left+top+right+bottom) 1 unità

> In bootstrap 4 si usava la classe *.gutter* invece su bootstrap 5 si usa la classe *.g*.

Prestiamo attenzione quando usiamo il *gutter* perché l'area di influenza della colonna si estende anche al di fuori del container come vediamo nell'esempio in basso con `gy-4`.

Forziamo due colonne ad andare a capo sulla stessa riga impostando 24 unità invece delle 12 che sono previste sulla griglia da bootstrap.



## Creiamo la nuova view

Creiamo la nuova views `bs_gutter` con degli esempi di *gutter*.

***codice 01 - ...views/mockups/bs_gutter.html.erb - line:1***

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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_03-views-mockups-bs_grid.html.erb)




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




## Attiviamo instradamento

Facciamo in modo che la nuova view `bs_grid` utilizzi il controller layout 

***codice 04 - ...config/routes.rb - line:19***

```ruby
  get 'mockups/bs_gutter'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/02-bootstrap/02-components/01_04-config-routes.rb)




## Attiviamo il nuovo layout sul controller

Facciamo in modo che la nuova view `bs_grid` utilizzi il layout `bs_demo`.

> Con il layout *application* in preview vedremmo le scritte ma non capiremmo la struttura della griglia.
> Per vederla assegnamo il nuovo layout *bs_demo*.

Aggiorniamo il conroller.

***codice 05 - ...controllers/mockups_controller.rb - line:8***

```ruby
  def bs_gutter
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

