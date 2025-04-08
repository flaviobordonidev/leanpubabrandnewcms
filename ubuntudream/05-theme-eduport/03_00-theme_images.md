# <a name="top"></a> Cap 4.4 - Attiviamo stylesheet del tema

Non ci resta che rivedere le chiamate alle immagini che ci sono sulla view ed adattarle alle convenzioni dell'asset_pipeline.



# Risorse esterne

- [](https://medium.com/@cindyk09/implementing-boostrap-theme-into-your-rails-app-55bb9085feae)
- [how-to-escape-a-dash-in-a-ruby-symbol](https://stackoverflow.com/questions/8482024/how-to-escape-a-dash-in-a-ruby-symbol)
- [ruby-1-9-hash-with-a-dash-in-a-key](https://stackoverflow.com/questions/2134702/ruby-1-9-hash-with-a-dash-in-a-key)



## Adattiamo le chiamate alle immagini sulla view

Abbiamo già copiato le immagini nei capitoli precedenti.
Adesso reimpostiamo i puntamenti in modo da poterle visualizzare sulle view.



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

***codice n/a - ...views/mockups/edu_index_4.html.erb - line:85***

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

per tutte le altre immagini e approfondimenti vedi:

- []()

Per ubuntudream non ci interessa importare tutte le immagini ma solo vedere che funziona perché così siamo pronti per preparare i mockups per la nostra applicazione ubuntudream.



## Vediamo in preview

in preview funziona.

```bash
$ ./bin/dev
```


## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Optimization for render.com"
```



## Chiudiamo il branch e archiviamo su Github

Se avessimo avuto un branch aperto lo avremmo dovuto chiudere prima del `git push origin main`

```bash
$ git checkout main
$ git merge branch_name
$ git branch -d branch_name
```

Commit all changes and push them to your GitHub repository. 

```shell
$ git push origin main
```

Now your application is ready to be deployed on Render!




## Pubblichiamo su render.com

Di default il processo di pubbliacazione parte in automatico ogni volta che facciamo il `git push` su Github perché abbiamo collegato render.com a Github.

Se per qualche strano motivo non partisse in automatico possiamo farlo manualmente:
Dal nostro Web Service su render.com selezioniamo Manual Deploy -> `Deploy latest commit`.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/04_fig01-deploy_latest_commit.png)

