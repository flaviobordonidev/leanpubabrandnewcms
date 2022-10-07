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

***codice n/a - ...continua - line:817***

```html+erb
h• <img src="assets/images/client/angular.svg" alt="Icon">
r• <%= image_tag "edu/client/angular.svg", alt: "Icon" %>
```

Immagine 3: "icona figma" alla destra del titolo "Limitless learning at your fingertips".

***codice n/a - ...continua - line:820***

```html+erb
h• <img src="assets/images/client/figma.svg" alt="Icon">
r• <%= image_tag "edu/client/figma.svg", alt: "Icon" %>
```

Immagine 4: background verde a strisce gialle dentro il rettangolo con i visi degli studenti.

***codice n/a - ...continua - line:838***

```html+erb
h• <div class="p-3 bg-success d-inline-block rounded-4 shadow-lg position-absolute top-50 end-0 translate-middle-y mt-n7 z-index-1 d-none d-md-block" style="background:url(assets/images/pattern/01.png) no-repeat center center; background-size:cover;">
r• <div class="p-3 bg-success d-inline-block rounded-4 shadow-lg position-absolute top-50 end-0 translate-middle-y mt-n7 z-index-1 d-none d-md-block" style="background:url(<%= image_path('edu/pattern/01.png') %>) no-repeat center center; background-size:cover;">
```

Immagine 5: "viso alunno" dentro il rettangolo con i visi degli studenti.

***codice n/a - ...continua - line:843***

```html+erb
h• <img class="avatar-img rounded-circle border-white" src="assets/images/avatar/01.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/01.jpg", class: "avatar-img rounded-circle border-white", alt: "avatar" %>
```

Immagine 6: "viso alunno" dentro il rettangolo con i visi degli studenti.

***codice n/a - ...continua - line:846***

```html+erb
h• <img class="avatar-img rounded-circle border-white" src="assets/images/avatar/02.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/02.jpg", class: "avatar-img rounded-circle border-white", alt: "avatar" %>
```

Immagine 7: "viso alunno" dentro il rettangolo con i visi degli studenti.

***codice n/a - ...continua - line:849***

```html+erb
h• <img class="avatar-img rounded-circle border-white" src="assets/images/avatar/03.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/03.jpg", class: "avatar-img rounded-circle border-white", alt: "avatar" %>
```		

Immagine 8: "viso alunno" dentro il rettangolo con i visi degli studenti.

***codice n/a - ...continua - line:852***

```html+erb
h• <img class="avatar-img rounded-circle border-white" src="assets/images/avatar/04.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/04.jpg", class: "avatar-img rounded-circle border-white", alt: "avatar" %>
```

Immagine 9: "alunno grande con cappello giallo".

***codice n/a - ...continua - line:863***

```html+erb
h• <img src="assets/images/element/07.png" alt="">
r• <%= image_tag "edu/element/07.png", alt: "" %>
```


- - - -

***POPULAR COURSES***

Immagine 1: corso con rubino giallo.

***codice n/a - ...continua - line:984***

```html+erb
h• <img src="assets/images/courses/4by3/08.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/08.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 2: corso con logo photoshop (PS).

***codice n/a - ...continua - line:1021***

```html+erb
h• <img src="assets/images/courses/4by3/08.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/08.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 3: corso con logo figma (i pallini colorati).

***codice n/a - ...continua - line:1057***

```html+erb
h• <img src="assets/images/courses/4by3/03.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/03.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 4: corso con logo react (atomo azzurro).

***codice n/a - ...continua - line:1093***

```html+erb
h• <img src="assets/images/courses/4by3/07.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/07.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 5: corso con logo html5 (scudo con lettera H).

***codice n/a - ...continua - line:1129***

```html+erb
h• <img src="assets/images/courses/4by3/11.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/11.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 6: corso con logo CSS (scudo con numero 3).

***codice n/a - ...continua - line:1165***

```html+erb
h• <img src="assets/images/courses/4by3/12.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/12.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 7: corso con logo invision (lettere in).

***codice n/a - ...continua - line:1201***

