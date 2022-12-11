# <a name="top"></a> Cap 21.1 - Applichiamo stile alla pagina dell'elenco lezioni

Mettiamo lo style preso dal tema edu nelle views che abbiamo creato.
Nella pagina `lessons/index` presentiamo l'elenco delle lezioni (lessons).



## Apriamo il branch "Edu Style Lesson Index"

```bash
$ git checkout -b esli
```



## Importiamo il mockup lessons_index

Copiamoci tutta la parte del mockup del tag ***<main>...</main>*** e la mettiamo all'inizio, ossia a partire dalla linea 01.

***Codice 01 - .../app/views/lessons/index.html.erb - linea:01***

```html+erb
<!-- **************** MAIN CONTENT START **************** -->
<main>
	
<!-- =======================
Page Banner START -->
<section class="pt-0">
	<!-- Main banner background image -->
```



## Inseriamo i Meta_data

Mettiamo all'inizio del codice, ossia a partire dalla linea 01, i meta_data che al momento contengono il valore da passare al titolo del sito web (quello nel layout nel tag ***<head>...</head>***).

***Codice 01 - ...continua - linea:01***

```html+erb
<%# == Meta_data ============================================================ %>

<% provide(:html_head_title, "#{t 'lessons.index.html_head_title'}") %>

<%# == Meta_data - end ====================================================== %>

<!-- **************** MAIN CONTENT START **************** -->
<main>
	
<!-- =======================
Page Banner START -->
<section class="pt-0">
	<!-- Main banner background image -->
```

***Codice 01 - ...continua - linea:120***

```html+erb
            <%= render "form", user: @user %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/06-user-profile/01_01-views-users-edit.html.erb)




## Isoliamo blocco di una singola lezione

Dal codice preso dal mockup cancelliamo le varie copie di blocchi di lezione lasciandone uno solo. Questo perché adesso creiamo dinamicamente i vari blocchi tramite un ciclo `.each`.
Copiamoci questo blocco dentro il partial `_lesson`.

***Codice 02 - .../app/views/lessons/_lesson.html.erb - linea:01***

```html+erb
<div id="<%= dom_id lesson %>">
  <!-- Card list START -->
  <div class="col-12">
    <div class="card shadow overflow-hidden p-2">
      <div class="row g-0">
        <div class="col-md-5 overflow-hidden">
            <%= image_tag "mockups/training_01.jpeg", class: "rounded-2", alt: "Card image" %>
        </div>
        <div class="col-md-7">
          <div class="card-body">
            <!-- Badge and rating -->
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/06-user-profile/01_01-views-users-edit.html.erb)


## Applichiamo truncate alla descrizione

Potremmo creare un nuovo campo per una descrizione breve, ma preferiamo semplificare ed usare la descrizione già presente però troncandola dopo x caratteri.

<%= lesson.description_rtf %>