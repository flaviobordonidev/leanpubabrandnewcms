# <a name="top"></a> Cap 1.1 - Il tema eduport

Tema che usiamo per UbuntuDream.
Dopo una grande ricerca ho finalmente trovato un tema che mi soddisfa per UbuntuDream.

La grafica dell'interfaccia utente (User Interface) che mi piace simulare è quella usata nell'app [Headspace](https://www.headspace.com/).

Il tema che ci si avvicina è [eduport](https://eduport.webestica.com/). 
Inoltre questo tema è un [tema *ufficiali* di bootstrap](https://themes.getbootstrap.com/product/eduport-lms-education-and-course-theme/)



## Risorse interne

- []()



## Risorse esterne

- []()



## Apriamo il branch "EduPort"

```bash
$ git checkout -b ep
```



## Prepariamo l'applicazione

Facciamo un fork/git_clone dell'applicazione `theme-edu` oppure eseguiamo i primi 4 passaggi:

- 01-new_app
- 02-production
- 03-bootstrap
- 04-eduport_index

Questi passaggi sono sufficienti per avere la base per continuare con `ubuntudream`.

Da qui possiamo continuare con la preparazione di mockups personalizzati per `ubuntudream`.







## Aggiorniamo il controller

Facciamo in modo che la view `index` utilizzi il layout `edu_demo`.

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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_00-import_page.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/02_00-theme_stylesheet-it.md)
