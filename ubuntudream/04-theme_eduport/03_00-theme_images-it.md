# <a name="top"></a> Cap 2.3 - Attiviamo immagini

Non ci resta che rivedere le chiamate alle immagini che ci sono sulla view ed adattarle alle convenzioni dell'asset_pipeline.



# Risorse interne

- [99-code_references/image]()




## Adattiamo le chiamate alle immagini sulla view

Abbiamo già copiato le immagini nei capitoli precedenti.
Adesso reimpostiamo i puntamenti in modo da poterle visualizzare sulle view.

> Per velocizzare la ricerca possiamo fare un "find" per le seguenti parole: "image", "png", "jpg"

Cambiamo le chiamate alle immagini dallo standard html a quello con gli helpers Rails.
Adattiamo da codice HTML `h•` a codice Rails `r•`.

- - - -

***NAVIGATION MENU (navbar)***

Immagine 1: il logo "Eduport" in alto a destra nel menu.

***codice n/a - ...views/mockups/edu_index.html.erb - line:8***

```html+erb
h• <img class="light-mode-item navbar-brand-item" src="assets/images/logo.svg" alt="logo">
   <img class="dark-mode-item navbar-brand-item" src="assets/images/logo-light.svg" alt="logo">
r• <%= image_tag "edu/logo.svg", class: "light-mode-item navbar-brand-item", alt: "logo" %>
   <%= image_tag "edu/logo-light.svg", class: "dark-mode-item navbar-brand-item", alt: "logo" %>
```

Immagine 2: logo università nel sotto-menu *category->marketing*, nella colonna *Degree*.

***codice n/a - ...continua - line:87***

```html+erb
h• <img src="assets/images/client/uni-logo-01.svg" class="icon-md" alt="">
r• <%= image_tag "edu/client/uni-logo-01.svg", class: "icon-md", alt: "" %>
```

Immagine 3: logo università nel sotto-menu *category->marketing*, nella colonna *Degree*.

***codice n/a - ...continua - line:95***

```html+erb
h• <img src="assets/images/client/uni-logo-02.svg" class="icon-md" alt="">
r• <%= image_tag "edu/client/uni-logo-02.svg", class: "icon-md", alt: "" %>
```

Immagine 4: logo università nel sotto-menu *category->marketing*, nella colonna *Degree*.

***codice n/a - ...continua - line:103***

```html+erb
h• <img src="assets/images/client/uni-logo-03.svg" class="icon-md" alt="">
r• <%= image_tag "edu/client/uni-logo-03.svg", class: "icon-md", alt: "" %>
```

Immagine 5: logo università nel sotto-menu *category->marketing*, nella colonna *Degree*.

***codice n/a - ...continua - line:111***

```html+erb
h• <img src="assets/images/client/uni-logo-01.svg" class="icon-md" alt="">
r• <%= image_tag "edu/client/uni-logo-01.svg", class: "icon-md", alt: "" %>
```

Immagine 6: logo università nel sotto-menu *category->marketing*, nella colonna *Degree*.

***codice n/a - ...continua - line:119***

```html+erb
h• <img src="assets/images/client/uni-logo-04.svg" class="icon-md" alt="">
r• <%= image_tag "edu/client/uni-logo-04.svg", class: "icon-md", alt: "" %>
```

Immagine 7: pattern nel background nel sotto-menu nella sezione Advertisement.

***codice n/a - ...continua - line:169***

```html+erb
h• <div class="card bg-blue rounded-0 rounded-bottom p-3 position-relative overflow-hidden" style="background:url(assets/images/pattern/05.png) no-repeat center center; background-size:cover;">
r• <div class="card bg-blue rounded-0 rounded-bottom p-3 position-relative overflow-hidden" style="background:url(<%= image_path('edu/pattern/05.png') %>) no-repeat center center; background-size:cover;">
```

Immagine 8: "donna con cellulare in download" nel sotto-menu *megamenu*, colonna *Download Eduport*.

***codice n/a - ...continua - line:475***

```html+erb
h• <img src="assets/images/element/14.svg" alt="">
r• <%= image_tag "edu/element/14.svg", alt: "" %>
```

Immagine 9: "icona Google play" nel sotto-menu *megamenu*, colonna *Download Eduport*.