```html+erb
h• <img src="assets/images/courses/4by3/04.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/04.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 8: corso con logo JavaScript (lettere JS).

***codice n/a - ...continua - line:1201***

```html+erb
h• <img src="assets/images/courses/4by3/09.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/09.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 9: corso con logo Pyton.

***codice n/a - ...continua - line:1279***

```html+erb
h• <img src="assets/images/courses/4by3/05.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/05.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 10: corso con logo Angular.

***codice n/a - ...continua - line:1315***

```html+erb
h• <img src="assets/images/courses/4by3/06.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/06.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 11: corso con logo React.

***codice n/a - ...continua - line:1351***

```html+erb
h• <img src="assets/images/courses/4by3/06.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/06.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 12: corso con logo JavaScript.

***codice n/a - ...continua - line:1387***

```html+erb
h• <img src="assets/images/courses/4by3/09.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/09.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 13: corso con logo Bootstrap.

***codice n/a - ...continua - line:1423***

```html+erb
h• <img src="assets/images/courses/4by3/10.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/10.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 14: corso con logo PHP.

***codice n/a - ...continua - line:1423***

```html+erb
h• <img src="assets/images/courses/4by3/13.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/13.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 15: corso con logo rubino giallo.

***codice n/a - ...continua - line:1501***

```html+erb
h• <img src="assets/images/courses/4by3/08.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/08.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 16: corso con logo invision.

***codice n/a - ...continua - line:1537***

```html+erb
h• <img src="assets/images/courses/4by3/04.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/04.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 17: corso con logo PhotoShop.

***codice n/a - ...continua - line:1573***

```html+erb
h• <img src="assets/images/courses/4by3/02.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/02.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 18: corso con logo figma.

***codice n/a - ...continua - line:1609***

```html+erb
h• <img src="assets/images/courses/4by3/03.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/03.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 19: corso con logo Digital Marketing.

***codice n/a - ...continua - line:1651***

```html+erb
h• <img src="assets/images/courses/4by3/01.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/01.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 20: corso con logo App Designer.

***codice n/a - ...continua - line:1687***

```html+erb
h• <img src="assets/images/courses/4by3/08.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/08.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 21: corso con logo invision.

***codice n/a - ...continua - line:1729***

```html+erb
h• <img src="assets/images/courses/4by3/08.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/08.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 22: corso con logo JavaScript.

***codice n/a - ...continua - line:1765***

```html+erb
h• <img src="assets/images/courses/4by3/09.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/09.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 23: Trending Courses (nello "slider") con foto.

***codice n/a - ...continua - line:1873***

```html+erb
h• <img src="assets/images/courses/4by3/14.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/14.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 24: Trending Courses (nello "slider") avatar.

***codice n/a - ...continua - line:1913***

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/10.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/10.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```									

Immagine 25: Trending Courses (nello "slider") con foto.

***codice n/a - ...continua - line:1932***

```html+erb
h• <img src="assets/images/courses/4by3/15.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/15.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 26: Trending Courses (nello "slider") avatar.

***codice n/a - ...continua - line:1970***

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/10.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/10.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```									

Immagine 27: Trending Courses (nello "slider") con foto.

***codice n/a - ...continua - line:1989***

```html+erb
h• <img src="assets/images/courses/4by3/17.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/17.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 28: Trending Courses (nello "slider") avatar.

***codice n/a - ...continua - line:2027***

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/10.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/10.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```									

Immagine 29: Trending Courses (nello "slider") con foto.

***codice n/a - ...continua - line:2046***

```html+erb
h• <img src="assets/images/courses/4by3/16.jpg" class="card-img-top" alt="course image">
r• <%= image_tag "edu/courses/4by3/16.jpg", class: "card-img-top", alt: "course image" %>
```

Immagine 30: Trending Courses (nello "slider") avatar.

***codice n/a - ...continua - line:2084***

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/01.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/01.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```

Immagine 31: avatar nel commento Carolyn Ortiz.

***codice n/a - ...continua - line:2126***

```html+erb
h• <img class="avatar-img rounded-circle" src="assets/images/avatar/01.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/01.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
```

Immagine 32: avatar nel rettangolo "100+ Verified Mentors".

***codice n/a - ...continua - line:2126***

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/09.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/09.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```

