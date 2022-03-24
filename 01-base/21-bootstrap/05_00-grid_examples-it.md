{id: 01-base-21-bootstrap-01-bootstrap_story}
# Cap 21.4 -- Bootstrap Grid

Implementiamo la grid bootstrap nella nostra pagina mockups/page_a




## Apriamo il branch

continuiamo con il branch aperto nel capitolo precedente




## La Griglia

Il componente principale di bootstrap: la griglia 'responsive'. Bootstrap include fra i suoi strumenti una griglia responsiva a 12 colonne talmente flessibile e potente che spesso viene utilizzata da sola.

La griglia è fatta di righe e colonne, le righe (.row) devono essere collocate all’interno di un contenitore che può essere a larghezza fissa (.container)
o a larghezza fluida (container-fluid), questo garantisce il corretto allineamento e padding degli elementi interni.

Proviamo gli esempi scaricati direttamente dal [sito ufficiale di BootStrap](https://getbootstrap.com/docs).

Andiamo su Layout -> Grid.




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
