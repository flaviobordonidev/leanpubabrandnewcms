# <a name="top"></a> Cap 3.2 - Instradamenti annidati

In questo capitolo creiamo degli instradamneti annidati `lessons/#/steps/#` ed aggiorniamo i relativi controllers e le views.


## Risorse interne

- [99-code_references/active_records/20_00-sharks_and_posts](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/active_records/20_00-sharks_and_posts.md)



## Apriamo il branch "Lessons Seeds"

Conrinuiamo con il branch aperto nei capitoli precedenti.



## Instradamenti annidati (Nested Routes)

In automatico, con il *generate scaffold...* sono state create due voci distinte per gli instradamenti *Restful*.

*** code 01 - .../config/routes.rb  - line:11 ***

```ruby
Rails.application.routes.draw do
  resources :steps
  resources :lessons

  root 'lessons#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_05-config-routes.rb)

L'attuale codice stabilisce una relazione indipendente tra i nostri instradamenti (routes), quando ciò che vorremmo esprimere è una relazione di dipendenza tra le lezioni (:lessons) e i loro passi (:steps) associati.

Vogliamo che siano annidate: `lessons/#/steps/#`.

Ad esempio:

- la `lessons/1` ha gli steps da `steps/1` a `steps/7`.
- la `lessons/2` ha gli steps da `steps/1` e `steps/3`.
- ... 
- la `lessons/12` ha gli steps da `steps/1` e `steps/34`.
- e così via.


Aggiorniamo i nostri istradamenti (routes) per rendere `:lessons` il genitore (parent) di `:steps`. 

*** code 02 - .../config/routes.rb  - line:11 ***

```ruby
Rails.application.routes.draw do
  resources :lessons do
    resources :steps
  end
  root 'lessons#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_06-config-routes.rb)



## Aggiorniamo il controller *steps*

L'associazione tra i nostri modelli ci fornisce metodi che possiamo utilizzare per creare nuove istanze di *steps* associate a specifiche *lessons*. 
Utiliziamo questi metodi aggiornando il controller *steps*.

Vediamo prima il controller creato dallo scaffold.

*** code 03 - .../app/controllers/steps_controller.rb - line:11 ***

```ruby
class StepsController < ApplicationController
  before_action :set_step, only: [:show, :edit, :update, :destroy]

  # GET /steps
  # GET /steps.json
  def index
    @steps = Step.all
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_07-controllers-steps_controller.rb)

Come il nostro controller delle lezioni (lessons_controller), i metodi di questo controller funzionano con le istanze della classe *Step* associata. Ad esempio, il metodo `new` crea una nuova istanza della classe *Step*, il metodo `index` acquisisce tutte le istanze della classe e il metodo `set_step` usa **find** e **params** per selezionare uno specifico `step` tramite **id**. Se, tuttavia, vogliamo che le nostre istanze di `step` siano associate a particolari istanze di `lesson`, allora dobbiamo modificare questo codice, perché la classe `Step` sta attualmente operando come un'entità indipendente.

Le nostre modifiche utilizzeranno due cose:

- I metodi (methods) che ci sono diventati disponibili quando abbiamo aggiunto ai nostri modelli le associazioni appartene_a (`belongs_to`) e ha_molti (`has_many`). In particolare, ora abbiamo accesso al metodo `build` grazie all'associazione `has_many` che abbiamo definito nel nostro modello *Lesson*. Questo metodo ci consentirà di creare una collezione di oggetti *step* (collection of step objects) associati a un particolare oggetto *lesson*, utilizzando la chiave esterna `lesson_id` che esiste nella tabella del nostro database di passaggi.
- Gli instradamenti e gli helper di instradamento che sono diventati disponibili quando abbiamo creato un percorso di *step* annidati. Per ora ci basterà sapere che per ogni lezione specifica — diciamo lessons/1 — ci sarà un instradamento associato per i relativi *step* di quella lesson: `lessons/1/steps`. Ci saranno anche helpers di instradamento come `lesson_steps_path(@lesson)` e `edit_lessons_steps_path(@lesson)` che fanno riferimento a questi percorsi annidati.

Iniziamo scrivendo il metodo, `get_lesson`, che verrà eseguito prima di ogni azione nel controller. Questo metodo creerà una variabile di istanza locale `@lesson` trovando un'istanza di lezione da `lesson_id`. Con questa variabile a nostra disposizione, sarà possibile correlare i passaggi a una lezione specifica negli altri metodi.

Aggiungiamo il metodo nella sezione *private*.

*** code n/a - .../app/controllers/steps_controller.rb - line:11 ***

```ruby
private
  def get_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
```

Quindi, aggiungiamo relativo *before_action*.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
class StepsController < ApplicationController
  before_action :get_lesson
