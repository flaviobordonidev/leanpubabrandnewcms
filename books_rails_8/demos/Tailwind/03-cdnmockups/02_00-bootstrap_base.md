# <a name="top"></a> Impostiamo alcune formattazioni base di Bootstrap

Evidenziamo che il framwork caricato tramite CDN non è installato su Ruby on Rails ma è un semplice puntamento ad un server esterno e questo ci permette di fare una pagina usando un framework diverso da quello scelto. In questo caso usaiamo bootstrap invece di Tailwind.

Impostiamo alcune formattazioni base di Bootstrap principalmente per assicurarci che il "caricamento" tramite CDN stia funzionando.

Nei successivi capitoli torniamo invece a lavorare con Tailwind che sarà il framework che più avanti installeremo su Ruby on Rails per la nostra applicazione.


## The Bootstap Hello page

Installiamo bootstrap tramite CDN 

- [Get started with Bootstrap](https://getbootstrap.com/docs/5.3/getting-started/introduction/)

***Codice 01 - .../app/views/cdnmockups/bs_base.html.erb - linea:1***

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
  </head>
  <body>
    <h1>Hello, world!</h1>

    <button type="button" class="btn btn-primary">Primary</button>
    <button type="button" class="btn btn-secondary">Secondary</button>
    <button type="button" class="btn btn-success">Success</button>
    <button type="button" class="btn btn-danger">Danger</button>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
  </body>
</html>
```



## Altri componenti bootstrap

Per vedere altri componenti bootstrap vai a `books_rails_8/demos/Bootstrap`

Lì troverai:
- buttons
- buttons_js_custom_layout
- stimulus

    - [Getting Started with Stimulus in Rails (The Basics)](https://www.youtube.com/watch?v=XlyFLC3YqPw)
      Input con "extractYoutubeId"

    - [Ruby on Rails #66 StimulusJS: Targets, Values, Classes. Build a PRO dropdown](https://www.youtube.com/watch?v=XgHXmZbyLvs)
        Dropdown on hover, on clic, on toggle

- buttons_stimulus
- navbar_js_custom_layout
- navbar_stimulus
- navbar

    seguito https://www.youtube.com/watch?v=h_xmLBxS5SA fino al secondo [21:51]

    adesso cambio su https://www.youtube.com/watch?v=vTut_lQJlFE a partire dal secondo [7:13]

    ```shell
    ❯ rails g stimulus navbar
    ```

    Esempio:

    ```shell
    ❯ rails g stimulus navbar
          create  app/javascript/controllers/navbar_controller.js
    ```

- dark_light_stimulus
 

- [l'alert](https://getbootstrap.com/docs/5.3/components/alerts/)
- [i pulsanti](https://getbootstrap.com/docs/5.3/components/buttons/)
- [la navbar](https://getbootstrap.com/docs/5.3/components/navbar/)



## Risorse esterne

- []()


---
[top](#top) |
[index](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/index.md)
