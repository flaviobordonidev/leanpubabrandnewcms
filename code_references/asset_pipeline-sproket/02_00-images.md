# <a name="top"></a> Cap *asset_pipeline*.2 - Gestiamo le immagini



## Risorse interne

- [15-theme-edu/02-mockups-first-page/03_00-theme_images]()
- [11-theme-pofo/02-mockups-blog-clean-full-width/05_00-images_implement]()



## Risorse web

- [how-to-escape-a-dash-in-a-ruby-symbol](https://stackoverflow.com/questions/8482024/how-to-escape-a-dash-in-a-ruby-symbol)
- [ruby-1-9-hash-with-a-dash-in-a-key](https://stackoverflow.com/questions/2134702/ruby-1-9-hash-with-a-dash-in-a-key)





## Gli helpers per puntare all'asset_pipeline

Su rails per richiamare le immagini che sono sull'asset_pipeline si usano fondamentalmente:

```html+erb
● <%= image_tag "...", alt: "Canvas Logo" %>
● <%= image_path('...') %>
```

esempi da codice HTML `h:` a codice Rails `r:`.

```html+erb
h: <img src="images/logo.png" alt="Canvas Logo">
r: <%= image_tag "logo.png", alt: "Canvas Logo" %>
```

```html+erb
h: <img src="assets/images/client/uni-logo-01.svg" class="icon-md" alt="">
r: <%= image_tag "client/uni-logo-01.svg", class: "icon-md", alt: "" %>
```

```html+erb
h: `<div class="swiper-slide dark" style="background-image: url('images/slider/swiper/1.jpg');">`<br/>
r: `<div class="swiper-slide dark" style="background-image: url(<%= image_path('slider/swiper/1.jpg') %>);">`
```

```html+erb
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

- `{a: {b: "value"}} # ok`

Quest'ultimo è comodo quando si hanno più variabili:

`<%= link_to "Link", link_path, {data: {something: 'value1', somethingelse: 'value2'}} %>` <br/>
Questo genera il seguente codice html: <br/>
`<a href="/link" data-something='value1' data-somethingelse='value2'>Link</a>`

Tra i metodi sopra ne selezioniamo due da usare con 3 variabili:

- `{a: {b: "value1", c: "value2", d: "value3"}} # ok`
- `'a-b': "value1", 'a-c': "value2", 'a-d': "value3" # ok (con nuova sintassi da ruby 1.9)`


> Curiosità:<br/>
> il codice `<%= image_tag asset_path(“work-masonry-2.jpg”) %>` usa `asset_path` che non mi è chiaro a cosa serva ?!?
