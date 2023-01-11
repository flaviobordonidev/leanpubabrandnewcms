# <a name="top"></a> Cap 2.1 - Importiamo una pagina dal tema

Importiamo una pagina del tema ed implementiamo tutto lo stile ed il codice javascript per visualizzarla correttamente.

I passaggi per importare il tema Eduport sulla nostra app Rails:

1. Scegliamo una pagina html da importare. Ad esempio: *course-list.html*
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

- [file di esempio preso dal tema Eduport](file:///Users/FB/eduport_v1.2.0/template/course-list.html).
- [indice della documentazione dentro il tema Eduport](file:///Users/FB/eduport_v1.2.0/template/docs/index.html)



## Apriamo il branch

continuiamo con il branch aperto nel capitolo precedente



## Scegliamo la pagina

La pagina che abbiamo scelto è *course-list*.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/04-course-list-stylesheet/01_fig01-course-list.png)

Vediamo tutto il codice <html> preso così com'è dal tema Eduport, senza predisposizione per Ruby on Rails.

***codice 01 - ...non rails html course-list.html - line:1***

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Eduport - LMS, Education and Course Theme</title>

	<!-- Meta Tags -->
	<meta charset="utf-8">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/04-course-list-stylesheet/01_01-course-list.html)

Riadattiamo questo codice alla nostra applicazione su Ruby on Rails.



## Verifichiamo il layout dedicato `edu_demo`

Per gestire la parte tra i tags `<head> ... </head>` usiamo il layout *edu_demo* creato nel capitolo precedente di *02-index_4*.

Verifichiamo che la parte tra i tags `<head> ... </head>` di *course-list.html* sia pienamente rappresentata nel layout *edu_demo*.

***codice n/a - ...non rails html course-list.html - line:1***

```html+erb
<head>
	<title>Eduport - LMS, Education and Course Theme</title>

	<!-- Meta Tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="author" content="Webestica.com">
	<meta name="description" content="Eduport- LMS, Education and Course Theme">

	<!-- Favicon -->
	<link rel="shortcut icon" href="assets/images/favicon.ico">

	<!-- Google Font -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;700&family=Roboto:wght@400;500;700&display=swap">

	<!-- Plugins CSS -->
	<link rel="stylesheet" type="text/css" href="assets/vendor/font-awesome/css/all.min.css">
	<link rel="stylesheet" type="text/css" href="assets/vendor/bootstrap-icons/bootstrap-icons.css">
	<link rel="stylesheet" type="text/css" href="assets/vendor/choices/css/choices.min.css">

	<!-- Theme CSS -->
	<link id="style-switch" rel="stylesheet" type="text/css" href="assets/css/style.css">

</head>
```

***codice 02 - .../app/views/layouts/edu_demo.html.erb - line:1***

```html+erb
<!DOCTYPE html>
<html>
  <head>
    <title><%= yield(:html_head_title) %> | Baseline7_0</title>

  	<!-- Meta Tags -->
  	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<meta name="author" content="Flavio Bordoni">
  	<meta name="description" content="Eduport- LMS, Education and Course Theme">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= stylesheet_link_tag "actiontext", "data-turbo-track": "reload" %> <!--to fix broken UI adding bootstrap-->
    <%= javascript_importmap_tags %>
  </head>

  <body>
    <% if notice %><p class="alert alert-info"><%= notice %></p><% end %>
    <% if alert %><p class="alert alert-warning"><%= alert %></p><% end %>
    <%= yield %>
  </body>
</html>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/04-course-list/01_02-views-layouts-edu_demo.html.erb)



## Creiamo la nuova view

Creiamo la nuova views `edu_index` ed inseriamo il codice del nostro file del tema che è dentro i tags `<body>...</body>`.

***codice 03 - ...views/mockups/eduport_course_list.html.erb - line:1***

```html+erb
<!-- Header START -->
<header class="navbar-light navbar-sticky">
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
			<button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-animation">
					<span></span>
					<span></span>
					<span></span>
				</span>
			</button>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/04-course-list/01_03-views-mockups-eduport_course_list.html.erb)



## Attiviamo instradamento

Facciamo in modo che la nuova view `course_list` utilizzi il controller mockups. 

***codice 04 - ...config/routes.rb - line:20***

```ruby
  get 'mockups/course_list'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_04-config-routes.rb)



## Aggiorniamo il controller con nuova view e nuovo layout

Facciamo in modo che la nuova view `eduport_course_list` utilizzi il layout `eduport`.

Aggiorniamo il conroller.

***codice 05 - ...controllers/mockups_controller.rb - line:6***

```ruby
  def eduport_course_list
    render layout: "eduport"
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
