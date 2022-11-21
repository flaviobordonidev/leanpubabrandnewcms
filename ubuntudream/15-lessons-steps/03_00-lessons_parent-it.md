# <a name="top"></a> Cap 3.3 - Aggiorniamo *lessons* come *parents* di *steps*

Nel capitolo precedente abbiamo creato l'instradamento annidato e ci siamo occupati di *steps* aggiornando il controller e le views per riflettere la sua relazione "child" rispetto a *lessons*.

In questo capitolo invece ci occupiamo di *lessons* aggiornando le views per riflettere la loro relazione "parent" rispetto a *steps*.



## Risorse interne

- []() 



## Aggiorniamo `lessons/show`

Mettiamo i links relativi agli steps nella visualizzazione della lezione.

***Codice 01 - .../views/lessons/show.html.erb - linea:06***

```html+erb
  <%= link_to "Show all steps of this lesson", lesson_steps_path(@lesson) %> | 
  <%= link_to 'Add New Step', new_lesson_step_path(@lesson) %> || 
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-lessons-steps/03_01-views-lessons-show.html.erb)



## Aggiorniamo `lessons/_lesson`

Aggiorniamo il partial *_lesson* richiamato dalla view *show*.

***Codice 02 - .../views/lessons/_lesson.html.erb - linea:12***

```html+erb
  <h2>Steps</h2>
  <% for step in lesson.steps %>
    <ul>
      <li><%= step.question %></li>
    </ul>
  <% end %>

  <%= link_to "Show all steps of this lesson", lesson_steps_path(lesson) %> | 
  <%= link_to 'Add New Step', new_lesson_step_path(lesson) %>
  <h2>- - -</h2>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-lessons-steps/03_02-views-lessons-_lesson.html.erb)

> Aggiungiamo una sezione *Steps* al partial *_lesson* con il collection di tutti gli steps associati alla specifica *lesson*.



## Vediamo le restanti views `lessons/...`

Sulle restanti views **non** facciamo nessuna modifica.

***Codice 03 - .../views/lessons/index.html.erb - linea:03***

```html+erb
<h1>Lessons</h1>

<div id="lessons">
  <% @lessons.each do |lesson| %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-lessons-steps/03_03-views-lessons-index.html.erb)

***Codice 04 - .../views/lessons/edit.html.erb - linea:01***

```html+erb
<h1>Editing lesson</h1>

<%= render "form", lesson: @lesson %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-lessons-steps/03_04-views-lessons-edit.html.erb)

***Codice 05 - .../views/lessons/new.html.erb - linea:01***

```html+erb
<h1>New lesson</h1>

<%= render "form", lesson: @lesson %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-lessons-steps/03_05-views-lessons-new.html.erb)

***Codice 06 - .../views/lessons/_form_.html.erb - linea:01***

```html+erb
<%= form_with(model: lesson) do |form| %>
  <% if lesson.errors.any? %>
    <div style="color: red">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/03_06-views-lessons-_form.html.erb)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Update lessons views"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_00-nested_routes-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/04_00-steps_sequence-it.md)
