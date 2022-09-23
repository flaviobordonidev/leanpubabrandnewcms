# <a name="top"></a> Cap 2.1 - Il tema eduport

Tema che usiamo per UbuntuDream.
Dopo una grande ricerca ho finalmente trovato un tema che mi soddisfa per UbuntuDream.

La grafica dell'interfaccia utente (User Interface) che mi piace simulare è quella usata nell'app [Headspace](https://www.headspace.com/).

Il tema che ci si avvicina è [eduport](https://eduport.webestica.com/). 
Inoltre questo tema è un [tema *ufficiali* di bootstrap](https://themes.getbootstrap.com/product/eduport-lms-education-and-course-theme/)


Nei seguenti capitoli riportiamo nella nostra applicazione alcune pagine del tema eduport esattamente così come sono. Questo ci permette di importare ed adattare tutto lo stylesheets ed il javascript degli elementi che ci interessano per la nostra app. Questo comprende anche le librerie di icone.



## Risorse interne

- []()



## Risorse esterne

- [file di esempio preso dal tema Eduport](file:///Users/FB/eduport_v1.2.0/template/index.html).
- [indice della documentazione dentro il tema Eduport](file:///Users/FB/eduport_v1.2.0/template/docs/index.html)
- [Sito per acquistare Eduport](https://themes.getbootstrap.com/store/webestica/)
- [Sito web dello sviluppatore di Eduport](https://eduport.webestica.com/)



## Apriamo il branch "EduPost"

```bash
$ git checkout -b ep
```



## Partiamo dalla pagina index

Spesso nei temi la pagina *index* è quella che contiene la maggior parte delle caratteristiche del tema ed è quindi una buona scelta iniziare da questa.

Vediamo la pagina *index*.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig01-index1.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig02-index2.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig03-index3.png)

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig04-index4.png)

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig05-index5.png)

Vediamo tutto il codice *<html>* preso così com'è dal tema Eduport, senza predisposizione per Ruby on Rails.

***code 01 - .../theme-eduport/index.html - line:1***

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Eduport - LMS, Education and Course Theme</title>

	<!-- Meta Tags -->
	<meta charset="utf-8">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_01-index.html)

> `theme-eduport` è una cartella del tema eduport **fuori** dalla nostra applicazione Rails.

Riadattiamo questo codice alla nostra applicazione su Ruby on Rails.



## Prepariamo un layout dedicato

Per gestire la parte che è tra i tags `<head> ... </head>` creiamo un layout dedicato che chiamiamo *edu_demo*.

Duplichiamo il file `.../layouts/application.html.erb` e rinominiamo la copia `.../layouts/edu_demo.html.erb`. 

Copiamo ed incolliamo la parte tra `<head> ... </head>` del codice `theme-eduport//index.html` al layout *edu_demo* commentando le parti che al momento non usiamo.

***codice 02 - .../app/views/layouts/edu_demo.html.erb - line:04***

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

Vediamo che la nostra view usa il controllr *mockups*.

***codice 03 - ...config/routes.rb - line:20***

```ruby
  get 'mockups/index'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_03-config-routes.rb)



## Aggiorniamo il controller con nuova view e nuovo layout

Facciamo in modo che la nuova view `index` utilizzi il layout `edu_demo`.

***codice 04 - ...controllers/mockups_controller.rb - line:8***

```ruby
  def index
    render layout: 'edu_demo'
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_04-controllers-mockups_controller.rb)



## Aggiorniamo la mockups/index 

Creiamo la nuova views `mockups/index` ed inseriamo il codice del nostro file del tema che è dentro i tags `<body>...</body>`. 

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

![fig06](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig06-index1.png)

![fig07](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig07-index2.png)

![fig08](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig08-index3.png)

![fig09](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig09-index4.png)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Implement Eduport index"
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/02_00-theme_stylesheet.md)