***codice n/a - ...continua - line:481***

```html+erb
h• <a href="#"> <img src="assets/images/client/google-play.svg" class="btn-transition" alt="google-store"> </a>
r• <a href="#"> <%= image_tag "edu/client/google-play.svg", class: "btn-transition", alt: "google-store" %> </a>
```

Immagine 10: "icona Apple store" nel sotto-menu *megamenu*, colonna *Download Eduport*.

***codice n/a - ...continua - line:485***

```html+erb
h• <a href="#"> <img src="assets/images/client/app-store.svg" class="btn-transition" alt="app-store"> </a>
r• <a href="#"> <%= image_tag "edu/client/app-store.svg", class: "btn-transition", alt: "app-store" %> </a>
```

Immagine 11: "icona Apple store" nel sotto-menu *megamenu*, colonna *Download Eduport*.

***codice n/a - ...continua - line:495***

```html+erb
h• <img class="avatar-img rounded-circle" src="assets/images/avatar/09.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/09.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
```

Immagine 12: "avatar" nell'ultimo sotto-menu.

***codice n/a - ...continua - line:559***

```html+erb
h• <img class="avatar-img rounded-circle" src="assets/images/avatar/01.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/01.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
```

Immagine 13: "avatar" aperto l'ultimo sotto-menu.

***codice n/a - ...continua - line:567***

```html+erb
h• <img class="avatar-img rounded-circle shadow" src="assets/images/avatar/01.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/01.jpg", class: "avatar-img rounded-circle shadow", alt: "avatar" %>
```

- - - -

***MAIN CONTENT START***

Immagine 1: "icona atomo" alla destra del titolo "Limitless learning at your fingertips".

***codice n/a - ...continua - line:814***

```html+erb
h• <img src="assets/images/client/science.svg" alt="Icon">
r• <%= image_tag "edu/client/science.svg", alt: "Icon" %>
```

Immagine 2: "icona angular" alla destra del titolo "Limitless learning at your fingertips".

***codice n/a - ...continua - line:567***

```html+erb
h• <img src="assets/images/client/angular.svg" alt="Icon">
r• <%= image_tag "edu/client/angular.svg", alt: "Icon" %>
```











Altre immagini.

```html+erb
h• <img src="assets/images/about/12.jpg" class="card-img rounded-2" alt="...">
r• <%= image_tag "edu/about/12.jpg", class: "card-img rounded-2", alt: "..." %>
```










Impostiamo il favicon che si visualizza sul tab del browser

{id: "11-02-04_01", caption: ".../app/views/layouts/mockup_pofo.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 18}
```
  <!-- favicon -->
  <link rel="shortcut icon" href="<%=image_path('pofo/favicon.png')%>">
  <link rel="apple-touch-icon" href="<%=image_path('pofo/apple-touch-icon-57x57.png')%>">
  <link rel="apple-touch-icon" sizes="72x72" href="<%=image_path('pofo/apple-touch-icon-72x72.png')%>">
  <link rel="apple-touch-icon" sizes="114x114" href="<%=image_path('pofo/apple-touch-icon-114x114.png')%>">
```


Impostiamo il logo sulla barra del menu

{id: "11-02-04_01", caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 63}
```
  <a href="index.html" title="Pofo" class="logo"><%= image_tag "pofo/logo.png", 'data-rjs': image_path('pofo/logo@2x.png'), class: "logo-dark", alt: "Pofo" %><%= image_tag "pofo/logo-white.png", 'data-rjs': image_path('pofo/logo-white@2x.png'), alt: "Pofo", class: "logo-light default" %></a>
```


Impostiamo le due immagini dentro il mega-menu alla voce "PORTFOLIO"

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 294}
```
  <a href="home-creative-studio.html" class="menu-banner-image"><%= image_tag "pofo/menu-banner-01.png", alt: "portfolio" %></a>
```

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 297}
```
  <a href="home-creative-business.html" class="menu-banner-image"><%= image_tag "pofo/menu-banner-02.png", alt: "portfolio" %></a>
```


