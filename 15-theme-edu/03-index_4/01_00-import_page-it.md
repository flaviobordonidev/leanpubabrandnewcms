# <a name="top"></a> Cap 2.1 - Importiamo una pagina dal tema

Importiamo una pagina del tema ed implementiamo tutto lo stile ed il codice javascript per visualizzarla correttamente.

I passaggi per importare il tema Edu sulla nostra app Rails:

1. Scegliamo una pagina html da importare. Ad esempio: *index.html*
2. Usiamo un nuovo layout che chiamiamo "edu_demo" su cui mettiamo quello di default "application".
   (rivedi parte boostrap)
3. Importiamo tutto il codice tra i tags <body>...</body> su *mockups/edu_index.html.erb*
4. Aggiorniamo controllers/mockups_controller.rb e config/routes.rb
5. Nel preview vediamo il testo senza stylesheets, images e javascripts
6. copiamo i files stylesheets (css, scss) su "assets/stylesheets/pofo"
7. copiamo le immagini (png, jpg) su "assets/images/pofo"
8. copiamo i files javascripts (js) su "assets/javascripts/pofo"
9. su mockups/mypage.html.erb aggiustiamo i "puntamenti" per richiamare stylesheets, images e javascripts



## Risorse esterne

- [file di esempio preso dal tema Eduport](file:///Users/FB/eduport_v1.2.0/template/index-4.html).
- [indice della documentazione dentro il tema Eduport](file:///Users/FB/eduport_v1.2.0/template/docs/index.html)



## Apriamo il branch

continuiamo con il branch aperto nel capitolo precedente


## Scegliamo la pagina

La pagina che abbiamo scelto è *index-4*.

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

Per gestire la parte che è tra i tags `<head> ... </head>` creiamo un layout dedicato che chiamiamo *edu_demo*.

Duplichiamo il file `.../layouts/application.html.erb` e rinominiamo la copia `.../layouts/edu_demo.html.erb`. 

Iniziamo con il codice base creato in automatico da Rails.

***codice 02 - .../app/views/layouts/edu_demo.html.erb - line:1***

```html+erb
<!DOCTYPE html>
<html>
  <head>
    <title>Eduport</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```

Ed aggiungiamo alcune righe 

***codice 02 - .../app/views/layouts/edu_demo.html.erb - line:6***

```html+erb
  	<!-- Meta Tags -->
  	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<meta name="author" content="Flavio Bordoni">
  	<meta name="description" content="Eduport- LMS, Education and Course Theme">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_02-views-layouts-edu_demo.html.erb)



## Creiamo la nuova view

Creiamo la nuova views `edu_index` ed inseriamo il codice del nostro file del tema che è dentro i tags `<body>...</body>`.

***codice 03 - ...views/mockups/edu_index.html.erb - line:1***

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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_03-views-mockups-edu_index_4.html.erb)



## Attiviamo instradamento

Facciamo in modo che la nuova view `edu_index` utilizzi il controller mockups. 

***codice 04 - ...config/routes.rb - line:20***

```ruby
  get 'mockups/edu_index'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_04-config-routes.rb)



## Aggiorniamo il controller con nuova view e nuovo layout

Facciamo in modo che la nuova view `edu_index_4` utilizzi il layout `edu_demo`.

Aggiorniamo il conroller.

***codice 05 - ...controllers/mockups_controller.rb - line:8***

```ruby
  def edu_index_4
    render layout: 'edu_demo'
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_05-controllers-mockups_controller.rb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

Andiamo con il browser sull'URL:

- http://192.168.64.3:3000/mockups/edu_index_4

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_fig02-edu_index_4.png)



## Iniziamo ad aggiungere righe di codice al layer edu_demo

Aggiungiamo alcune righe 

***codice 02 - .../app/views/layouts/edu_demo.html.erb - line:6***

```html+erb
  	<!-- Meta Tags -->
  	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<meta name="author" content="Flavio Bordoni">
  	<meta name="description" content="Eduport- LMS, Education and Course Theme">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_02-views-layouts-edu_demo.html.erb)



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

Lo chiudiamo più avanti.



## Facciamo un backup su Github

Lo facciamo più avanti.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/02_00-theme_stylesheet.md)
