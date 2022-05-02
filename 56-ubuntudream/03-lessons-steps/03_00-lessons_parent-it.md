# <a name="top"></a> Cap 3.3 - Aggiorniamo *lessons* come *parents* di *steps*

Nel capitolo precedente abbiamo creato l'instradamento annidato e ci siamo occupati di *steps* aggiornando il controller e le views per riflettere la sua relazione "child" rispetto a *lessons*.

In questo capitolo invece ci occupiamo di *lessons* aggiornando il controller e le views per riflettere la sua relazione "parent" rispetto a *steps*.

## Risorse esterne

- []() 



## Apriamo il branch "Lessons Parent"

```bash
$ git checkout -b lp
```



## Le view *lessons*

Aggiorniamo il partial *_lesson* richiamato dalla view *show*.

*** code 01 - .../views/lessons/_lesson.html.erb - line:1 ***

```html+erb
  <h2>Steps</h2>
  <% for step in lesson.steps %>
      <ul>
        <li><%= step.question %></li>
    </ul>
  <% end %>

  <%= link_to 'View All Steps with answers', lesson_steps_path(@lesson) %> | 
  <%= link_to 'Add New Step', new_lesson_step_path(@lesson) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/03_01-views-lessons-_lesson.html.erb)

> Aggiungiamo una sezione *Steps* al *form* con il collection di tutti gli steps associati alla specifica *lesson* ed inoltre un link *Add Step*.

> Attenzione: i due *link_to* funzionano per *show* ma danno errore su *index* perché non è presente una specifica lezione (*@lesson*). Questo lo risolviamo fra poco.


Aggiorniamo la view *show*.

*** code 02 - .../views/lessons/show.html.erb - line:1 ***

```html+erb
<p style="color: green"><%= notice %></p>

<%= render @lesson %>

<div>
  <%= link_to "Edit this lesson", edit_lesson_path(@lesson) %> |
  <%= link_to "Back to lessons", lessons_path %>

  <%= button_to "Destroy this lesson", @lesson, method: :delete %>
</div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/03_02-views-lessons-show.html.erb)

> Sulla view *show* non facciamo nessuna modifica.


Aggiorniamo la view *index*.

*** code 03 - .../views/lessons/index.html.erb - line:1 ***

```html+erb
<p style="color: green"><%= notice %></p>

<h1>Lessons</h1>

<div id="lessons">
  <% @lessons.each do |lesson| %>
    <%= render lesson %>
    <p>
      <%= link_to "Show this lesson", lesson %>
    </p>
  <% end %>
</div>

<%= link_to "New lesson", new_lesson_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/03_03-views-lessons-index.html.erb)

> Sulla view *index* non facciamo nessuna modifica.

Però in *preview* riceviamo un errore a causa dei due *link_to* sul partial *_lesson*.

Correggiamo questo *bug*.

*** code 04 - .../views/lessons/_lesson.html.erb - line:1 ***

```html+erb
  <%= link_to 'View All Steps with answers', lesson_steps_path(@lesson) if @lesson.present? %> | 
  <%= link_to 'Add New Step', new_lesson_step_path(@lesson) if @lesson.present? %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/03_04-views-lessons-_lesson.html.erb)


> è bastato un `if @lesson.present?` nella visualizzazione. In questo modo quando siamo sulì*index* e non c'è una specifica *@lesson* selezionata, i links non sono visualizzati.


Aggiorniamo la view *edit*.

*** code 05 - .../views/lessons/edit.html.erb - line:1 ***

```html+erb
<h1>Editing lesson</h1>

<%= render "form", lesson: @lesson %>

<br>

<div>
  <%= link_to "Show this lesson", @lesson %> |
  <%= link_to "Back to lessons", lessons_path %>
</div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/03_05-views-lessons-edit.html.erb)

> Sulla view *edit* non facciamo nessuna modifica.



Aggiorniamo la view *new*.

*** code 06 - .../views/lessons/new.html.erb - line:1 ***

```html+erb
<h1>New lesson</h1>

<%= render "form", lesson: @lesson %>

<br>

<div>
  <%= link_to "Back to lessons", lessons_path %>
</div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/03_06-views-lessons-new.html.erb)

> Sulla view *new* non facciamo nessuna modifica.


Aggiorniamo il partial *_form*.

*** code 07 - .../views/lessons/_form_.html.erb - line:1 ***

```html+erb
<%= form_with(model: lesson) do |form| %>
  <% if lesson.errors.any? %>
    <div style="color: red">
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/03_07-views-lessons-_form.html.erb)

> Sul partial *_form_* non facciamo nessuna modifica.



## Salviamo su git

```bash
$ git add -A
$ git commit -m "add seed companies"
```



## Publichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku cs:master
$ heroku run rake db:migrate
```


Verifichiamo preview su heroku.

Andiamo all'url:

* https://elisinfo.herokuapp.com/lessons/1/steps/1

E verifichiamo di arrivare al primo step della prima lezione.




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge ln
$ git branch -d ln
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```
