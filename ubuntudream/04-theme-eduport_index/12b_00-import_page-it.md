# <a name="top"></a> Cap 2.1 - Importiamo una pagina dal tema



## Prepariamo un layout dedicato

Per gestire la parte che è tra i tags `<head> ... </head>` creiamo un layout dedicato che chiamiamo *edu_demo*.

Duplichiamo il file `.../layouts/application.html.erb` e rinominiamo la copia `.../layouts/edu_demo.html.erb`. 

Iniziamo con il codice base creato in automatico da Rails.

***codice 02 - .../app/views/layouts/edu_demo.html.erb - line:1***

```html+erb
<!DOCTYPE html>
<html>
  <head>
    <title>Eduport</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
```

Ed aggiungiamo alcune righe 

***codice 02 - .../app/views/layouts/edu_demo.html.erb - line:6***

```html+erb
  	<!-- Meta Tags -->
  	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<meta name="author" content="Flavio Bordoni">
  	<meta name="description" content="Eduport- LMS, Education and Course Theme">
```




## Iniziamo ad aggiungere righe di codice al layer edu_demo

Aggiungiamo alcune righe 

***codice 02 - .../app/views/layouts/edu_demo.html.erb - line:6***

```html+erb
  	<!-- Meta Tags -->
  	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  	<meta name="author" content="Flavio Bordoni">
  	<meta name="description" content="Eduport- LMS, Education and Course Theme">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/15-theme-edu/02-mockups-first-page/01_02-views-layouts-edu_demo.html.erb)