```

Ciò garantirà che `get_lesson` sia eseguito prima di ogni altra azione.

Successivamente, utilizziamo questa istanza `@lesson` per riscrivere il metodo index. Invece di acquisire tutte le istanze della classe `Step`, vogliamo che questo metodo restituisca tutte le istanze di `step` **associate** a una specifica istanza di `lesson`.

Aggiorniamo l'azione *index*.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
  def index
    @steps = @lesson.steps
  end
```

L'azione `new` ha bisogno di una revisione simile, poiché vogliamo che una nuova istanza di `step` sia associata a una particolare `lesson`. Per ottenere ciò, possiamo utilizzare il metodo `build`, insieme alla nostra variabile di istanza locale `@lesson`.

Aggiorniamoa l'azione *new*.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
  def new
    @step = @lesson.steps.build
  end
```

Questa azione crea un oggetto `step` che è associato ad una specifica istanza di `lesson` per mezzo del metodo `get_lesson`.

Successivamente, aggiorniamo l'azione `create`. L'azione `create` fa due cose: crea una nuova istanza di *step* usando i parametri che gli utenti hanno inserito nel *form new* e, se non ci sono errori, salva quell'istanza e usa un route helper per reindirizzare gli utenti a dove possono vedere il nuovo *step*. In caso di errori, esegue nuovamente il rendering del *form new*.

Aggiorniamo l'azione *create*.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
def create
  @step = @lesson.steps.build(step_params)
    respond_to do |format|
      if @step.save
        format.html { redirect_to lesson_steps_path(@lesson), notice: 'Step was successfully created.' }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end
end
```

Quindi, passiamo all'azione *update*. Questa azione utilizza una variabile di istanza `@step`, che non è impostata in modo esplicito nel metodo stesso. 
Da dove viene questa variabile?
Viene dal secondo *before_action* che è stato creato automaticamente con il *rails g scaffold...*.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
class StepsController < ApplicationController
  before_action :get_lesson
  before_action :set_step, only: [:show, :edit, :update, :destroy]
```

L'azione *update* (come show, edit, and destroy) accetta una variabile `@step` dal metodo `set_step`. 

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
private
...
  def set_step
    @step = Step.find(params[:id])
  end
```

In linea con le azioni che abbiamo già aggiornato, dobbiamo aggiornare anche questo metodo in modo che `@step` si riferisca a un'istanza specifica della *collection* di *steps* che è associata ad una specifica *lesson*. Ricordiamoci del metodo `build`. Grazie alle associazioni tra i nostri modelli e ai metodi (come `build`) che sono disponibili in virtù di tali associazioni, ciascuna delle nostre istanze di *step* fa parte di una collection di oggetti che è associata ad una specifica *lesson*. 
Quindi ha senso che, quando eseguiamo una query per uno specifico *step*, interroghiamo la collection di steps associata ad una specifica lesson.

Aggiorniamo il metodo *set_step*.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
private
...
  def set_step
    @step = @lesson.steps.find(params[:id])
  end
```

Invece di trovare un'istanza specifica dell'intera classe *Step* tramite *id*, cerchiamo invece un *id* corrispondente alla collection di *steps* associati ad una specifica *lesson*.


Adesso passiamo alle azioni di *update* e *destroy*.

L'azione *update* utilizza la variabile di istanza `@step` di `set_step` e la utilizza con `step_params` che l'utente ha inserito nel modulo di modifica (*edit form*). In caso di successo, vogliamo che Rails riporti l'utente alla view *index* degli *steps* associati ad una specifica lezione. In caso di errori, Rails renderà nuovamente la view *edit*.

In questo caso, l'unica modifica che dovremo apportare è all'istruzione `redirect_to`, per gestire gli aggiornamenti che hanno avuto successo. 
La modifichiamo per reindirizzare a `lesson_step_path(@lesson)`, che reindirizzerà alla view *index* di *steps* della *lesson* selezionata.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to lesson_step_path(@lesson), notice: 'Step was successfully updated.' }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end
```

