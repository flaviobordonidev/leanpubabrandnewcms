# <a name="top"></a> Cap 2.8 - Modifichiamo il profilo utente

In questa pagina l'utente può modificare il suo profilo.
Mettiamo lo stile eduport alla gestione dell'utente.


## Risorse interne

- []()




## Scegliamo la pagina dal tema eduport

Abbiamo selezionato "instructor-edit-profile.html"

***code 01 - eduport_v1.2.0/template/instructor-edit-profile.html - line:1***

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Eduport - LMS, Education and Course Theme</title>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-mockups/08_01-instructor-edit-profile.html)



## Mockups *users_edit*

Questo mockups è fatto a partire dalla pagina *instructor-edit-profile* di Eduport.
Vediamo la prima modifica.

***code 01 - .../views/mockups/users_edit.rb - line:1***

```html+erb
<!-- Questa è la pagina che permette di modificare l'utente -->

<!-- Header START -->
<header class="navbar-light navbar-sticky">
	<!-- Logo Nav START -->
	<nav class="navbar navbar-expand-xl">
		<div class="container">
			<!-- Logo START -->
			<a class="navbar-brand" href="index.html">
        <%= image_tag "edu/logo.svg", class: "light-mode-item navbar-brand-item", alt: "logo" %>
        <%= image_tag "edu/logo-light.svg", class: "dark-mode-item navbar-brand-item", alt: "logo" %>
			</a>
			<!-- Logo END -->
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/02-mokups/04_00-lessons_show-it.rb)

