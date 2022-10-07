# <a name="top"></a> Cap 2.1 - Il tema eduport (su BootStrap via jsbundler)

> ATTENZIONE:
> Molte spiegazioni sono nel progetto *theme-eduport* che è quello che usa *importmap*
>
> Questo progetto è un "copia-incolla" in cui sostituiamo le chiamate a *importmap* con quelle più "tradizionali" di javascript tramite nodejs e l'asset-pipeline con *sproket*

***Questo approccio è "obsoleto" e sarà sostituito da *importmap* e *Propshaft* ma al momento è quello più "collaudato".***

Il codice che vediamo è quasi identico a quello del progetto theme-eduport.
Ma **non** è identico. Ci sono delle differenze.
Il progetto theme_eduport usa importmap ed alcune chiamate sono diverse. Lo vediamo già da subito nel layout edu_demo.

> Reminder:
> Una cosa importante che dobbiamo ricordarci di fare è il `precompile` ad ogni modifica nell'asset-pipeline: `$ rails assets:precompile`



## Risorse interne

- []()



## Risorse esterne

- []()



## Apriamo il branch "EduPort JsBundler"

```bash
$ git checkout -b epjb
```



## Partiamo dalla pagina index

Maggior dettagli nel progetto "theme_eduport".

Vediamo tutto il codice *<html>* preso così com'è dal tema Eduport, senza predisposizione per Ruby on Rails.

***code 01 - .../theme_eduport/index.html - line:1***

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Eduport - LMS, Education and Course Theme</title>

	<!-- Meta Tags -->
	<meta charset="utf-8">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_01-theme_eduport-index.html)

> `theme-eduport` è una cartella del tema eduport **fuori** dalla nostra applicazione Rails.

Riadattiamo questo codice alla nostra applicazione su Ruby on Rails.



## Prepariamo un layout dedicato

Per gestire la parte che è tra i tags `<head> ... </head>` creiamo un layout dedicato che chiamiamo *edu_demo*.

Duplichiamo il file `.../layouts/application.html.erb` e rinominiamo la copia `.../layouts/edu_demo.html.erb`. 

Copiamo ed incolliamo la parte tra `<head> ... </head>` del codice `theme-eduport//index.html` al layout *edu_demo* commentando le parti che al momento non usiamo.

***codice 01 - .../app/views/layouts/edu_demo.html.erb - line:04***

```html+erb
    <!--<title>Ubuntudream</title>-->
    <title>Eduport - LMS, Education and Course Theme</title>

    <!-- Meta Tags -->
    <meta charset="utf-8">
    <!--<meta name="viewport" content="width=device-width,initial-scale=1">-->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="author" content="Webestica.com">
    <meta name="description" content="Eduport- LMS, Education and Course Theme">

    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_02-views-layouts-edu_demo.html.erb)



## Verifichiamo instradamento

Creiamo una nuova pagina di mockup che chiamiamo edu_index

Vediamo che la nostra view usa il controller *mockups*.

***codice 03 - ...config/routes.rb - line:20***

```ruby
  get 'mockups/edu_index'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_03-config-routes.rb)



## Aggiorniamo il controller

Creiamo la nuova azione `edu_index` e facciamo in modo utilizzi il layout `edu_demo`.

***codice 04 - ...controllers/mockups_controller.rb - line:8***

```ruby
  def edu_index
    render layout: 'edu_demo'
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_04-controllers-mockups_controller.rb)



## Aggiorniamo la mockups/edu_index 

Creiamo la nuova views `mockups/edu_index` ed inseriamo il codice del nostro file del tema che è dentro i tags `<body>...</body>`. 

Inoltre commentiamo le chiamate a javascript in fondo al codice perché tanto non funzionerebbero perché non hanno i puntamenti corretti all'asset-pipeline e darebbero solo errore nella java console del browser.

***codice 05 - ...views/mockups/index.html.erb - line:1***

```html+erb
<!-- Header START -->
<header class="navbar-light navbar-sticky navbar-transparent">
  <!-- Logo Nav START -->
  <nav class="navbar navbar-expand-xl">
    <div class="container">
      <!-- Logo START -->
      <a class="navbar-brand" href="index.html">
        <img class="light-mode-item navbar-brand-item" src="assets/images/logo.svg" alt="logo">
        <img class="dark-mode-item navbar-brand-item" src="assets/images/logo-light.svg" alt="logo">
      </a>
      <!-- Logo END -->
  
      <!-- Responsive navbar toggler -->
      <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse"
        aria-controls="navbarCollapse" aria-expanded="true" aria-label="Toggle navigation">
        <span class="me-2"><i class="fas fa-search fs-5"></i></span>
      </button>
  
      <!-- Category menu START -->
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_05-views-mockups-edu_index.html.erb)



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Andiamo con il browser sull'URL:

- http://192.168.64.3:3000
- oppure: http://192.168.64.3:3000/mockups/index

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/theme-eduport-esbuild/03-eduport_index/01_fig01-index1.png)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement Eduport index"
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_00-theme_stylesheet-it.md)
