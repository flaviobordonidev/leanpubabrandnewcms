# <a name="top"></a> Cap 2.3 - Attiviamo immagini

Non ci resta che rivedere le chiamate alle immagini che ci sono sulla view ed adattarle alle convenzioni dell'asset_pipeline.



# Risorse interne

- [99-code_references/image]()



## Adattiamo le chiamate alle immagini sulla view

Abbiamo già copiato le immagini nei capitoli precedenti.
Adesso reimpostiamo i puntamenti in modo da poterle visualizzare sulle view.







## Gli helpers per puntare all'asset_pipeline

Su rails per richiamare le immagini che sono sull'asset_pipeline si usano fondamentalmente:

```html+erb
• <%= image_tag "...", alt: "Canvas Logo" %>
• <%= image_path('...') %>
```

esempi da codice HTML `h•` a codice Rails `r•`.

```html+erb
h• <img src="images/logo.png" alt="Canvas Logo">
r• <%= image_tag "logo.png", alt: "Canvas Logo" %>
```

```html+erb
h• `<div class="swiper-slide dark" style="background-image: url('images/slider/swiper/1.jpg');">`<br/>
r• `<div class="swiper-slide dark" style="background-image: url(<%= image_path('slider/swiper/1.jpg') %>);">`
```

```html+erb
h• `<img src="images/logo.png" data-rjs="images/logo@2x.png" class="logo-dark" alt="Pofo">`<br/>
r• `<%= image_tag "pofo/logo.png", 'data-rjs': image_path('pofo/logo@2x.png'), class: "logo-dark", alt: "Pofo" %>`
```

```html+erb
h• `<a href="index.html"><img class="footer-logo" src="images/logo-white.png" data-rjs="images/logo-white@2x.png" alt="Pofo"></a>`<br/>
r• `<a href="index.html"><<%= image_tag "pofo/logo-white.png", class: "footer-logo", 'data-rjs': image_path('pofo/logo-white@2x.png'), alt: "Pofo" %></a>`
```

```html+erb
h• `<img src="images/services/main-fbrowser.png" style="position: absolute; top: 0; left: 0;" data-animate="fadeInUp" data-delay="100" alt="Chrome">`
r1• `<%= image_tag "services/main-fbrowser.png", style: "position: absolute; top: 0; left: 0;", 'data-animate'=> "fadeInUp", 'data-delay'=> "100", alt: "Chrome" %>`
r2• `<%= image_tag "services/main-fbrowser.png", style: "position: absolute; top: 0; left: 0;", 'data-animate': "fadeInUp", 'data-delay': "100", alt: "Chrome" %>`
r3• `<%= image_tag "services/main-fbrowser.png", style: "position: absolute; top: 0; left: 0;", data: {animate: "fadeInUp", delay: "100"}, alt: "Chrome" %>`
```

> Ruby non accetta il dash `-` direttamente nei nomi dei simboli. 
> Non possiamo usare `:vari-able` ma dobbiamo usare `:'vari-able'`.

Vediamo tutti i modi di usare il dash `-` nei nomi delle variabili:

usando stringa:

- `a-b => "value"` # error
- `"a-b" => "value"` # ok
- `'a-b' => "value"` # ok

usando simboli:

- `:a-b => "value"` # error
- `:"a-b" => "value"` # ok
- `:'a-b' => "value"` # ok
- `a-b: "value"` # error
- `"a-b": "value"` # error
- `'a-b': "value"` # ok (con nuova sintassi da ruby 1.9)`

Oppure per i puristi:

- `{a: {b: "value}}` # ok

Esempio:

`<%= link_to "Link", link_path, {data: {something: 'value1', somethingelse: 'value2'}} %>`<br/>
Questo genera il seguente codice html:<br/>
`<a href="/link" data-something='value1' data-somethingelse='value2'>Link</a>`


> Curiosità:<br/>
> il codice `<%= image_tag asset_path(“work-masonry-2.jpg”) %>` usa `asset_path` che non mi è chiaro a cosa serva ?!?



## Impostiamo gli helpers per puntare all'asset_pipeline

Cambiamo le chiamate alle immagini dallo standard html a quello con gli helpers Rails.

> Per velocizzare la ricerca possiamo fare un "find" per le seguenti parole: "image", "png", "jpg"


La prima immagine è il logo nel menu.

***codice n/a - ...views/mockups/edu_index_4.html.erb - line:8***

```html+erb
da
        <img class="light-mode-item navbar-brand-item" src="assets/images/logo.svg" alt="logo">
        <img class="dark-mode-item navbar-brand-item" src="assets/images/logo-light.svg" alt="logo">
a
        <%= image_tag "edu/logo.svg", class: "light-mode-item navbar-brand-item", alt: "logo" %>
        <%= image_tag "edu/logo-light.svg", class: "dark-mode-item navbar-brand-item", alt: "logo" %>
```

La seconda immagine.

***codice n/a - ...views/mockups/edu_index_4.html.erb - line:88***

```html+erb
da
                      <img src="assets/images/client/uni-logo-01.svg" class="icon-md" alt="">
a
                      <%= image_tag "edu/client/uni-logo-01.svg", class: "icon-md", alt: "" %>
```

La terza immagine.

***codice n/a - ...views/mockups/edu_index_4.html.erb - line:93***

```html+erb
da
                      <img src="assets/images/client/uni-logo-02.svg" class="icon-md" alt="">
a
                      <%= image_tag "edu/client/uni-logo-02.svg", class: "icon-md", alt: "" %>
```

Altre immagini.

```html+erb
da
            <img src="assets/images/about/12.jpg" class="card-img rounded-2" alt="...">
a
            <%= image_tag "edu/about/12.jpg", class: "card-img rounded-2", alt: "..." %>
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

