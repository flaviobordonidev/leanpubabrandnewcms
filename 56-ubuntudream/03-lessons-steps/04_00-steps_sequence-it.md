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

***code 01 - .../views/steps/show.html.erb - line:6***

```html+erb
  <%= link_to '<Prev', lesson_step_path(@lesson, @step.id-1) if @step.id > @lesson.steps.first.id %>
  <%= @step.id-1 %>
  <%= link_to 'Next>', lesson_step_path(@lesson, @step.id+1) if @step.id < @lesson.steps.last.id %>
  <%= @step.id+1 %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/04_01-views-steps-show.html.erb)


> Questo approccio ha un *bug*! <br/>
> Se cancelliamo uno *step* si crea un "buco" nella sequenza e prendiamo errore!!!



## Debug di link *next*

La soluzione a questo è affidarsi al metodo `.where` nel *Model*.

***code: 02 - .../app/models/step.rb - line:21***

```ruby
  # == Instance Methods =====================================================
  def next
    lesson.steps.where("id > ?", id).first
  end

  def prev
    lesson.steps.where("id < ?", id).last
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/04_02-models-step.rb)

Usiamolo nella view *show*.

***code: 03 - .../app/views/steps/show.html.erb - line:6***

```html+erb
  <%#= link_to '<Prev', lesson_step_path(@lesson, @step.id-1) if @step.id > @lesson.steps.first.id %>
  <%= link_to '<Prev', lesson_step_path(@lesson, @step.prev.id) if @step.prev.present? %>
  <%= @step.prev.id if @step.prev.present? %>
  <%#= link_to 'Next>', lesson_step_path(@lesson, @step.id+1) if @step.id < @lesson.steps.last.id %>
  <%= link_to 'Next>', lesson_step_path(@lesson, @step.next.id) if @step.next.present? %>
  <%= @step.next.id if @step.next.present? %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/04_03-views-steps-show.html.erb)



## Altre soluzioni proposte sul web per il link *next*

Sul web sono proposte delle soluzioni per il link *next* che sfruttano il model **non** annidato.
Di seguito ne vediamo un esempio pensato per gli articoli (*Post*) di un blog.

***code: n/a - .../app/models/post.rb - line:x***

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

***code: n/a - .../app/models/post.rb - line:x***

```ruby
def previous_post
  self.class.first(:conditions => ["id < ?", id], :order => "id desc")
end

def next_post
  self.class.first(:conditions => ["id > ?", id], :order => "id asc")
end
```


Volendo organizzare in ordine alfabetico di titolo, potremmo usare questa:

***code: n/a - .../app/models/post.rb - line:x***

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



## Inseriamo un *form* per le risposte

Inseriamo un *form* nella view *show* per permettere agli utenti di dare la risposta.

> A differenza di *edit* che ci permette di editare anche la domanda, su *show* avremo solo la possibilità di inserire la risposta.

Facciamo in modo che partendo da `lessons/1/steps/1` passiamo al successivo step (`lessons/1/steps/2`) sul *submit* del *form*.

> Essendo il *form* solo per *show*, perché non c'è *new*, non usiamo un partial *_form_answer* ma mettiamo tutto il codice direttamente su *show*.

***code: 04 - .../views/steps/show.html.erb - line:7***

```html+erb
<%= form_with(model: [@lesson, @step]) do |form| %>
  <% if @step.errors.any? %>
    <div style="color: red">
      <h2><%= pluralize(@step.errors.count, "error") %> prohibited this step from being saved:</h2>

      <ul>
        <% @step.errors.each do |error| %>
          <li><%= error.full_message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <div>
    <%= form.label :answer, style: "display: block" %>
    <%= form.text_area :answer %>
  </div>

  <div>
    <%= form.submit %>
  </div>
<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/04_04-views-steps-show.html.erb)

> Il codice aggiunto è praticamente lo stesso del partial `steps/_form` con qualche piccola modifica.<br/>
> Ad esempio non essendo su un partial invece della variabile `step` ci riferiamo direttamente alla variabile di istanza `@step`.
> Questo perché quando chiamiamo il partial `steps/_form` usiamo `<%= render 'form', step: @step %>`.
> Ossia passiamo la variabile di istanza `@step` alla variabile locale `step` che usiamo nel partial.



## Aggiorniamo il controller

Aggiorniamo l'azione update facendo in modo che il render vada alla pagina seguente.

***code: 05 - .../app/controllers/step_controller - line:48***

```ruby
        format.html do 
          if @step.next.present?
            redirect_to lesson_step_path(@lesson, @step.next.id), notice: 'Step was successfully updated.' 
          else
            redirect_to lesson_step_path(@lesson), notice: 'Step was successfully updated. - Ultima risposta'
          end
        end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/04_05-controllers-steps_controller.rb)

> Più avanti lo miglioriamo perché al momento è mischiato tra la preparazione della lezione in cui l'update dovrebbe tornare alla stessa istanza di *step* e l'assistere della lezione in cui al seguito della risposta si va al nuovo *step*. Inoltre sul *submit* dell'ultima risposta dovremmo essere instradati su una pagina di fine lezione oppure su *lessons/show* con il flag di lezione conclusa.


## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Andiamo all'url:

- http://192.168.64.3:3000/lessons/1/steps/1

E verifichiamo che modificando le risposte andiamo avanti al prossimo step fino alla fine della lezione.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Update lessons views"
```



## Publichiamo su heroku

```bash
$ git push heroku cs:main
$ heroku run rake db:migrate
```


Verifichiamo preview su heroku.

Andiamo all'url:

* https://elisinfo.herokuapp.com/lessons/1/steps/1

E verifichiamo di arrivare al primo step della prima lezione.




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge ln
$ git branch -d ln
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_00-nested_routes-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/04_00-steps_sequence-it.md)
