# <a name="top"></a> Cap 3.10 - Gestiamo le immagini

Questo non è un componente ma è come gestire le immagini con BootStrap.
Partiamo con la visualizzaione di una semplice immagine *jpg*


## Risorse interne

- [code_references/asset_pipeline-sprocket/11_00-image_tag.md]()
- []()



## Risorse esterne

- [sito bootstrap: images](https://getbootstrap.com/docs/5.3/content/images/)

> Ad oggi 20/02/2024 l'ultima versione di bootstrap è la *5.3*.



## Images

Con propshaft non dovremmo più usare gli helpers...

...però se oltre a "propshaft" carichiamo i bundlers (`cssbundling-rails` e `jsbundling-rails`) allora ritorna l'uso degli helpers che usavamo con sprocket. Ad esempio `image_tag` e `image_path`. 

```html+erb
• <%= image_tag "...", alt: "Canvas Logo" %>
• <%= image_path('...') %>
```

Vediamo come visualizzare una semplice immagine *.jpg*.

Copiamo l'immagine `university.jpg` nella cartella `.../app/assets/images/`.

E la visualizziamo nella view `mockups/test_a`.

[Codice 01 - .../app/views/mockups/test_a.html.erb - linea: 40]()

```html+erb
<%= image_tag "university.jpg", alt: "Università" %>
```

Per approfondimenti vedi:

- [code_references/asset_pipeline-sprocket/11_00-image_tag.md]()



## Images con Bootstrap

Documentation and examples for opting images into responsive behavior (so they never become wider than their parent) and add lightweight styles to them—all via classes

- [sito bootstrap: images](https://getbootstrap.com/docs/5.3/content/images/)

> Ad oggi 20/02/2024 l'ultima versione di bootstrap è la *5.3*.

Copiamo l'immagine `university.jpg` nella cartella `.../app/assets/images/`.

> usiamo un'immagine grande per vedere l'utilità dell'aggiunta del responsive.

Aggiungiamo le classi di bootstrap `img-fluid` e `img-thumbnail` per gestire l'immagine.

```html+erb
<div class="container">
  <div class="row">
    <div class="col">
      Qui a fianco l'immagine normale: <%= image_tag "university_big.jpg", alt: "Università" %> fine.
    </div>
  </div>
  <div class="row">
    <div class="col">
      Qui a fianco l'immagine responsive: <%= image_tag "university_big.jpg", class: "img-fluid", alt: "Università" %> fine.
    </div>
  </div>
  <div class="row">
    <div class="col">
      Qui a fianco l'immagine responsive con bordino: <%= image_tag "university_big.jpg", class: "img-thumbnail", alt: "Università" %> fine.
    </div>
  </div>
</div>
```


## Vediamo in preview

in preview funziona.

```bash
$ ./bin/dev
```

> In questo caso funziona anche con `$ rails s -b 192.168.64.4` ma con propshaft è meglio usare `./bin/dev`
