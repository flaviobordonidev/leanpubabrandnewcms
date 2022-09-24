# <a name="top"></a> Cap 2.2 - Attiviamo stile del tema

Attiviamo lo stylesheets.

Possiamo avere due approcci:

- aggiungere piano piano -> copiare un po' di codice alla volta.
- togliere piano piano -> mettere tutto il codice e togliere quello che non usiamo.

Il primo approccio ci fa capire meglio come è strutturato il codice dello stylesheets ma è più complesso da implementare.
Il secondo è più semplice sia come implementazione iniziale che dei successivi upgrade del tema.
Noi scegliamo il secondo approccio.


## Vediamo la cartella *assets* del tema Eduport

Nella documentazione vediamo questa struttura di cartelle/directories dentro il tema Eduport.
Vediamo la struttura dentro la cartella "assets/", che contiene tutti i files degli "assets" (stylesheets e javascripts) che usa il tema.

- `assets/`<br/>
  Includes all assets files, like CSS, Images, JS, SCSS and plugins used in theme
  - `css/`<br/>
    Includes .css file, used in theme
  - `images/`<br/>
    Includes all images, used in .html files.
  - `js/`<br/>
    Includes plugin's initialization file
  - `scss/`<br/>
    Includes all of raw source files that are used to create the final CSS that is included in theme
  - `vendor/`<br/>
    Includes all plugins files.



## Copiamo le sottocartelle di *assets* che ci interessano

Copiamo i files dell'asset_pipeline (stylesheets e javascripts) dal tema Eduport alla nostra applicazione Rails.

copia da                          | incolla in
| :---                            | :---
.../theme_eduport/assets/css/     | *questa cartella **non** la copiamo perché ha i sorgenti già compilati*
.../theme_eduport/assets/images/  | .../app/assets/images/edu/
.../theme_eduport/assets/js/      | *questa carrella la copiamo più avanti*
.../theme_eduport/assets/scss/    | .../app/assets/stylesheets/edu/scss/
.../theme_eduport/assets/vendor/  | .../app/assets/stylesheets/edu/vendor/

> Le varie sottocartelle ***edu/*** le creiamo noi.

Vediamo il risultato finale.

Cartella copiata            | sottocartelle
| :---                      | :---
.../app/assets/images/edu/  | - about <br/> - avatar <br/> - bg <br/> - ... <br/> - logo.svg
.../app/assets/stylesheets/edu/scss/    | - components <br/> - custom <br/> - dark <br/> - ... <br/> - style.scss
.../app/assets/stylesheets/edu/vendor/  | - animate <br/> - aos <br/> - ... <br/> - tiny-slider



## Attiviamo i files stylesheet da usare

Nella parte "header" del file abbiamo Le chiamate ai files stylesheets. La principale è al file `assets/css/style`. Partiamo da qui.

***code n/a - .../app/views-layouts-edu_demo.html - line:34***

```html+erb
    <!-- Theme CSS -->
    <!--<link id="style-switch" rel="stylesheet" type="text/css" href="assets/css/style.css">-->
```

Ma nel tema c'è anche la cartella `scss` con il file `style.scss` e questa la preferiamo perché utilizza SAS (scss), che è meglio del semplice `css`. Quindi usiamo quest'ultima.

> Tra l'altro la cartella `.../theme_eduport/assets/css/` non l'abbiamo neanche copiata.

Per usare il file `style.scss` lo richiamiamo nel layout/edu_demo usando il relativo helper come da convenzione Rails.

> Le chiamate ai files di stylesheet e di javascript sono diverse tra HTML e Rails.<br/>
> Rails, per convenzione usa gli helpers.<br/>
> da codice HTML `h•` a codice Rails `r•`.

***code n/a - .../app/views-layouts-edu_demo.html - line:34***

```html+erb
h• <link id="style-switch" rel="stylesheet" type="text/css" href="assets/css/style.css">
r• <%= stylesheet_link_tag 'edu/scss/style', id: "style-switch", 'data-turbolinks-track': 'reload' %>
```

Quindi abbiamo:

***code 01 - .../app/views-layouts-edu_demo.html - line:34***

```html+erb
    <!-- Theme CSS -->
    <!--<link id="style-switch" rel="stylesheet" type="text/css" href="assets/css/style.css">-->
    <%= stylesheet_link_tag 'edu/scss/style', id: "style-switch", 'data-turbolinks-track': 'reload' %>
```



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

facendo refresh dell'url `https://192.168.64.3:3000` abbiamo un errore sull'asset precopile.

> lo stesso errore lo vediamo se forziamo l'asset precompile da terminale con il comando:<br/>
> `$ rails asset:precompile`



## Risolviamo l'errore di asset precompile

L'errore che riceviamo è il seguente:

```bash
ubuntu@ubuntufla:~/bl7_0 (bs)$rails assets:precompile
rails aborted!
SassC::SyntaxError: Error: Function rgb is missing argument $green.
    on line 78:7 of app/assets/stylesheets/edu/scss/../vendor/bootstrap/scss/mixins/_breakpoints.scss, in mixin `media-breakpoint-down`
    from line 133:16 of app/assets/stylesheets/edu/scss/custom/_navbar.scss
    from line 26:9 of app/assets/stylesheets/edu/scss/style.scss

>>      box-shadow: 0px 10px 30px rgb(83 88 93 / 40%);

  ————————————^

/home/ubuntu/bl7_0/app/assets/stylesheets/edu/scss/custom/_navbar.scss:147
Tasks: TOP => assets:precompile
```

Commentiamo la riga che ci dà l'errore e la sostituiamo con un comando analogo che non da l'errore.

*** …/scss/custom/_navbar.scss line 145 ***

```scss
    // Responsive dropdown menu without navbar toggle. Collapse will open on .nav-item 

    .navbar-collapse {
     //box-shadow: 0px 10px 30px rgb(83 88 93 / 40%);
     box-shadow: 0px 10px 30px rgba(83, 88, 93, 0.4);
     position: absolute;
     left: 0;
     right: 0;
     top: 100%;
     background: $body-bg;
     border-top: 1px solid rgba(0, 0, 0, 0.1);
     }
```



## Altro debug

Mi è arrivato un nuovo messaggio di errore dicendo che non era precompilato. 
potevamo eseguire `$ rails asset:precompile` oppure seguire il consigli dell'errore ed aggiungere la riga `//= link edu/scss/style.css` ad `.../app/assets/config/manifest.js`

***codice n/a - .../app/assets/config/manifest.js - line:1***

```javascript
//= link_tree ../images
//= link_directory ../stylesheets .css
//= link_tree ../../javascript .js
//= link_tree ../../../vendor/javascript .js
//= link edu/scss/style.css
```


## Variante di debug

Si può risolvere anche in un punto diverso di Rails: su config/initializers/assets.rb.

***codice n/a - .../config/initializers/assets.rb - line:1***

```ruby
Rails.application.config.assets.precompile += %w( bootstrap.min.js popper.js edu/scss/style.css)
```



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Andiamo con il browser sull'URL:

- http://192.168.64.3:3000


![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_fig01-index1.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_fig02-index2.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_fig03-index3.png)

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_fig04-index4.png)

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_fig05-index5.png)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement Eduport index style"
```


## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge ep
$ git branch -d ep
```



## Facciamo un backup su Github

```bash
$ git push origin main
```


## Andiamo in produzione con render.com

Eseguiamo il deploy manuale scegliendo "da ultimo commit".



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-index-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_00-theme_images-it.md)