Successivamente, apporteremo una modifica simile all'azione *destroy*. Aggiorniamo l'istruzione *redirect_to* per reindirizzare le richieste a *lesson_steps_path(@lesson)* in caso di successo.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
  def destroy
    @step.destroy
     respond_to do |format|
      format.html { redirect_to lesson_steps_path(@lesson), notice: 'Step was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
```

Questa è l'ultima modifica che facciamo. 
Vediamo lo steps_controller finito.

*** code 04 - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
class StepsController < ApplicationController
.
.
.
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_04-controllers-steps_controller.rb)

Il controller gestisce il modo in cui le informazioni vengono trasmesse dalle *views* al database, tramite i *models*, e viceversa. 
Il nostro controller ora riflette la relazione tra i modelli Lesson e Step, in cui gli steps sono associate a specidiche *lessons*.

Possiamo passare ad aggiornare le views. 
Le views sono i punti in cui gli utenti passeranno e modificheranno le informazioni sugli steps di specifiche lessons.



## Aggiorniamo le *views*

Aggiorneremo tutte le views di *steps* e anche la view *show* di *lessons*, poiché desideriamo che gli utenti vedano gli steps associati a specifiche lezioni.

Iniziamo con partial *_form* che è utilizzato da più *views* di *steps*.

*** code 05 - .../views/steps/_form.html.erb - line:1 ***

```
<%= form_with(model: step, local: true) do |form| %>
  <% if step.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(step.errors.count, "error") %> prohibited this step from being saved:</h2>

      <ul>
        <% step.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= form.label :question %>
    <%= form.text_field :question %>
  </div>

  <div class="field">
    <%= form.label :answer %>
    <%= form.text_area :answer %>
  </div>

  <div class="field">
    <%= form.label :lesson_id %>
    <%= form.text_field :lesson_id %>
  </div>

  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_05-views-steps-_form.html.erb)


Rather than passing only the step model to the form_with form helper, we will pass both the lesson and step models, with step set as a child resource.

Change the first line of the file to look like this, reflecting the relationship between our lesson and step resources:

```
<%= form_with(model: [@lesson, step], local: true) do |form| %>
```

Next, delete the section that lists the lesson_id of the related lesson, since this is not essential information in the view.

The finished form, complete with our edits to the first line and without the deleted lesson_id section, will look like this:

*** code 06 - .../views/steps/_form.html.erb - line:1 ***

```html+erb
<%= form_with(model: [@lesson, step], local: true) do |form| %>
  <% if step.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(step.errors.count, "error") %> prohibited this step from being saved:</h2>

      <ul>
        <% step.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= form.label :question %>
    <%= form.text_field :question %>
  </div>

  <div class="field">
    <%= form.label :answer %>
    <%= form.text_area :answer %>
  </div>

  <!-- da eliminare -->
  <div class="field">
    <%= form.label :lesson_id %>
    <%= form.text_field :lesson_id %>
  </div>
  <!-- da eliminare -->

  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>

```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_06-views-steps-_form.html.erb)


Next, open the index view, which will show the steps associated with a particular lesson:

*** code 07 - .../views/steps/index.html.erb - line:1 ***

```html+erb
<p id="notice"><%= notice %></p>

<h1>Steps</h1>

<table>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_07-views-steps-index.html.erb)

Thanks to the rails generate scaffold command, Rails has generated the better part of the template, complete with a table that shows the question and answer fields of each step and its associated lesson.

Much like the other code we have already modified, however, this template treats steps as independent entities, when we would like to make use of the associations between our models and the collections and helper methods that these associations give us.

In the body of the table, make the following updates:

First, update step.lesson_id to step.lesson.name, so that the table will include the name field of the associated shark, rather than identifying information about the shark object itself:

```
        <td><%= step.lesson.name %></td>
```

Next, change the Show redirect to direct users to the show view for the associated lesson, since they will most likely want a way to navigate back to the original lesson. We can make use of the @lesson instance variable that we set in the controller here, since Rails makes instance variables created in the controller available to all views. We’ll also change the text for the link from Show to Show Lesson, so that users will better understand its function.

Update the this line to the following:

```
        <td><%= link_to 'Show Lesson', [@lesson] %></td>
```

we want to ensure that users are routed the right nested path when they go to edit a step. This means that rather than being directed to steps/step_id/edit, users will be directed to lessons/lesson_id/steps/step_id/edit. To do this, we’ll use the lesson_step_path routing helper and our models, which Rails will treat as URLs. We’ll also update the link text to make its function clearer.

Update the Edit line to look like the following:

```
        <td><%= link_to 'Edit Step', edit_lesson_step_path(@lesson, step) %></td>
```

Next, let’s add a similar change to the Destroy link, updating its function in the string, and adding our lesson and step resources:

```
        <td><%= link_to 'Destroy Step', [@lesson, step], method: :delete, data: { confirm: 'Are you sure?' } %></td>
```

Finally, at the bottom of the form, we will want to update the New Step path to take users to the appropriate nested path when they want to create a new step. Update the last line of the file to make use of the new_lesson_step_path(@lesson) routing helper:

```
<%= link_to 'New Step', new_lesson_step_path(@lesson) %>
```


The finished file will look like this:

*** code 08 - .../views/steps/index.html.erb - line:1 ***

```html+erb
<p id="notice"><%= notice %></p>

<h1>Steps</h1>

