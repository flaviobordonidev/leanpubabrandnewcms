# <a name="top"></a> Cap 3.4 - Scorriamo tra i passi (*steps*) di una lezione (*lesson*)

In questo capitolo mettiamo su *steps/show* un pulsante per avanzare allo *step* successivo in modo da avanzare nella *lesson* dal primo *step* fino all'ultimo.

> Abilitiamo i links ed i metodi per spostarsi all'istanza successiva (`next`) o all'istanza precedente (`prev`) di un oggetto. Nel nostro caso dell'oggetto *Step* che ha anche la particolarità di essere un oggetto annidato all'interno dell'oggetto *Lesson*.



## Risorse esterne

- [Rails: Get next / previous record](https://stackoverflow.com/questions/7394088/rails-get-next-previous-record)



## Apriamo il branch

Continuiamo con quello aperto nei capitoli precedenti.



## Inseriamo il link *next*

Su *steps/show* inseriamo un link "next" che ci porta allo step successivo.
Esempio: da lessons/1/steps/1 a lessons/1/steps/2.

***code 01 - .../views/steps/show.html.erb - line:1***

```html+erb
<br>
<%= link_to 'Prev', lesson_step_path(@lesson, @step.id-1) if @step.id > @lesson.steps.first.id %>
<%= link_to 'Next', lesson_step_path(@lesson, @step.id+1) if @step.id < @lesson.steps.last.id %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/04_01-views-steps-show.html.erb)


> Questo approccio ha un *bug*! <br/>
> Se cancelliamo una step si crea un "buco" e prendiamo errore!!!


## Debug di link *next*

La soluzione a questo è affidarsi al metodo `.where` nel *Model*.

***code: n/a - .../app/models/step.rb - line:21***

```ruby
  # == Instance Methods =====================================================
  def next
    lesson.steps.where("id > ?", id).first
  end

  def prev
    lesson.steps.where("id < ?", id).last
  end
```


***code: n/a - .../app/views/steps/show.html.erb - line:6***

```html+erb
  <%#= link_to '<Prev', lesson_step_path(@lesson, @step.id-1) if @step.id > @lesson.steps.first.id %>
  <%= link_to '<Prev', lesson_step_path(@lesson, @step.prev.id) if @step.prev.present? %>
  <%= @step.prev.id if @step.prev.present? %>
  <%#= link_to 'Next>', lesson_step_path(@lesson, @step.id+1) if @step.id < @lesson.steps.last.id %>
  <%= link_to 'Next>', lesson_step_path(@lesson, @step.next.id) if @step.next.present? %>
  <%= @step.next.id if @step.next.present? %>
```



## Altre soluzioni proposte sul web per il link *next*

Sul web sono proposte delle soluzioni per il link *next* che sfruttano il model **non** annidato.
Di seguito ne vediamo un esempio pensato per gli articoli (*Post*) di un blog.
Prepariamo nel model i riferimenti a *next* e *previous*.

*** code: n/a - .../app/models/post.rb - line:x ***

```ruby
def previous_post
  Post.where(["id < ?", id]).last
  #self.class.where(["id < ?", id]).last
end

def next_post
  Post.where(["id > ?", id]).first
  #self.class.where(["id > ?", id]).first
end
```

> Invece di indicare `Post.` si può usare `self.class.` rendendo il codice più "facile da gestire" per revisioni future. Ad esempio se cambiamo nome al model...


Vediamo un secondo esempio.

*** code: n/a - .../app/models/post.rb - line:x ***

```ruby
def previous_post
  self.class.first(:conditions => ["id < ?", id], :order => "id desc")
end

def next_post
  self.class.first(:conditions => ["id > ?", id], :order => "id asc")
end
```


Volendo organizzare in ordine alfabetico di titolo, potremmo usare questa:

*** code: n/a - .../app/models/post.rb - line:x ***

```ruby
def previous_post
  self.class.first(:conditions => ["title < ?", title], :order => "title desc")
end

def next_post
  self.class.first(:conditions => ["title > ?", title], :order => "title asc")
end
```

> Puoi cambiare `title` con qualsiasi altro **unique attribute** (es: `created_at`, `id`, ecc.) se hai bisogno di un diverso ordinamento (sort order).


Vediamo come presentare nel *view* i metodi creati.

***code: n/a - .../views/posts/1 - line:x***

```html+erb
<%= link_to("Previous Post", @post.previous_post) if @post.previous_post %>
<%= link_to("Next Post", @post.next_post) if @post.next_post %>
```

Fine della digressione. Torniamo alla nostra applicazione.



## Inseriamo il FORM

Inseriamo il form nello show in modo da permettere agli utenti di dare la risposta.
A differenza di Edit che ci permette di editare anche la domanda, su show avremo solo la possibilità di inserire la risposta.

Facciamo in modo che pardendo da lessons/1/steps/1 passiamo al successivo step (lessons/1/steps/2) sul submit del form.

Essendo un solo form, perché non c'è "new", non usiamo un partial "_form_answer" ma mettiamo tutto il codice direttamente su show.

{id: "56-03-02_2", caption: ".../views/steps/show.html.erb -- codice 2", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= form_with(model: [@lesson, @step], local: true) do |form| %>
  <% if @step.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@step.errors.count, "error") %> prohibited this step from being saved:</h2>

      <ul>
        <% @step.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= form.label :answer %>
    <%= form.text_area :answer %>
  </div>

  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```

[tutto il codice](#56-03-02_2all)

Il codice aggiunto è praticamente lo stesso del partial steps/_form con qualche piccola modifica.
è importante far notare che invece della variabile *step* dobbiamo usare la variabile di istanza *@step*.
Questo perché quando chiamiamo il partial steps/_form usiamo questa linea di codice:

```
<%= render 'form', step: @step %>
```

Ossia passiamo la variabile di istanza *@step* alla variabile locale *step* che usiamo nel partial.
Invece su show non usiamo il partial e quindi ci riferiamo direttamente alla variabile di istanza *@step*.




## Aggiustiamo alcuni links

Riadattiamo alcuni links per muoverci agevolmente tra lezioni e steps.

{id: "56-03-02_3", caption: ".../views/steps/index.html.erb -- codice 3", format: HTML+Mako, line-numbers: true, number-from: 1}
```
        <td><%= link_to 'Show Lesson', [@lesson] %></td>
        <td><%= link_to 'Show Step', [@lesson, step] %></td>
        <td><%= link_to 'Edit Step', edit_lesson_step_path(@lesson, step) %></td>
        <td><%= link_to 'Destroy Step', [@lesson, step], method: :delete, data: { confirm: 'Are you sure?' } %></td>
```

[tutto il codice](#56-03-02_3all)

da notare che avendo aggiunto un altro link abbiamo portato a 4 il colspan dell'header della tabella.

```
<th colspan="4"></th>
```


Adattiamo anche i links della view *steps/edit*

{id: "56-03-02_4", caption: ".../views/steps/edit.html.erb -- codice 4", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%#= link_to 'Show', @step %>
<%= link_to 'Back to Show', lesson_step_path(@lesson, @step) %> |
<%#= link_to 'Back', steps_path %>
<%= link_to 'Back to steps index', lesson_steps_path(@lesson) %>
```

[tutto il codice](#56-03-02_4all)

