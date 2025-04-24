# <a name="top"></a> Cap 3.10 - Lista di tutti gli utenti

In questa pagina l'amministratore può gestire tutti gli utenti.



## Risorse interne

- []()



## Pagine dal tema

Per la nostra homepage ci rifacciamo alle seguenti pagine del tema Eduport:

Pagina tema                         | Uso nella nostra app
| :--                               | :--
eduport_v1.2.0/template/admin-student-list.html 	| Struttura iniziale 




## Scegliamo la pagina dal tema eduport

Abbiamo selezionato "admin-student-list.html"

***code 01 - eduport_v1.2.0/template/admin-student-list.html - line:1***

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

