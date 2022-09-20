# <a name="top"></a> Cap 8.3 - Show User profile / account

Mettiamo lo stile eduport alla gestione dell'utente.
Più specificamente visualizziamo il profilo dell'utente loggato.


## Risorse interne

- []()



## Risorse esterne

- []()



## Scegliamo la pagina dal tema eduport

Abbiamo selezionato "instructor-single.html"

***code 01 - eduport_v1.2.0/template/instructor-single.html - line:1***

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Eduport - LMS, Education and Course Theme</title>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/08-user/03_01-instructor-single.html)



## Primo inserimento su users/show

Mettiamo la parte che ci interessa su users/show

***code 02 - .../app/views/users/_user.html.erb - line:1***

```html+erb
<div id="<%= dom_id user %>">

  <!-- =======================
  Page content START -->
  <section class="pt-5 pb-0">
    <div class="container">
      <div class="row g-0 g-lg-5">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/08-user/03_02-views-users-_user.html.erb)

