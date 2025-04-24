# <a name="top"></a> La pagina course_grid

La prima pagina del tema Eduport che importiamo su Ruby on Rails.



## La pagina da importare

Normalmente si sceglie la pagina `index.html` perché spesso è quella che usa la maggior parte dello stylesheet e javascript del tema quindi ci è più utile per vedere se stiamo importando correttamente tutta la parte css, js, le immagini e i fonts.

Però nel nostro caso la navbar ha un "mega-menu" pieno di sotto menu e immagini che a noi non interessa per UbuntuDream.
Preferisco invece importare la pagina `course-grid.html` che ha un navbar completo ma con meno sottomenù.

- online su https://eduport.webestica.com/course-grid.html
- sul file zip scaricato in .../eduport_v1.4.2/template/course-grid.html


Vediamo alcune immagini sia su mobile, "mobile first", che su desktop:

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig01-index.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig02-index.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig02-index.png)


Vediamo tutto il codice *<html>* preso così com'è dal tema Eduport, senza predisposizione per Ruby on Rails.

***Codice 01 - .../eduport_v1.4.2/template/course-grid.html - linea:1***

```html
<!DOCTYPE html>
<html lang="en">
<head>
<title>Eduport - LMS, Education and Course Theme</title>

<!-- Meta Tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="author" content="Webestica.com">
<meta name="description" content="Eduport- LMS, Education and Course Theme">

<!-- Dark mode -->
<script>
```



## Creiamo il layout `empty`

Creiamo il layout vuoto `empty` da usare im una pagina di mockups in cui copieremo tutto il codice della pagina `course-grid.html` e non solo la parte all'interno del tag `<body>...</body>` come si fa normalmente nella app RoR.

***Codice 02 - .../app/views/layouts/empty.html.erb - linea:1***

```html
<%= yield %>
```

In pratica lasciamo la sola chiamata `<%= yield %>` che richiama il codice nella pagina di mockups che usa questo layout senza aggiungere nessun codice prima e dopo il tag `<body>...</body>` come si fa normalmente nella app RoR.



## Creiamo la view mockups/edu_course_grid

Creiamo la pagina `.../app/views/mockups/edu_course_grid.html.erb`, ci copiamo tutto il codice del file `.../eduport_v1.4.2/template/course-grid.html` e cambiamo nel tag `<title>...</title>` i riferimenti da eduport a ubuntudream.

***Codice 03 - .../app/views/mockups/edu_course_grid.html.erb - linea:1***

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Ubuntudream by Flavio</title>

    <!-- Meta Tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="author" content="Webestica.com">
    <meta name="description" content="Eduport- LMS, Education and Course Theme">

    <!-- Dark mode -->
    <script>
```



## Aggiorniamo l'instradamento

***Codice 04 - .../config/routes.rb - linea:1***

```ruby
  get 'mockups/edu_course_grid'
```



## Aggiorniamo il controller Mockups

Facciamo in modo che la view `mockups/edu_course_grid` utilizzi il layout `empty`.

[Codice 02 - .../controllers/mockups_controller.rb - linea: 8]()

```ruby
  def edu_course_grid
    render layout: 'empty'
  end
```



## Verifichiamo preview

```bash
#$ rails s -b 192.168.64.4
$ ./bin/dev
```

Andiamo con il browser sull'URL:

- http://192.168.64.4:3000/mockups/eduport_index

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig03-index.png)

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig04-index.png)

![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig04-index.png)



## Adattiamo l'header a RoR

I tag per eseguire stylesheet e javascript che sono nell'header sono con convenzione di "html puro" e non secondo le convenzioni di Ruby on Rails quindi non è applicata assolutamente nessuna formattazione.

Commentiamo le chiamate in "html puro" ed inseriamo le chiamate che sono su `.../app/views/layouts/application.html.erb`.

> Per commentare uso il codice Rails `<%# ... %>` 

***Codice 05 - .../app/views/mockups/edu_course_grid.html.erb - linea:1***

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Ubuntudream by Flavio</title>

    <!-- Meta Tags -->
<%#
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="author" content="Webestica.com">
    <meta name="description" content="Eduport- LMS, Education and Course Theme">
%>

    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="mobile-web-app-capable" content="yes">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <!-- Dark mode -->
    <script>
```

***Codice 05 - .../app/views/mockups/edu_course_grid.html.erb - linea:73***

```html
  </script>

    <!-- Favicon -->
    <link rel="shortcut icon" href="assets/images/favicon.ico">

<%#
    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;700&family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- Plugins CSS -->
    <link rel="stylesheet" type="text/css" href="assets/vendor/font-awesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="assets/vendor/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="assets/vendor/choices/css/choices.min.css">

    <!-- Theme CSS -->
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
%>

    <link rel="icon" href="/icon.png" type="image/png">
    <link rel="icon" href="/icon.svg" type="image/svg+xml">
    <link rel="apple-touch-icon" href="/icon.png">

    <%# Includes all stylesheet files in app/assets/stylesheets %>
    <%= stylesheet_link_tag :app, "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>

  </head>

  <body>
```



## Verifichiamo preview

```bash
#$ rails s -b 192.168.64.4
$ ./bin/dev
```

Andiamo con il browser sull'URL:

- http://192.168.64.4:3000/mockups/eduport_index

![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig04-index.png)

Adesso è già molto più vicina all'originale.
Nel prossimo capitolo inseriamo lo stile css ed il javascript del tema eduport.

---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
