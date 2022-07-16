# <a name="top"></a> Cap 2.1 - Importiamo una pagina dal tema

Importiamo una pagina del tema ed implementiamo tutto lo stile ed il codice javascript per visualizzarla correttamente.

I passaggi per importare il tema Edu sulla nostra app Rails:

1. Scegliamo una pagina html da importare. Ad esempio: *index.html*
2. Usiamo un nuovo layout che chiamiamo "edu_base" e copiamo tutto il contenuto del layout di default "application".
3. Importiamo sul layout *edu_base* le linee di codice tra i tags <head>...</head> che non sono già presenti ed adattiamo i "puntamenti" per richiamare stylesheets e javascripts
4. Importiamo tutto il codice tra i tags <body>...</body> su *mockups/edu_index.html.erb*
5. Aggiorniamo controllers/mockups_controller.rb e config/routes.rb
6. Nel preview vediamo il testo senza stylesheets, images e javascripts
7. copiamo i files stylesheets (css, scss) su "assets/stylesheets/edu"
8. copiamo le immagini (png, jpg) su "assets/images/edu"
9. copiamo i files javascripts (js) su "assets/javascripts/edu"
10. su *mockups/edu_index.html.erb* aggiustiamo i "puntamenti" per richiamare stylesheets, images e javascripts



## Risorse esterne

- [file di esempio preso dal tema Eduport](file:///Users/FB/eduport_v1.2.0/template/index.html).
- [indice della documentazione dentro il tema Eduport](file:///Users/FB/eduport_v1.2.0/template/docs/index.html)



## Apriamo il branch

continuiamo con il branch aperto nel capitolo precedente


## Scegliamo la pagina

La pagina che abbiamo scelto è *index*.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_fig01-index-4.png)

Vediamo tutto il codice <html> preso così com'è dal tema Eduport, senza predisposizione per Ruby on Rails.

***codice 01 - ...non rails html index-4.html - line:1***

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Eduport - LMS, Education and Course Theme</title>

	<!-- Meta Tags -->
	<meta charset="utf-8">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_01-index-4.html)

Riadattiamo questo codice alla nostra applicazione su Ruby on Rails.



## Prepariamo un layout dedicato

Per gestire la parte che è tra i tags `<head> ... </head>` creiamo un layout dedicato che chiamiamo *edu_base*.

Duplichiamo il file `.../layouts/application.html.erb` e rinominiamo la copia `.../layouts/edu_demo.html.erb`. 

Aggiungiamo sul layout *edu_base* le linee di codice tra i tags <head>...</head> che non sono già presenti ed adattiamo i "puntamenti" per richiamare stylesheets e javascripts.

***codice 02 - .../app/views/layouts/edu_base.html.erb - line:6***

```html+erb
  	<!-- Meta Tags -->
  	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<meta name="author" content="Flavio Bordoni">
  	<meta name="description" content="Eduport- LMS, Education and Course Theme">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_02-views-layouts-edu_demo.html.erb)



## Impostiamo gli helpers per puntare all'asset_pipeline

Le chiamate ai files di stylesheet e di javascript sono diverse tra HTML e Rails. Rails usa gli helpers. Adattiamo quindi le chiamate per rispondere alle convenzioni Rails.

Inseriamo gli helpers che puntano all'asset_pipeline sia per stylesheets che javascripts:

- da `<link rel="stylesheet" href="css/xxx.css" />` <br/>
  a  `<%= stylesheet_link_tag 'pofo/css/xxx', media: 'all', 'data-turbolinks-track': 'reload' %>`
- da `<script type="text/javascript" src="js/xxx.js"></script>`  <br/>
  a  `<%= javascript_include_tag 'pofo/js/xxx', 'data-turbolinks-track' => true %>`


Impostiamoli da layouts/edu_base

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



## Creiamo la nuova view

Creiamo la nuova views `mockups/index` ed inseriamo il codice del nostro file del tema che è dentro i tags `<body>...</body>`. Inoltre commentiamo le chiamate a javascript in fondo al codice perché tanto non funzionerebbero perché non hanno i puntamenti corretti all'asset-pipeline e darebbero solo errore nella java console del browser.

***codice 03 - ...views/mockups/index.html.erb - line:1***

```html+erb
<!-- Header START -->
<header class="navbar-light navbar-sticky navbar-transparent">
  <!-- Logo Nav START -->
  <nav class="navbar navbar-expand-xl">
    <div class="container">
      <!-- Logo START -->
      <a class="navbar-brand" href="index.html">
        <img class="light-mode-item navbar-brand-item" src="assets/images/logo.svg" alt="logo">
        <img class="dark-mode-item navbar-brand-item" src="assets/images/logo-light.svg" alt="logo">
      </a>
      <!-- Logo END -->
  
      <!-- Responsive navbar toggler -->
      <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
        aria-controls="navbarCollapse" aria-expanded="true" aria-label="Toggle navigation">
        <span class="me-2"><i class="fas fa-search fs-5"></i></span>
      </button>
  
      <!-- Category menu START -->
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_03-views-mockups-edu_index.html.erb)



## Attiviamo instradamento

Facciamo in modo che la nuova view `index` utilizzi il controller mockups. 

***codice 04 - ...config/routes.rb - line:20***

```ruby
  get 'mockups/index'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_04-config-routes.rb)



## Aggiorniamo il controller con nuova view e nuovo layout

Facciamo in modo che la nuova view `index` utilizzi il layout `edu_base`.

Aggiorniamo il conroller.

***codice 05 - ...controllers/mockups_controller.rb - line:8***

```ruby
  def index
    render layout: 'edu_base'
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_05-controllers-mockups_controller.rb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

Andiamo con il browser sull'URL:

- http://192.168.64.3:3000/mockups/edu_index

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_fig02-edu_index.png)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement Eduport index"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku bs:main
```



## Chiudiamo il branch

Lo chiudiamo più avanti.



## Facciamo un backup su Github

Lo facciamo più avanti.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/02_00-theme_stylesheet.md)
