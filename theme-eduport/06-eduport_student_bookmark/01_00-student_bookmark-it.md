# <a name="top"></a> Cap 6.1 - Eduport pagina student_bookmark




## Risorse interne

- []()



## Risorse esterne

- [file di esempio preso dal tema Eduport](file:///Users/FB/eduport_v1.2.0/template/index.html).
- [indice della documentazione dentro il tema Eduport](file:///Users/FB/eduport_v1.2.0/template/docs/index.html)
- [Sito per acquistare Eduport](https://themes.getbootstrap.com/store/webestica/)
- [Sito web dello sviluppatore di Eduport](https://eduport.webestica.com/)



## Apriamo il branch "Edupost Student Bookmark"

```bash
$ git checkout -b esb
```



## La pagina

Vediamo la pagina *student_bookmark*.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig01-index1.png)

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig02-index2.png)

![fig03](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig03-index3.png)

![fig04](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig04-index4.png)

![fig05](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_fig05-index5.png)

Vediamo tutto il codice *<html>* preso così com'è dal tema Eduport, senza predisposizione per Ruby on Rails.

***code 01 - .../theme_eduport/student_bookmark.html - line:1***

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



## Usiamoo il layout dedicato

Per gestire la parte che è tra i tags `<head> ... </head>` usiamo il layout *edu_demo*.



## Aggiorniamo instradamento

Aggiungiamo instradamento nella nostra routes.

***codice 03 - ...config/routes.rb - line:20***

```ruby
  get 'mockups/edu_student_bookmark'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_03-config-routes.rb)



## Aggiorniamo il controller

Creiamo l'azione `student_bookmark` e facciamo in modo che la relativa view utilizzi il layout `edu_demo`.

***codice 04 - ...controllers/mockups_controller.rb - line:8***

```ruby
  def student_bookmark
    render layout: 'edu_demo'
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-theme_eduport/01_04-controllers-mockups_controller.rb)



## Creiamo la view 

Creiamo la nuova views `mockups/student_bookmark` ed inseriamo il codice del nostro file del tema che è dentro i tags `<body>...</body>`. 

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