Immagine 33: avatar nel rettangolo "100+ Verified Mentors".

***codice n/a - ...continua - line:2175***

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/04.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/04.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```

Immagine 34: avatar nel rettangolo "100+ Verified Mentors".

***codice n/a - ...continua - line:2188***

```html+erb
h• <img class="avatar-img rounded-1" src="assets/images/avatar/02.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/02.jpg", class: "avatar-img rounded-1", alt: "avatar" %>
```

Immagine 35: background blu a strisce bianche dentro il rettangolo con voto "4.5/5.0".

***codice n/a - ...continua - line:2254***

```html+erb
h• <div class="p-3 bg-primary d-inline-block rounded-4 shadow-lg text-center" style="background:url(assets/images/pattern/02.png) no-repeat center center; background-size:cover;">
r• <div class="p-3 bg-primary d-inline-block rounded-4 shadow-lg text-center" style="background:url(<%= image_path('edu/pattern/02.png') %>) no-repeat center center; background-size:cover;">

```

Immagine 36: avatar nel commento Dennis Barrett.

***codice n/a - ...continua - line:2274***

```html+erb
h• <img class="avatar-img rounded-circle" src="assets/images/avatar/03.jpg" alt="avatar">
r• <%= image_tag "edu/avatar/03.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
```

Immagine 37: il logo "Eduport" nel footer.

***codice n/a - ...views/mockups/edu_index.html.erb - line:2324***

```html+erb
h• <img class="light-mode-item h-40px" src="assets/images/logo.svg" alt="logo">
<img class="dark-mode-item h-40px" src="assets/images/logo-light.svg" alt="logo">
r• <%= image_tag "edu/logo.svg", class: "light-mode-item h-40px", alt: "logo" %>
<%= image_tag "edu/logo-light.svg", class: "dark-mode-item h-40px", alt: "logo" %>
```

Immagine 38: "icona Google play" nel footer.

***codice n/a - ...continua - line:2391***

```html+erb
h• <a href="#"> <img src="assets/images/client/google-play.svg" alt="google-store"> </a>
r• <a href="#"> <%= image_tag "edu/client/google-play.svg", alt: "google-store" %> </a>
```

Immagine 39: "icona Apple store" nel footer.

***codice n/a - ...continua - line:2395***

```html+erb
h• <a href="#"> <img src="assets/images/client/app-store.svg" alt="app-store"> </a>
r• <a href="#"> <%= image_tag "edu/client/app-store.svg", alt: "app-store" %> </a>
```

Immagine 40: "Language switcher English" nel footer.

***codice n/a - ...continua - line:2421***

```html+erb
h• <li><a class="dropdown-item me-4" href="#"><img class="fa-fw me-2" src="assets/images/flags/uk.svg" alt="">English</a></li>
r• <li><a class="dropdown-item me-4" href="#"><%= image_tag "edu/flags/uk.svg", class: "fa-fw me-2", alt: "" %>English</a></li>
```

Immagine 41: "Language switcher German" nel footer.

***codice n/a - ...continua - line:2421***

```html+erb
h• <li><a class="dropdown-item me-4" href="#"><img class="fa-fw me-2" src="assets/images/flags/gr.svg" alt="">German</a></li>
r• <li><a class="dropdown-item me-4" href="#"><%= image_tag "edu/flags/uk.svg", class: "fa-fw me-2", alt: "" %>German</a></li>
```

Immagine 42: "Language switcher French" nel footer.

***codice n/a - ...continua - line:2421***

```html+erb
h• <li><a class="dropdown-item me-4" href="#"><img class="fa-fw me-2" src="assets/images/flags/sp.svg" alt="">French</a></li>
r• <li><a class="dropdown-item me-4" href="#"><%= image_tag "edu/flags/sp.svg", class: "fa-fw me-2", alt: "" %>French</a></li>
```



## Verifichiamo preview

Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

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

Eseguiamo il deploy manuale scegliendo "da ultimo commit".



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-index-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/03_00-theme_images-it.md)
