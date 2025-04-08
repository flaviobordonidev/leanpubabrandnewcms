# <a name="top"></a> Cap 4.4 - Attiviamo immagini

Non ci resta che rivedere le chiamate alle immagini che ci sono sulla view ed adattarle alle convenzioni dell'asset_pipeline.


# Risorse interne

- [99-code_references/image]()


# Risorse esterne

- [](https://medium.com/@cindyk09/implementing-boostrap-theme-into-your-rails-app-55bb9085feae)
- [how-to-escape-a-dash-in-a-ruby-symbol](https://stackoverflow.com/questions/8482024/how-to-escape-a-dash-in-a-ruby-symbol)
- [ruby-1-9-hash-with-a-dash-in-a-key](https://stackoverflow.com/questions/2134702/ruby-1-9-hash-with-a-dash-in-a-key)



## Gli helpers per puntare all'asset_pipeline

Su rails per richiamare le immagini che sono sull'asset_pipeline si usano fondamentalmente:

```html+erb
● <%= image_tag "...", alt: "Canvas Logo" %>
● <%= image_path('...') %>
```

Esempi:
Passiamo da codice HTML `h:` a codice Rails `r:` che usa gli `helpers` per l'asset pipeline. (come faceva sprocket)

```html
h: <img src="images/logo.png" alt="Canvas Logo">
r: <%= image_tag "logo.png", alt: "Canvas Logo" %>
```

```html
h: `<div class="swiper-slide dark" style="background-image: url('images/slider/swiper/1.jpg');">`<br/>
r: `<div class="swiper-slide dark" style="background-image: url(<%= image_path('slider/swiper/1.jpg') %>);">`
```

```html
h: `<img src="images/logo.png" data-rjs="images/logo@2x.png" class="logo-dark" alt="Pofo">`<br/>
r: `<%= image_tag "pofo/logo.png", 'data-rjs': image_path('pofo/logo@2x.png'), class: "logo-dark", alt: "Pofo" %>`
```

```html+erb
h: `<a href="index.html"><img class="footer-logo" src="images/logo-white.png" data-rjs="images/logo-white@2x.png" alt="Pofo"></a>`<br/>
r: `<a href="index.html"><<%= image_tag "pofo/logo-white.png", class: "footer-logo", 'data-rjs': image_path('pofo/logo-white@2x.png'), alt: "Pofo" %></a>`
```

```html+erb
h: `<img src="images/services/main-fbrowser.png" style="position: absolute; top: 0; left: 0;" data-animate="fadeInUp" data-delay="100" alt="Chrome">`
r1: `<%= image_tag "services/main-fbrowser.png", style: "position: absolute; top: 0; left: 0;", 'data-animate'=> "fadeInUp", 'data-delay'=> "100", alt: "Chrome" %>`
r2: `<%= image_tag "services/main-fbrowser.png", style: "position: absolute; top: 0; left: 0;", 'data-animate': "fadeInUp", 'data-delay': "100", alt: "Chrome" %>`
r3: `<%= image_tag "services/main-fbrowser.png", style: "position: absolute; top: 0; left: 0;", data: {animate: "fadeInUp", delay: "100"}, alt: "Chrome" %>`
```

> Ruby non accetta il dash `-` direttamente nei nomi dei simboli. 
> Non possiamo usare `:vari-able` ma dobbiamo usare `:'vari-able'`.

Vediamo tutti i modi di usare il dash `-` nei nomi delle variabili:

usando stringa:

- `a-b => "value" # error`
- `"a-b" => "value" # ok`
- `'a-b' => "value" # ok`

usando simboli:

- `:a-b => "value" # error`
- `:"a-b" => "value" # ok`
- `:'a-b' => "value" # ok`
- `a-b: "value" # error`
- `"a-b": "value" # error`
- `'a-b': "value" # ok (con nuova sintassi da ruby 1.9)`

Oppure per i puristi:

`<%= link_to "Linkname", link_path, {data: {something: 'value1', somethingelse: 'value2'}} %>`
Genera il seguente codice html:
`<a href="/link" data-something='value1' data-somethingelse='value2'>Linkname</a>`


> Curiosità:<br/>
> il codice `<%= image_tag asset_path(“work-masonry-2.jpg”) %>` usa `asset_path` che non mi è chiaro a cosa serva ?!?



## Opzione immagini "segnaposto"

Volendo possiamo mettere dei rettangoli grigi come immagini presi dal sito *placehold.it*

Esempio

http://placehold.it/149x149
http://placehold.it/1920x1100

```html
da
  <%= image_tag "pofo/web-avatar-lady-red-hair.jpg", alt: "", class: "border-radius-100" %>
a
  <%= image_tag "pofo/web-avatar-lady-red-hair.png", alt: "", class: "rounded-circle" %>
  <!--<img src="http://placehold.it/149x149" alt="" class="rounded-circle">-->
```

```html
  <section class="wow fadeIn parallax" data-stellar-background-ratio="0.5" style="background-image:url('<%= image_path('http://placehold.it/1920x1100') %>');">
OPPURE
  <section class="wow fadeIn parallax" data-stellar-background-ratio="0.5" style="background-image:url('<%= image_path('pofo/parallax-bg33.jpg') %>');">
```



## Adattiamo le chiamate alle immagini sulla view

Impostiamo gli helpers per puntare all'asset_pipeline

Abbiamo già copiato le immagini nei capitoli precedenti.
Adesso reimpostiamo i puntamenti in modo da poterle visualizzare sulle view.

> Per velocizzare la ricerca possiamo fare un "find" per le seguenti parole: "image", "png", "jpg"

Cambiamo le chiamate alle immagini dallo standard html a quello con gli helpers Rails.
Adattiamo da codice HTML `h•` a codice Rails `r•`.


### Favicon

Impostiamo il favicon che si visualizza sul tab del browser

[Codice 01 - ...views/mockups/eduport_index.html.erb - linea: 75]()

```html
  <!-- favicon -->
	<!--<link rel="shortcut icon" href="assets/images/favicon.ico">-->
  <link rel="shortcut icon" href="<%=image_path('eduport/favicon.ico')%>">
```


### NAVIGATION MENU (navbar)

Immagine 1: il logo "Eduport" in alto a sinistra nel menu.

[...continua - line: 109]()

```html
h• <img class="light-mode-item navbar-brand-item" src="assets/images/logo.svg" alt="logo">
   <img class="dark-mode-item navbar-brand-item" src="assets/images/logo-light.svg" alt="logo">
r• <%= image_tag "edu/logo.svg", class: "light-mode-item navbar-brand-item", alt: "logo" %>
   <%= image_tag "edu/logo-light.svg", class: "dark-mode-item navbar-brand-item", alt: "logo" %>
```

[esempio dal tema pofo. solo a SCOPO DIDATTICO]()

```html+erb
  <a href="index.html" title="Pofo" class="logo"><%= image_tag "pofo/logo.png", 'data-rjs': image_path('pofo/logo@2x.png'), class: "logo-dark", alt: "Pofo" %><%= image_tag "pofo/logo-white.png", 'data-rjs': image_path('pofo/logo-white@2x.png'), alt: "Pofo", class: "logo-light default" %></a>
```


### Sottomenu category -> marketing -> colonna Degree

Immagine 1: logo università *American Century*

[...continua - line: 190]()

```html+erb
h• <img src="assets/images/client/uni-logo-01.svg" class="icon-md" alt="">
r• <%= image_tag "eduport/client/uni-logo-01.svg", class: "icon-md", alt: "" %>
```

Immagine 2: logo università *Indiana college*

[...continua - line:199]()

```html+erb
h• <img src="assets/images/client/uni-logo-02.svg" class="icon-md" alt="">
r• <%= image_tag "eduport/client/uni-logo-02.svg", class: "icon-md", alt: "" %>
```

Immagine 3: logo università *College of south Florida*

[...continua - line:208]()

```html+erb
h• <img src="assets/images/client/uni-logo-03.svg" class="icon-md" alt="">
r• <%= image_tag "edu/client/uni-logo-03.svg", class: "icon-md", alt: "" %>
```

Immagine 4: logo università *Andeerson Campus*

[...continua - line:208]()

```html+erb
h• <img src="assets/images/client/uni-logo-01.svg" class="icon-md" alt="">
r• <%= image_tag "eduport/client/uni-logo-01.svg", class: "icon-md", alt: "" %>
```

Immagine 5: logo università *University of South California*

[...continua - linea: 208]()

```html+erb
h• <img src="assets/images/client/uni-logo-04.svg" class="icon-md" alt="">
r• <%= image_tag "eduport/client/uni-logo-04.svg", class: "icon-md", alt: "" %>
```


### Sottomenu category -> marketing -> bottom banner Advertisement

Immagine 1: Background pattern 05 (invece di avere lo sfondo di un blu omogeneo si attiva un patern di sfere e figure geometriche)

[...continua - linea: 277]()

```html+erb
h• <div class="card bg-blue rounded-0 rounded-bottom p-3 position-relative overflow-hidden" style="background:url(assets/images/pattern/05.png) no-repeat center center; background-size:cover;">
r• <div class="card bg-blue rounded-0 rounded-bottom p-3 position-relative overflow-hidden" style="background:url(<%= image_path('eduport/pattern/05.png') %>) no-repeat center center; background-size:cover;">
```


### sotto-menu *Megamenu* -> colonna *Download Eduport*

Immagine 1: donna con cellulare in download

[codice n/a - ...continua - linea: 606]()

```html+erb
h• <img src="assets/images/element/14.svg" alt="">
r• <%= image_tag "eduport/element/14.svg", alt: "" %>
```

Immagine 2: icona Google Play

[codice n/a - ...continua - linea: 615]()

```html+erb
h• <a href="#"> <img src="assets/images/client/google-play.svg" class="btn-transition" alt="google-store"> </a>
r• <a href="#"> <%= image_tag "eduport/client/google-play.svg", class: "btn-transition", alt: "google-store" %> </a>
```

Immagine 3: icona Apple store

[codice n/a - ...continua - linea: 619]()

```html+erb
h• <a href="#"> <img src="assets/images/client/app-store.svg" class="btn-transition" alt="app-store"> </a>
r• <a href="#"> <%= image_tag "eduport/client/app-store.svg", class: "btn-transition", alt: "app-store" %> </a>
```

Immagine 4: avatar su bottom banner

[codice n/a - ...continua - linea: 631]()

```html+erb
h• <img class="avatar-img rounded-circle" src="assets/images/avatar/09.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/09.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
```


### Ultimo sotto-menu tutto a destra

Immagine 1: avatar nell'ultimo menu tutto a destra (al posto del nome del menu)

[codice n/a - ...continua - linea: 702]()

```html+erb
h• <img class="avatar-img rounded-circle" src="assets/images/avatar/01.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/01.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
```


Immagine 2: avatar "dentro" l'ultimo menu tutto a destra. Si vede aprendolo.

[codice n/a - ...continua - linea: 712]()

```html+erb
h• <img class="avatar-img rounded-circle shadow" src="assets/images/avatar/01.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/01.jpg", class: "avatar-img rounded-circle shadow", alt: "avatar" %>
```


### MAIN CONTENT START

Immagine 1: "icona atomo" alla destra del titolo "Limitless learning at your fingertips".

[codice n/a - ...continua - line:974]()

```html+erb
h• <img src="assets/images/client/science.svg" alt="Icon">
r• <%= image_tag "eduport/client/science.svg", alt: "Icon" %>
```


Immagine 2: "icona angular" alla destra del titolo "Limitless learning at your fingertips".

[Codice n/a - ...continua - linea: 817]()

```html+erb
h• <img src="assets/images/client/angular.svg" alt="Icon">
r• <%= image_tag "eduport/client/angular.svg", alt: "Icon" %>
```

Immagine 3: "icona figma" alla destra del titolo "Limitless learning at your fingertips".

[Codice n/a - ...continua - linea: 982]()

```html+erb
h• <img src="assets/images/client/figma.svg" alt="Icon">
r• <%= image_tag "eduport/client/figma.svg", alt: "Icon" %>
```

Immagine 4: background verde a strisce gialle dentro il rettangolo con i visi degli studenti.

[Codice n/a - ...continua - linea: 1002]()

```html+erb
h• <div class="p-3 bg-success d-inline-block rounded-4 shadow-lg position-absolute top-50 end-0 translate-middle-y mt-n7 z-index-1 d-none d-md-block" style="background:url(assets/images/pattern/01.png) no-repeat center center; background-size:cover;">
r• <div class="p-3 bg-success d-inline-block rounded-4 shadow-lg position-absolute top-50 end-0 translate-middle-y mt-n7 z-index-1 d-none d-md-block" style="background:url(<%= image_path('eduport/pattern/01.png') %>) no-repeat center center; background-size:cover;">
```

Immagine 5: "viso alunno" dentro il rettangolo con i visi degli studenti.

[Codice n/a - ...continua - linea: 1008]()

```html+erb
h• <img class="avatar-img rounded-circle border-white" src="assets/images/avatar/01.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/01.jpg", class: "avatar-img rounded-circle border-white", alt: "avatar" %>
```

Immagine 6: "viso alunno" dentro il rettangolo con i visi degli studenti.

[Codice n/a - ...continua - linea: 1012]()

```html+erb
h• <img class="avatar-img rounded-circle border-white" src="assets/images/avatar/02.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/02.jpg", class: "avatar-img rounded-circle border-white", alt: "avatar" %>
```

Immagine 7: "viso alunno" dentro il rettangolo con i visi degli studenti.

[Codice n/a - ...continua - linea: 1016]()

```html+erb
h• <img class="avatar-img rounded-circle border-white" src="assets/images/avatar/03.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/03.jpg", class: "avatar-img rounded-circle border-white", alt: "avatar" %>
```		

Immagine 8: "viso alunno" dentro il rettangolo con i visi degli studenti.

[Codice n/a - ...continua - linea: 1020]()

```html+erb
h• <img class="avatar-img rounded-circle border-white" src="assets/images/avatar/04.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/04.jpg", class: "avatar-img rounded-circle border-white", alt: "avatar" %>
```

Immagine 9: "alunno grande con cappello giallo".

[Codice n/a - ...continua - linea: 1031]()

```html+erb
h• <img src="assets/images/element/07.png" alt="">
r• <%= image_tag "edu/element/07.png", alt: "" %>
```


### Most Popular Courses

#### tab WEB DESIGN

Immagine 1: corso con rubino giallo.

[Codice n/a - ...continua - linea: 1152]()

```html+erb
h• <img src="assets/images/courses/4by3/08.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/08.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 2: corso con logo photoshop (PS).

[Codice n/a - ...continua - linea: 1190]()

```html+erb
h• <img src="assets/images/courses/4by3/02.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/02.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 3: corso con logo figma (i pallini colorati).

[Codice n/a - ...continua - linea: 1227]()

```html+erb
h• <img src="assets/images/courses/4by3/03.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/03.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 4: corso con logo react (atomo azzurro).

[Codice n/a - ...continua - linea: 1264]()

```html+erb
h• <img src="assets/images/courses/4by3/07.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/07.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 5: corso con logo html5 (scudo con lettera H).

[Codice n/a - ...continua - linea: 1301]()

```html+erb
h• <img src="assets/images/courses/4by3/11.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/11.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 6: corso con logo CSS (scudo con numero 3).

[Codice n/a - ...continua - linea: 1338]()

```html+erb
h• <img src="assets/images/courses/4by3/12.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/12.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 7: corso con logo invision (lettere in).

[Codice n/a - ...continua - linea: 1375]()

```html+erb
h• <img src="assets/images/courses/4by3/04.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/04.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 8: corso con logo JavaScript (lettere JS).

[Codice n/a - ...continua - linea: 1412]()

```html+erb
h• <img src="assets/images/courses/4by3/09.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/09.jpg", class: "card-img-top", alt: "course image" %>
```

#### tab DEVELOPMENT

Immagine 1: corso con logo Pyton.

[Codice n/a - ...continua - linea: 1455]()

```html+erb
h• <img src="assets/images/courses/4by3/05.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/05.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 2: corso con logo Angular.

[Codice n/a - ...continua - linea: 1492]()

```html+erb
h• <img src="assets/images/courses/4by3/06.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/06.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 3: corso con logo React.

[Codice n/a - ...continua - linea: 1529]()

```html+erb
h• <img src="assets/images/courses/4by3/07.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/07.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 4: corso con logo JavaScript.

[Codice n/a - ...continua - linea: 1566]()

```html+erb
h• <img src="assets/images/courses/4by3/09.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/09.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 5: corso con logo Bootstrap.

[Codice n/a - ...continua - linea: 1603]()

```html+erb
h• <img src="assets/images/courses/4by3/10.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/10.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 6: corso con logo PHP.

[Codice n/a - ...continua - linea: 1640]()

```html+erb
h• <img src="assets/images/courses/4by3/13.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/13.jpg", class: "card-img-top", alt: "course image" %>
```


#### tab GRAFIC DESIGN

Immagine 1: corso con logo rubino giallo.

[Codice n/a - ...continua - linea: 1683]()

```html+erb
h• <img src="assets/images/courses/4by3/08.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/08.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 2: corso con logo invision.

[Codice n/a - ...continua - linea: 1720]()

```html+erb
h• <img src="assets/images/courses/4by3/04.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/04.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 3: corso con logo PhotoShop.

[Codice n/a - ...continua - linea: 1757]()

```html+erb
h• <img src="assets/images/courses/4by3/02.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/02.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 4: corso con logo figma.

[Codice n/a - ...continua - linea: 1794]()

```html+erb
h• <img src="assets/images/courses/4by3/03.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/03.jpg", class: "card-img-top", alt: "course image" %>
```


#### tab MARKETING

Immagine 1: corso con logo Digital Marketing.

[Codice n/a - ...continua - linea: 1837]()

```html+erb
h• <img src="assets/images/courses/4by3/01.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/01.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 2: corso con logo App Designer.

[Codice n/a - ...continua - linea: 1874]()

```html+erb
h• <img src="assets/images/courses/4by3/08.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/08.jpg", class: "card-img-top", alt: "course image" %>
```


#### tab FINANCE

Immagine 1: corso con logo invision.

[Codice n/a - ...continua - linea: 1917]()

```html+erb
h• <img src="assets/images/courses/4by3/08.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/08.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 2: corso con logo JavaScript.

[Codice n/a - ...continua - linea: 1954]()

```html+erb
h• <img src="assets/images/courses/4by3/09.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/09.jpg", class: "card-img-top", alt: "course image" %>
```


### Our Trending Courses

Immagine 1: Trending Courses (nello "slider") con foto.

[Codice n/a - ...continua - linea: 2063]()

```html+erb
h• <img src="assets/images/courses/4by3/14.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/14.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 2: Trending Courses (nello "slider") avatar.

[Codice n/a - ...continua - linea: 2104]()

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/10.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/10.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```									

Immagine 3: Trending Courses (nello "slider") con foto.

[Codice n/a - ...continua - linea: 2124]()

```html+erb
h• <img src="assets/images/courses/4by3/15.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/15.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 4: Trending Courses (nello "slider") avatar.

[Codice n/a - ...continua - linea: 2163]()

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/04.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/04.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```									

Immagine 5: Trending Courses (nello "slider") con foto.

[Codice n/a - ...continua - linea: 2183]()

```html+erb
h• <img src="assets/images/courses/4by3/17.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/17.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 6: Trending Courses (nello "slider") avatar.

[Codice n/a - ...continua - linea: 2222]()

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/09.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/09.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```

Immagine 7: Trending Courses (nello "slider") con foto.

[Codice n/a - ...continua - linea: 2242]()

```html+erb
h• <img src="assets/images/courses/4by3/16.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "eduport/courses/4by3/16.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 8: Trending Courses (nello "slider") avatar.

[Codice n/a - ...continua - linea: 2281]()

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/01.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/01.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```


### Some valuable feedback from our students

Immagine 1: avatar nel commento Carolyn Ortiz.

[Codice n/a - ...continua - linea: 2324]()

```html+erb
h• <img class="avatar-img rounded-circle" src="assets/images/avatar/01.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/01.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
```

Immagine 2: avatar nel rettangolo "100+ Verified Mentors".

[Codice n/a - ...continua - linea: 2361]()

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/09.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/09.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```

Immagine 3: avatar nel rettangolo "100+ Verified Mentors".

[Codice n/a - ...continua - linea: 2375]()

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/04.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/04.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```

Immagine 4: avatar nel rettangolo "100+ Verified Mentors".

[Codice n/a - ...continua - linea: 2389]()

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/02.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/02.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```

Immagine 5: background blu a strisce bianche dentro il rettangolo con voto "4.5/5.0".

[Codice n/a - ...continua - linea: 2456]()

```html+erb
h• <div class="p-3 bg-primary d-inline-block rounded-4 shadow-lg text-center" style="background:url(assets/images/pattern/02.png) no-repeat center center; background-size:cover;">
r• <div class="p-3 bg-primary d-inline-block rounded-4 shadow-lg text-center" style="background:url(<%= image_path('eduport/pattern/02.png') %>) no-repeat center center; background-size:cover;">

```

Immagine 6: avatar nel commento Dennis Barrett.

[Codice n/a - ...continua - linea: 2477]()

```html+erb
h• <img class="avatar-img rounded-circle" src="assets/images/avatar/03.jpg" alt="avatar">
r• <%= image_tag "eduport/avatar/03.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
```


### Footer

Immagine 1: il logo "Eduport" nel footer.

[Codice n/a - ...continua - linea: 2258]()

```html+erb
h• <img class="light-mode-item h-40px" src="assets/images/logo.svg" alt="logo">
<img class="dark-mode-item h-40px" src="assets/images/logo-light.svg" alt="logo">
r• <%= image_tag "eduport/logo.svg", class: "light-mode-item h-40px", alt: "logo" %>
<%= image_tag "eduport/logo-light.svg", class: "dark-mode-item h-40px", alt: "logo" %>
```

Immagine 2: "icona Google play" nel footer.

[Codice n/a - ...continua - linea: 2597]()

```html+erb
h• <a href="#"> <img src="assets/images/client/google-play.svg" alt="google-store"> </a>
r• <a href="#"> <%= image_tag "eduport/client/google-play.svg", alt: "google-store" %> </a>
```

Immagine 3: "icona Apple store" nel footer.

[Codice n/a - ...continua - linea: 2602]()

```html+erb
h• <a href="#"> <img src="assets/images/client/app-store.svg" alt="app-store"> </a>
r• <a href="#"> <%= image_tag "eduport/client/app-store.svg", alt: "app-store" %> </a>
```


#### Language

Immagine 4: "Language switcher English" nel footer.

[Codice n/a - ...continua - linea: 2629]()

```html+erb
h• <li><a class="dropdown-item me-4" href="#"><img class="fa-fw me-2" src="assets/images/flags/uk.svg" alt="">English</a></li>
r• <li><a class="dropdown-item me-4" href="#"><%= image_tag "eduport/flags/uk.svg", class: "fa-fw me-2", alt: "" %>English</a></li>
```

Immagine 41: "Language switcher German" nel footer.

[Codice n/a - ...continua - linea: 2631]()

```html+erb
h• <li><a class="dropdown-item me-4" href="#"><img class="fa-fw me-2" src="assets/images/flags/gr.svg" alt="">German</a></li>
r• <li><a class="dropdown-item me-4" href="#"><%= image_tag "eduport/flags/gr.svg", class: "fa-fw me-2", alt: "" %>German</a></li>
```

Immagine 42: "Language switcher French" nel footer.

[Codice n/a - ...continua - linea: 2633]()

```html+erb
h• <li><a class="dropdown-item me-4" href="#"><img class="fa-fw me-2" src="assets/images/flags/sp.svg" alt="">French</a></li>
r• <li><a class="dropdown-item me-4" href="#"><%= image_tag "eduport/flags/sp.svg", class: "fa-fw me-2", alt: "" %>French</a></li>
```



## Verifichiamo preview

Verifichiamo preview

```bash
$ ./bin/dev
```

> Ex $ rails s -b 192.168.64.3

Andiamo con il browser sull'URL:

- http://192.168.64.3:3000


![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_fig01-index1.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_fig02-index2.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_fig03-index3.png)

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_fig04-index4.png)

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_fig05-index5.png)

![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_fig06-index6.png)

![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_fig07-index7.png)

![fig08](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_fig08-index8.png)

![fig09](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_fig09-index9.png)

![fig10](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_fig10-index10.png)



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

Su render.com è automaticamente attivato il deploy.
(altrimenti lo forziamo manualmente scegliendo "da ultimo commit".)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-index-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_00-theme_images-it.md)