Impostiamo l'immagine del titolo, quella subito sotto il mega-menu.
Già la vediamo, è il rettangolo grigio con scritto 1920x1100, immagine presa online da http://placehold.it/1920x1100

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 602}
```
  <section class="wow fadeIn parallax" data-stellar-background-ratio="0.5" style="background-image:url('<%= image_path('http://placehold.it/1920x1100') %>');">
OPPURE
  <section class="wow fadeIn parallax" data-stellar-background-ratio="0.5" style="background-image:url('<%= image_path('pofo/parallax-bg33.jpg') %>');">
```

La cambiamo con un'immagine 1920x1100 che scarichiamo dal web, ad esempio ho preso: Image by S. Hermann & F. Richter from Pixabay 

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 602}
```
  <section class="wow fadeIn parallax" data-stellar-background-ratio="0.5" style="background-image:url('<%= image_path('pofo/hamster-shopping-1920x1133.jpg') %>');">
```


Impostiamo la prima immagine della griglia degli articoli
Già la vediamo, è il rettangolo grigio con scritto 750x500, immagine presa online da "http://placehold.it/750x500". Noi la sostituiamo con un'altra immagine scaricata dal web.

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 626}
```
  <%= image_tag "pofo/web-fox-640x403.jpg", alt: "" %>
```


Impostiamo l'immagine dell'autore del primo articolo
Già la vediamo, è il cerchietto grigio con scritto 149x149 (<img src="http://placehold.it/149x149" alt="" class="rounded-circle">).

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 633}

```
  <%#= image_tag "pofo/web-avatar-lady-red-hair.jpg", alt: "", class: "border-radius-100" %>
  <%= image_tag "pofo/web-avatar-lady-red-hair.png", alt: "", class: "rounded-circle" %>
  <!--<img src="http://placehold.it/149x149" alt="" class="rounded-circle">-->
```


Discorso analogo per il 2° articolo (immagine articolo e immagine autore)

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 626}
```
  <%= image_tag "pofo/web-fox-640x403.jpg", alt: "" %>
```

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 633}

```
  <%= image_tag "pofo/web-avatar-lady-red-hair.png", alt: "", class: "rounded-circle" %>
```


Discorso analogo per il 3° articolo (immagine articolo e immagine autore)

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 626}
```
  <%= image_tag "pofo/web-fox-640x403.jpg", alt: "" %>
```

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 633}

```
  <%= image_tag "pofo/web-avatar-lady-red-hair.png", alt: "", class: "rounded-circle" %>
```


Discorso analogo per il 4° articolo (immagine articolo e immagine autore)

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 626}
```
  <%= image_tag "pofo/web-fox-640x403.jpg", alt: "" %>
```

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 633}

```
  <%= image_tag "pofo/web-avatar-lady-red-hair.png", alt: "", class: "rounded-circle" %>
```


Discorso analogo per gli articoli da 5° a 8° (immagine articolo e immagine autore)


Impostiamo l'immagine del logo di Pofo nel footer.
 
{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 804}
```
  <a href="index.html"><<%= image_tag "pofo/logo-white.png", class: "footer-logo", 'data-rjs': image_path('pofo/logo-white@2x.png'), alt: "Pofo" %></a>
```


Impostiamo le immagini nel footer nella sezione "LATEST BLOG POST"

{caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 838}
```
  <a href="blog-post-layout-01.html"><%= image_tag "pofo/web-camels-640x427.jpg", alt: "" %></a>
  ...
  <a href="blog-post-layout-02.html"><%= image_tag "pofo/web-camels-640x427.jpg", alt: "" %></a>
  ...
  <a href="blog-post-layout-03.html"><%= image_tag "pofo/web-camels-640x427.jpg", alt: "" %></a>
```













## Apriamo il branch "Import Images"

Continuiamo con il branch aperto



## importiamo le immagini dal tema Pofo all'asset_pipeline

E' arrivato il momento di importare le immagini dal tema alla nostra app Rails. 



## Seguiamo l'ordine delle chiamate sul file posts_index

{id: "11-02-04_01", caption: ".../app/views/mockups/blog_clean_full_width.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 15}
```
        <link rel="shortcut icon" href="images/favicon.png">
        <link rel="apple-touch-icon" href="images/apple-touch-icon-57x57.png">
        <link rel="apple-touch-icon" sizes="72x72" href="images/apple-touch-icon-72x72.png">
        <link rel="apple-touch-icon" sizes="114x114" href="images/apple-touch-icon-114x114.png">
```