<table>
  <thead>
    <tr>
      <th>Question</th>
      <th>Answer</th>
      <th>Lesson</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @steps.each do |step| %>
      <tr>
        <td><%= step.question %></td>
        <td><%= step.answer %></td>
        <td><%= step.lesson.name %></td>
        <td><%= link_to 'Show Lesson', [@lesson] %></td>
        <td><%= link_to 'Edit Step', edit_lesson_step_path(@lesson, step) %></td>
        <td><%= link_to 'Destroy Step', [@lesson, step], method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>

<br>

<%= link_to 'New Step', new_lesson_step_path(@lesson) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_08-views-steps-index.html.erb)


The other edits we will make to step views won’t be as numerous, since our other views use the form partial we have already edited. However, we will want to update the link_to references in the other step templates to reflect the changes we have made to our form partial.

Open app/views/steps/new.html.erb:

*** code 09 - .../views/steps/new.html.erb - line:1 ***

```html+erb
<h1>New Step</h1>

<%= render 'form', step: @step %>

<%= link_to 'Back', steps_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_09-views-steps-new.html.erb)


Update the link_to reference at the bottom of the file to make use of the lesson_steps_path(@lesson) helper:

*** code 10 - .../views/steps/new.html.erb - line:1 ***

```html+erb
<h1>New Step</h1>

<%= render 'form', step: @step %>

<%= link_to 'Back', lesson_steps_path(@lesson) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_10-views-steps-new.html.erb)


Next, open the edit template:

*** code 11 - .../views/steps/edit.html.erb - line:1 ***

```html+erb
<h1>Editing Step</h1>

<%= render 'form', step: @step %>

<%= link_to 'Show', @step %> |
<%= link_to 'Back', steps_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_11-views-steps-edit.html.erb)


In addition to the Back path, we’ll update Show to reflect our nested resources. Change the last two lines of the file to look like this:

*** code 12 - .../views/steps/edit.html.erb - line:1 ***

```html+erb
<h1>Editing Step</h1>

<%= render 'form', step: @step %>

<%= link_to 'Show', [@lesson, @step] %> |
<%= link_to 'Back', lesson_steps_path(@lesson) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_12-views-steps-edit.html.erb)


Next, open the show template:

*** code 13 - .../views/steps/show.html.erb - line:1 ***

```
<p id="notice"><%= notice %></p>

<p>
  <strong>Question:</strong>
  <%= @step.question %>
</p>

<p>
  <strong>Answer:</strong>
  <%= @step.answer %>
</p>

<p>
  <strong>Lesson:</strong>
  <%= @step.lesson_id %>
</p>

<%= link_to 'Edit', edit_step_path(@step) %> |
<%= link_to 'Back', steps_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_13-views-steps-show.html.erb)


Make the following edits to the Edit and Back paths at the bottom of the file:

*** code 14 - .../views/steps/show.html.erb - line:1 ***

```

```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_14-views-steps-show.html.erb)


As a final step, we will want to update the show view for our lessons so that steps are visible for individual lessons. 
Open that file now:

*** code 15 - .../views/lessons/show.html.erb - line:1 ***

```html+erb
<p id="notice"><%= notice %></p>

<p>
  <strong>Name:</strong>
  <%= @lesson.name %>
</p>

<p>
  <strong>Note:</strong>
  <%= @lesson.note %>
</p>

<%= link_to 'Edit', edit_lesson_path(@lesson) %> |
<%= link_to 'Back', lessons_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_15-views-lessons-show.html.erb)


Our edits here will include adding a Steps section to the form and an Add Step link at the bottom of the file.
Below the Facts for a given lesson, we will add a new section that iterates through each instance in the collection of steps associated with this lesson, outputting the body of each step.

```
<h2>Steps</h2>
<% for step in @lesson.steps %>
    <ul>
      <li><%= step.question %></li>
  </ul>
<% end %>
```

Next, add a new redirect to allow users to add a new step for this particular lesson:

```
<%= link_to 'Add Step', lesson_steps_path(@lesson) %> |
```

*** code 16 - .../views/lessons/show.html.erb - line:1 ***

```html+erb
<p id="notice"><%= notice %></p>

<p>
  <strong>Name:</strong>
  <%= @lesson.name %>
</p>

<p>
  <strong>Note:</strong>
  <%= @lesson.note %>
</p>

<h2>Steps</h2>
<% for step in @lesson.steps %>
    <ul>
      <li><%= step.question %></li>
  </ul>
<% end %>

<%= link_to 'Edit', edit_lesson_path(@lesson) %> |
<%= link_to 'Add Step', lesson_steps_path(@lesson) %> |
<%= link_to 'Back', lessons_path %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_16-views-lessons-show.html.erb)

You have now made changes to your application’s models, controllers, and views to ensure that steps are always associated with a particular lesson.

