# <a name="top"></a> Cap 4.2 - Attiviamo stile del tema

Attiviamo lo stylesheets.

Possiamo avere due approcci:

- aggiungere piano piano -> copiare un po' di codice alla volta.
- togliere piano piano -> mettere tutto il codice e togliere quello che non usiamo.

Il primo approccio ci fa capire meglio come è strutturato il codice dello stylesheets ma è più complesso da implementare.
Il secondo è più semplice sia come implementazione iniziale che dei successivi upgrade del tema.
Noi scegliamo il secondo approccio.


Importiamo i files stylesheets

Continuiamo con i passaggi per importare il tema Edu sulla nostra app Rails:

6. copiamo i files stylesheets (css, scss) su "assets/stylesheets/edu"
7. copiamo le immagini (png, jpg) su "assets/images/edu"
8. copiamo i files javascripts (js) su "assets/javascripts/edu"
9. su mockups/edu_index_4.html.erb aggiustiamo i "puntamenti" per richiamare stylesheets, images e javascripts.



## Risorse esterne

- [file di esempio preso dal tema Eduport](file:///Users/FB/eduport_v1.2.0/template/index-4.html).
- [indice della documentazione dentro il tema Eduport](file:///Users/FB/eduport_v1.2.0/template/docs/index.html)



## Vediamo la cartella *assets* del tema Eduport

Nella documentazione vediamo questa struttura di cartelle/directories dentro il tema Eduport.
Vediamo la struttura dentro la cartella "assets/", che contiene tutti i files degli "assets" (stylesheets e javascripts) che usa il tema.

Nel tema *Eduport* all'interno della cartella *template/assets* ci sono le seguenti cartelle:

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
.../theme_eduport/assets/css/     | *questa cartella **non** la copiamo? Credo serva per fare le nostre personalizzazioni.
.../theme_eduport/assets/images/  | .../app/assets/images/eduport/
.../theme_eduport/assets/js/      | .../app/javascript/eduport/
.../theme_eduport/assets/scss/    | .../app/assets/stylesheets/eduport/scss/
.../theme_eduport/assets/vendor/  | .../app/assets/stylesheets/eduport/vendor/

> Le varie sottocartelle ***edu/*** le creiamo noi.

Vediamo il risultato finale.

Cartella copiata            | sottocartelle
| :---                      | :---
.../app/assets/images/edu/  | - about <br/> - avatar <br/> - bg <br/> - ... <br/> - logo.svg
.../app/assets/stylesheets/edu/scss/    | - components <br/> - custom <br/> - dark <br/> - ... <br/> - style.scss
.../app/assets/stylesheets/edu/vendor/  | - animate <br/> - aos <br/> - ... <br/> - tiny-slider


Una volta copiati tutti i contenuti delle quattro cartelle nelle rispettive cartelle della nostra app siamo pronti per attivarle.

> le varie cartelle ***eduport*** le creiamo noi e poi ci copiamo i vari files.

Il risultato finale è quindi:

- app
  - assets
    - images
      - eduport
        - about
        - avatar
        - bg
        - ...
        - logo.svg
    - stylesheets
      - edueduport
        - scss
          - components
          - custom
          - dark
          - ...
          - style.scss
        - vendor
          - animate
          - aos
          - ...
          - tiny-slider
  - javascript
    - eduport
      - functions.js




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




## Impostiamo gli helpers per puntare all'asset_pipeline

Le chiamate ai files di stylesheet e di javascript sono diverse tra HTML e Rails. Rails usa gli helpers. Adattiamo quindi le chiamate per rispondere alle convenzioni Rails.

Inseriamo gli helpers che puntano all'asset_pipeline sia per stylesheets che javascripts.

DA                                             | A
| :---                                         | :--- 
<link rel="stylesheet" type="text/css" href="assets/css/style.css"> | <%= stylesheet_link_tag 'eduport/scss/style.scss', media: 'all', 'data-turbolinks-track': 'reload' %>

`<script type="text/javascript" src="js/xxx.js"></script>` | `<%= javascript_include_tag 'eduport/xxx', 'data-turbolinks-track' => true %>`



- da `<link rel="stylesheet" href="css/xxx.css" />` <br/>
  a  `<%= stylesheet_link_tag 'pofo/css/xxx', media: 'all', 'data-turbolinks-track': 'reload' %>`
- da `<script type="text/javascript" src="js/xxx.js"></script>`  <br/>
  a  `<%= javascript_include_tag 'pofo/js/xxx', 'data-turbolinks-track' => true %>`


Impostiamoli da layouts/edu_demo

da 

```html
	<!-- Theme CSS -->
	<link id="style-switch" rel="stylesheet" type="text/css" href="assets/css/style.css">
```

a 

```html+erb
	<!-- Theme CSS -->
  <%= stylesheet_link_tag 'edu/css/style.css', media: 'all', 'data-turbolinks-track': 'reload', id: 'style-switch' %>
```

[tutto il codice](#11-02-02_01all)


Copiamo il file *style.css* dal tema alla nostra app.






## Precompile per lo stylesheets

*non dovrebbe servire più ricompilare*

Nell'asset_pipeline l'unico file che si può chiamare direttamente dalla view è "assets/stylesheets/application.scss" questo file è detto file manifest ed è da questo file che dovremmo chiamare tutti gli altri.
Nel nostro caso siccome richiamiamo i vari files di style direttamente dalla view dobbiamo dichiararle all'applicazione. Questa "dichiarazione" è chiamata "precompile". 

Per i nuovi files si può usare tutte le volte che si fanno modifiche il comando

```bash
$ rails assets:precompile
```


Oppure si può aggiungere al config/application che fa in automatico il precompile.



{id: "11-02-02_02", caption: ".../config/application.rb -- codice 02", format: ruby, line-numbers: true, number-from: 21}
```
    # precompile assets pofo stylesheets                                                             
    config.assets.precompile += ['pofo/css/animate.css',
                                 'pofo/css/bootstrap.min.css',
                                 'pofo/css/et-line-icons.css',
                                 'pofo/css/font-awesome.min.css',
                                 'pofo/css/themify-icons.css',
                                 'pofo/css/swiper.min.css',
                                 'pofo/css/justified-gallery.min.css',
                                 'pofo/css/magnific-popup.css',
                                 'pofo/revolution/css/settings.css',
                                 'pofo/revolution/css/layers.css',
                                 'pofo/revolution/css/navigation.css',
                                 'pofo/css/bootsnav.css',
                                 'pofo/css/style.css',
                                 'pofo/css/responsive.css'
                                ]
```

Non seguiamo la convenzione Rails dell'asset_pipeline che prevede di passare per i files manifest perché non li vogliamo attivare per tutta l'applicazione, ma vogliamo richiamarli solo dalle pagine in cui è espressamente fatta la chiamata.

I> Attenzione!
I>
I> Modificando application.rb è necessario riavviare il server rails (rails s ...) per includere le modifiche.



![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/02_fig01-edu_index_4.png)




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




---



## Risolviamo un problema su una linea di codice scss

Domanda

I’m installing your theme Eduport on Ruby on Rails.

To make it works I had to comment a row of scss code regarding “box-shadow” otherwise I receive the below error:

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

If I comment the line as the below code everything works fine.

*** …/scss/custom/_navbar.scss line 145 ***

```scss
    // Responsive dropdown menu without navbar toggle. Collapse will open on .nav-item 

    .navbar-collapse {
     //box-shadow: 0px 10px 30px rgb(83 88 93 / 40%);
     position: absolute;
     left: 0;
     right: 0;
     top: 100%;
     background: $body-bg;
     border-top: 1px solid rgba(0, 0, 0, 0.1);
     }

    .navbar-collapse .navbar-nav .nav-item {
     border-bottom: 1px solid rgba(0, 0, 0, 0.1);
     padding: 8px 30px;
    }
```

How can I solve this issue without commenting the line of code?

Thanks

---

Risposta

Hi Flavio,

Try to replace

`box-shadow: 0px 10px 30px rgb(83 88 93 / 40%);`

to

`box-shadow: 0px 10px 30px rgba(83, 88, 93, 0.4);`

in navbar.scss it will work.

Thanks



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



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

Andiamo con il browser sull'URL:

- http://192.168.64.3:3000/mockups/edu_index_4

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_fig02-edu_index_4.png)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement Eduport index-4"
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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_00-steps.md)
