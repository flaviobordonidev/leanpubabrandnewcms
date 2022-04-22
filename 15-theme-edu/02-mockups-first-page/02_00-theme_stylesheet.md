# <a name="top"></a> Cap 2.2 - Attiviamo stile del tema

Importiamo i files stylesheets

Continuiamo con i passaggi per importare il tema Edu sulla nostra app Rails:

6. copiamo i files stylesheets (css, scss) su "assets/stylesheets/edu"
7. copiamo le immagini (png, jpg) su "assets/images/edu"
8. copiamo i files javascripts (js) su "assets/javascripts/edu"
9. su mockups/edu_index_4.html.erb aggiustiamo i "puntamenti" per richiamare stylesheets, images e javascripts.



## Risorse esterne

- [file di esempio preso dal tema Eduport](file:///Users/FB/eduport_v1.2.0/template/index-4.html).
- [indice della documentazione dentro il tema Eduport](file:///Users/FB/eduport_v1.2.0/template/docs/index.html)



## Apriamo il branch

continuiamo con il branch aperto nel capitolo precedente



## Impostiamo gli helpers per puntare all'asset_pipeline

Le chiamate ai files di stylesheet e di javascript sono diverse tra HTML e Rails. Rails usa gli helpers. Adattiamo quindi le chiamate per rispondere alle convenzioni Rails.

Inseriamo gli helpers che puntano all'asset_pipeline sia per stylesheets che javascripts.
Per far questo sostituiamo le chiamate (da -> a):

- `<link rel="stylesheet" href="css/xxx.css" />` <br/>
  -> `<%= stylesheet_link_tag 'pofo/css/xxx', media: 'all', 'data-turbolinks-track': 'reload' %>`
- `<script type="text/javascript" src="js/xxx.js"></script>`  <br/>
  -> `<%= javascript_include_tag 'pofo/js/xxx', 'data-turbolinks-track' => true %>`

Lo facciamo per tutte le chiamate che incontriamo

{id: "11-02-02_01", caption: ".../views/mockups/blog_clean_full_width.html.erb -- codice 01", format: HTML+Mako, line-numbers: true, number-from: 1}
```
        <!-- animation -->
        <%= stylesheet_link_tag 'pofo/css/animate', media: 'all', 'data-turbolinks-track': 'reload' %>
        <!-- bootstrap -->
        <%= stylesheet_link_tag 'pofo/css/bootstrap.min', media: 'all', 'data-turbolinks-track': 'reload' %>
        <!-- et line icon --> 
        <%= stylesheet_link_tag 'pofo/css/et-line-icons', media: 'all', 'data-turbolinks-track': 'reload' %>
        <!-- font-awesome icon -->
        <%#= stylesheet_link_tag 'pofo/css/font-awesome.min', media: 'all', 'data-turbolinks-track': 'reload' %>
        <%= stylesheet_link_tag 'pofo/css/font-awesome-free', media: 'all', 'data-turbolinks-track': 'reload' %>
        <%#= stylesheet_pack_tag 'application_mockup_pofo', media: 'all', 'data-turbolinks-track': 'reload' %><!-- serve per heroku. In locale non serve perché indichiamo lo stile direttamente da "packs/application.js"-->
        <!-- themify icon -->
        <%= stylesheet_link_tag 'pofo/css/themify-icons', media: 'all', 'data-turbolinks-track': 'reload' %>
        <!-- swiper carousel -->
        <%= stylesheet_link_tag 'pofo/css/swiper.min', media: 'all', 'data-turbolinks-track': 'reload' %>
        <!-- justified gallery  -->
        <%= stylesheet_link_tag 'pofo/css/justified-gallery.min', media: 'all', 'data-turbolinks-track': 'reload' %>
        <!-- magnific popup -->
        <%= stylesheet_link_tag 'pofo/css/magnific-popup', media: 'all', 'data-turbolinks-track': 'reload' %>
        <!-- revolution slider -->
        <%#= stylesheet_link_tag 'pofo/revolution/css/settings', media: 'screen', 'data-turbolinks-track': 'reload' %>
        <%#= stylesheet_link_tag 'pofo/revolution/css/layers', media: 'all', 'data-turbolinks-track': 'reload' %>
        <%#= stylesheet_link_tag 'pofo/revolution/css/navigation', media: 'all', 'data-turbolinks-track': 'reload' %>
        <!-- bootsnav -->
        <%= stylesheet_link_tag 'pofo/css/bootsnav', media: 'all', 'data-turbolinks-track': 'reload' %>
        <!-- style -->
        <%= stylesheet_link_tag 'pofo/css/style', media: 'all', 'data-turbolinks-track': 'reload' %>
        <!-- responsive css -->
        <%= stylesheet_link_tag 'pofo/css/responsive', media: 'all', 'data-turbolinks-track': 'reload' %>
```


{caption: ".../views/mockups/blog_clean_full_width.html.erb -- continua", format: HTML+Mako, line-numbers: true, number-from: 1}
```
        <!-- javascript libraries -->
        <%= javascript_include_tag 'pofo/js/jquery', 'data-turbolinks-track' => true %>
        <%= javascript_include_tag 'pofo/js/modernizr', 'data-turbolinks-track' => true %>
        <%= javascript_include_tag 'pofo/js/bootstrap.min', 'data-turbolinks-track' => true %>
        <%= javascript_include_tag 'pofo/js/jquery.easing.1.3', 'data-turbolinks-track' => true %>
        <%= javascript_include_tag 'pofo/js/skrollr.min', 'data-turbolinks-track' => true %>
        <%= javascript_include_tag 'pofo/js/smooth-scroll', 'data-turbolinks-track' => true %>
        <%= javascript_include_tag 'pofo/js/jquery.appear', 'data-turbolinks-track' => true %>
        <!-- menu navigation -->
        <%= javascript_include_tag 'pofo/js/bootsnav.js', 'data-turbolinks-track' => true %>
        <%= javascript_include_tag 'pofo/js/jquery.nav.js', 'data-turbolinks-track' => true %>

        <!-- animation -->
        <%= javascript_include_tag 'pofo/js/wow.min', 'data-turbolinks-track' => true %>
.
.
.
        <!-- setting -->
        <%= javascript_include_tag 'pofo/js/main', 'data-turbolinks-track' => true %>

```

[tutto il codice](#11-02-02_01all)













## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

Andiamo con il browser sull'URL:

- http://192.168.64.3:3000/mockups/edu_index_4

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_fig02-edu_index_4.png)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement Eduport index-4"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku bs:main
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge bs
$ git branch -d bs
```



## Facciamo un backup su Github

```bash
$ git push origin main
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_00-steps.md)
