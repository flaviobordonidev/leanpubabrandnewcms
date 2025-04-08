# <a name="top"></a> Cap 2.2 - inseriamo le immagini

Inseriamo le immagini

> Propedeutico a questa sezione è aver fatto la sezione [code_references/theme-eduport-sproket/01-index]()



## Risorse interne

- [code_references/theme-eduport-sproket/01-index/03_00-theme_images]()



## Adattiamo le chiamate alle immagini sulla view

Abbiamo già copiato le immagini nei capitoli precedenti.
Adesso impostiamo gli helpers dell'asset pipeline in modo da poterle visualizzare sulle view.

> Per velocizzare la ricerca possiamo fare un "find" per le seguenti parole: "image", "png", "jpg"

Cambiamo le chiamate alle immagini dallo standard html a quello con gli helpers Rails.
Adattiamo da codice HTML `h•` a codice Rails `r•`.


### Favicon

Impostiamo il favicon che si visualizza sul tab del browser

[Codice 01 - ...views/mockups/eduport_signin.html.erb - linea: 75]()

```html
  <!-- favicon -->
	<!--<link rel="shortcut icon" href="assets/images/favicon.ico">-->
  <link rel="shortcut icon" href="<%=image_path('eduport/favicon.ico')%>">
```


### SVG

Immagine grande a sinistra con ragazza su scrivania e monitor con prof che spiega

[...continua - linea: 115]()

```html
    <!--<img src="assets/images/element/02.svg" class="mt-5" alt="">-->
    <%= image_tag "eduport/element/02.svg", class: "mt-5", alt: "" %>
```


### Avatar group


[...continua - linea: 121]()

```html
<li class="avatar avatar-sm">
    <!--<img class="avatar-img rounded-circle" src="assets/images/avatar/01.jpg" alt="avatar">-->
    <%= image_tag "eduport/avatar/01.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
</li>
<li class="avatar avatar-sm">
    <!--<img class="avatar-img rounded-circle" src="assets/images/avatar/02.jpg" alt="avatar">-->
    <%= image_tag "eduport/avatar/02.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
</li>
<li class="avatar avatar-sm">
    <!--<img class="avatar-img rounded-circle" src="assets/images/avatar/03.jpg" alt="avatar">-->
    <%= image_tag "eduport/avatar/03.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
</li>
<li class="avatar avatar-sm">
    <!--<img class="avatar-img rounded-circle" src="assets/images/avatar/04.jpg" alt="avatar">-->
    <%= image_tag "eduport/avatar/04.jpg", class: "avatar-img rounded-circle", alt: "avatar" %>
</li>
```
