# <a name="top"></a> Cap 3.1 - Prepariamo le lezioni

Le lezioni sono le varie aule di visualizzazione guidata. Nello specifico quelle di livello base, ossia quelle che ci preparano ai percorsi più strutturati.

In questo capitolo lavoreremo principalmente lato database. Creeremo la tabella lezioni, lessons, e metteremo i seed iniziali ed alcuni dati di prova. Non avremo nessuna interazione lato views e quindi non apriremo il browser per usare la web gui.
Eseguendo gli scaffolds la web gui è creata in automatico ma in questo capitolo non la utilizzeremo. Utilizzeremo invece la console di rails `$ rails c`.


## Risorse interne

- [99-code_references/active_records/20_00-sharks_and_posts](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/active_records/20_00-sharks_and_posts.md)



## Risorse esterne

- [How To Create Nested Resources for a Ruby on Rails Application](https://www.digitalocean.com/community/tutorials/how-to-create-nested-resources-for-a-ruby-on-rails-application)



## Apriamo il branch "Lessons Seeds"

```bash
$ git checkout -b ls
```



## Progettiamo la tabela lessons

Abbiamo diviso le varie colonne della tabella in principali e secondarie perché non implementeremo tutte le colonne da subito ma iniziamo con le principali e poi aggiungiamo le altre di volta in volta facendo dei migrate di aggiunta ed aggiornando controller, model e views.

Colonne principali:

- name:string             -> (255 caratteri) Nome esercizio / aula / lezione  (es: View of mount Vermon, The isle of the death, ...) - Questo appare nelle cards nell'index
- duration:integer        -> quanto dura l'esercizio in media. (Uso un numero intero che mi rappresenta i **minuti** di durata. es: 90 minuti, 180 minuti, ...)


Colonne secondarie:

- Categoria/Tag               -> 7. Interpretazione, Dipinto, Suoni ambiente, ...
                                (vedi gemma taggable)
- blocco (lucchetto)          -> lock_value_percorsocoach1 (livello a cui devi essere per sbloccarlo?) 
                              -> lock_value_percorsocoach2 (indipendente dal percorsocoach1 )
                               Quindi metto tante colonne quanti sono i percorsicoach (attualmente è 1 solo ^_^)
- note:text               -> (molti caratteri) Note Aggiuntive - questo appare nello show. è un approfondimento sull'esercizio
- meta_title:string       -> Per il SEO
- meta_description:string -> Per il SEO


Tabelle collegate 1-a-molti (non ho campi di chiave esterna perché saranno sull'altra tabella)

-  steps    -> una lezione è collegata a vari steps: azioni richieste (spesso sono domande a cui rispondere).


Tabelle collegate molti-a-1 (chiavi esterne)

-  tags?!?  -> vedi gemma taggable



## Impementiamo tabella lessons

Creiamo la tabella iniziale con le sole colonne principali.

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.

I> ATTENZIONE: con "rails generate scaffold ..." -> usiamo il SINGOLARE

```bash
$ rails g scaffold Lesson name:string duration:integer
```


vediamo il migrate generato

*** code 01 - .../db/migrate/xxx_create_lessons.rb - line:1 ***

```ruby
class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :name
      t.integer :duration

      t.timestamps
    end
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_01-db-migrate-xxx_create_lessons.rb)


Effettuiamo il migrate del database per creare la tabella sul database.

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "add scaffold Lesson"
```



## Progettiamo la tabela steps

Abbiamo diviso le varie colonne della tabella in principali e secondarie perché non implementeremo tutte le colonne da subito ma iniziamo con le principali e poi aggiungiamo le altre di volta in volta facendo dei migrate di aggiunta ed aggiornando controller, model e views.

Colonne principali:

- question:string         -> (100 caratteri) Le domande per aiutarti a immaginare
- answer:text             -> (molti caratteri) Le risposte scritte dall'utente (Attenzione! più avanti si toglierà da qui e si creerà una tabella answers da associare a users perché ogni utente avrà le sue personali risposte.)


Colonne secondarie:

- nessuna


Tabelle collegate 1-a-molti (non ho campi di chiave esterna perché saranno sull'altra tabella)

-  nessuna


Tabelle collegate molti-a-1 (chiavi esterne)

-  lesson:references

La cosa bella di " user:references " è che, oltre a creare un migration "ottimizzato" per la relazione uno a molti, ci predispone parte della relazione uno-a-molti anche lato model.



## Impementiamo tabella Steps

Creiamo la tabella con i vari passi di ogni lezione.

Usiamo lo Scaffold che mi imposta già l'applicazione in stile restful con le ultime convenzioni Rails.

I> ATTENZIONE: con "rails generate scaffold ..." -> usiamo il SINGOLARE

```bash
$ rails g scaffold Step question:string answer:text lesson:references
```

l'attributo `:references` imposta un'associazione tra i modelli *Lesson* e *Step*. Nello specifico, assicura che una chiave esterna che rappresenta ogni voce di lezione nella tabella del database delle lezioni venga aggiunta alla tabella del database dei passi.
(This will ensure that a foreign key representing each lesson entry in the lessons database's table is added to the steps database's table.)

vediamo il migrate generato

*** code 02 - .../db/migrate/xxx_create_steps.rb - line:1 ***

```ruby
class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.string :question
      t.text :answer
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_02-db-migrate-xxx_create_steps.rb)

Come puoi vedere, la tabella include una colonna per una chiave esterna di lezione (lesson foreign key). Questa chiave assumerà la forma di *[model_name]_id*. (nel nostro caso: *lesson_id*).


Effettuiamo il migrate del database per creare la tabella sul database

```bash
$ sudo service postgresql start
$ rails db:migrate
```



## Aggiungiamo la relazione uno-a-molti

Verifichiamo la relazione nel model Step, aggiungiamo i commenti e la mettiamo su "# == Relationships".

*** code 03 - .../app/models/step.rb - line:11 ***

```ruby
class Step < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================

  ## many-to-one
  belongs_to :lesson

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_03-models-step.rb)


Verifichiamo la relazione nel model Lesson, aggiungiamo i commenti e la mettiamo su "# == Relationships".

*** code 04 - .../app/models/lesson.rb - line:11 ***

```ruby
class Lesson < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================

  ## many-to-one
  has_many :steps, dependent: :destroy

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_04-models-lesson.rb)


Analizziamo il codice:

- dependent: :destroy -> questa opzione fa in modo che quando eliminiamo una lezione in automatico vengano eliminati anche tutti i suoi steps.



## Instradamenti annidati (Nested Routes)

In automatico, con il *generate scaffold...* sono state create due voci distinte per gli instradamenti *Restful*.

*** code 05 - .../config/routes.rb  - line:11 ***

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

*** code 06 - .../config/routes.rb  - line:11 ***

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

*** code 07 - .../app/controllers/steps_controller.rb - line:11 ***

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

```ruby
private
  def get_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
```

Next, add the corresponding filter to the top of the file, before the existing filter:

```
class StepsController < ApplicationController
  before_action :get_lesson
```

This will ensure that get_lesson runs before each action defined in the file.

Next, you can use this @lesson instance to rewrite the index method. Instead of grabbing all instances of the Step class, we want this method to return all step instances associated with a particular lesson instance.

Modify the index method to look like this:

```
  def index
    @steps = @lesson.steps
  end
```

The new method will need a similar revision, since we want a new step instance to be associated with a particular lesson. To achieve this, we can make use of the build method, along with our local @lesson instance variable.

Change the new method to look like this:

```
  def new
    @step = @lesson.steps.build
  end
```

This method creates a step object that’s associated with the specific lesson instance from the get_lesson method.

Next, we’ll address the method that’s most closely tied to new: create. The create method does two things: it builds a new step instance using the parameters that users have entered into the new form, and, if there are no errors, it saves that instance and uses a route helper to redirect users to where they can see the new step. In the case of errors, it renders the new template again.

Update the create method to look like this:

```
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

Next, take a look at the update method. This method uses a @step instance variable, which is not explicitly set in the method itself. Where does this variable come from?

Take a look at the filters at the top of the file. The second, auto-generated before_action filter provides an answer:

```
class StepsController < ApplicationController
  before_action :get_lesson
  before_action :set_step, only: [:show, :edit, :update, :destroy]
```

The update method (like show, edit, and destroy) takes a @step variable from the set_step method. That method, listed under the get_lesson method with our other private methods, currently looks like this:

```
private
...
  def set_step
    @step = Step.find(params[:id])
  end
```

In keeping with the methods we’ve used elsewhere in the file, we will need to modify this method so that @step refers to a particular instance in the collection of steps that’s associated with a particular lesson. Keep the build method in mind here — thanks to the associations between our models, and the methods (like build) that are available to us by virtue of those associations, each of our step instances is part of a collection of objects that’s associated with a particular lesson. So it makes sense that when querying for a particular step, we would query the collection of steps associated with a particular lesson.

Update set_step to look like this:

```
private
...
  def set_step
    @step = @lesson.steps.find(params[:id])
  end
```

Instead of finding a particular instance of the entire Step class by id, we instead search for a matching id in the collection of steps associated with a particular lesson.

With that method updated, we can look at the update and destroy methods.

The update method makes use of the @step instance variable from set_step, and uses it with the step_params that the user has entered in the edit form. In the case of success, we want Rails to send the user back to the index view of the steps associated with a particular lesson. In the case of errors, Rails will render the edit template again.

In this case, the only change we will need to make is to the redirect_to statement, to handle successful updates. Update it to redirect to lesson_step_path(@lesson), which will redirect to the index view of the selected lesson’s steps:

```
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

Next, we will make a similar change to the destroy method. Update the redirect_to method to redirect requests to lesson_steps_path(@lesson) in the case of success:

```
  def destroy
    @step.destroy
     respond_to do |format|
      format.html { redirect_to lesson_steps_path(@lesson), notice: 'Step was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
```

This is the last change we will make. You now have a steps controller file that looks like this:

{id: "56-03-01_09", caption: ".../app/controllers/steps_controller.rb -- codice 09", format: ruby, line-numbers: true, number-from: 11}
```
class StepsController < ApplicationController
.
.
.
```

[tutto il codice](#56-03-01_09all)


The controller manages how information is passed from the view templates to the database and vice versa. Our controller now reflects the relationship between our Lesson and Step models, in which steps are associated with particular lessons. 
We can move on to modifying the view templates themselves, which are where users will pass in and modify step information about particular lessons.




## Modifying Views

Our view template revisions will involve changing the templates that relate to steps, and also modifying our lessons show view, since we want users to see the steps associated with particular lessons.

Let’s start with the foundational template for our steps: the form partial that is reused across multiple step templates:

{id: "56-03-01_10", caption: ".../views/steps/_form.html.erb -- codice 10", format: HTML+Mako, line-numbers: true, number-from: 1}
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

[tutto il codice](#56-03-01_10all)


Rather than passing only the step model to the form_with form helper, we will pass both the lesson and step models, with step set as a child resource.

Change the first line of the file to look like this, reflecting the relationship between our lesson and step resources:

```
<%= form_with(model: [@lesson, step], local: true) do |form| %>
```

Next, delete the section that lists the lesson_id of the related lesson, since this is not essential information in the view.

The finished form, complete with our edits to the first line and without the deleted lesson_id section, will look like this:

{id: "56-03-01_11", caption: ".../views/steps/_form.html.erb -- codice 11", format: HTML+Mako, line-numbers: true, number-from: 1}
```
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

[tutto il codice](#56-03-01_11all)



Next, open the index view, which will show the steps associated with a particular lesson:

{id: "56-03-01_12", caption: ".../views/steps/index.html.erb -- codice 11", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<p id="notice"><%= notice %></p>

<h1>Steps</h1>

<table>
```

[tutto il codice](#56-03-01_12all)

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

{id: "56-03-01_13", caption: ".../views/steps/index.html.erb -- codice 13", format: HTML+Mako, line-numbers: true, number-from: 1}
```
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

[tutto il codice](#56-03-01_13all)


The other edits we will make to step views won’t be as numerous, since our other views use the form partial we have already edited. However, we will want to update the link_to references in the other step templates to reflect the changes we have made to our form partial.

Open app/views/steps/new.html.erb:


{id: "56-03-01_14", caption: ".../views/steps/new.html.erb -- codice 14", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h1>New Step</h1>

<%= render 'form', step: @step %>

<%= link_to 'Back', steps_path %>
```

[tutto il codice](#56-03-01_14all)


Update the link_to reference at the bottom of the file to make use of the lesson_steps_path(@lesson) helper:

{id: "56-03-01_15", caption: ".../views/steps/new.html.erb -- codice 15", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h1>New Step</h1>

<%= render 'form', step: @step %>

<%= link_to 'Back', lesson_steps_path(@lesson) %>
```

[tutto il codice](#56-03-01_15all)


Next, open the edit template:

{id: "56-03-01_16", caption: ".../views/steps/edit.html.erb -- codice 16", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h1>Editing Step</h1>

<%= render 'form', step: @step %>

<%= link_to 'Show', @step %> |
<%= link_to 'Back', steps_path %>
```

[tutto il codice](#56-03-01_16all)


In addition to the Back path, we’ll update Show to reflect our nested resources. Change the last two lines of the file to look like this:

{id: "56-03-01_17", caption: ".../views/steps/edit.html.erb -- codice 17", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<h1>Editing Step</h1>

<%= render 'form', step: @step %>

<%= link_to 'Show', [@lesson, @step] %> |
<%= link_to 'Back', lesson_steps_path(@lesson) %>
```

[tutto il codice](#56-03-01_17all)


Next, open the show template:

{id: "56-03-01_18", caption: ".../views/steps/show.html.erb -- codice 18", format: HTML+Mako, line-numbers: true, number-from: 1}
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

[tutto il codice](#56-03-01_18all)


Make the following edits to the Edit and Back paths at the bottom of the file:

{id: "56-03-01_19", caption: ".../views/steps/show.html.erb -- codice 19", format: HTML+Mako, line-numbers: true, number-from: 1}
```

```

[tutto il codice](#56-03-01_19all)


As a final step, we will want to update the show view for our lessons so that steps are visible for individual lessons. 
Open that file now:

{id: "56-03-01_20", caption: ".../views/lessons/show.html.erb -- codice 20", format: HTML+Mako, line-numbers: true, number-from: 1}
```
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

[tutto il codice](#56-03-01_20all)


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


{id: "56-03-01_21", caption: ".../views/lessons/show.html.erb -- codice 21", format: HTML+Mako, line-numbers: true, number-from: 1}
```
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

[tutto il codice](#56-03-01_21all)

You have now made changes to your application’s models, controllers, and views to ensure that steps are always associated with a particular lesson.

















## seed 

Popoliamo le tabelle in automatico con un solo record. Nel prossimo paragrafo aggiungiamo altri records manualmente.

{id: "01-08-01_01", caption: ".../db/seeds.rb -- codice 03", format: ruby, line-numbers: true, number-from: 29}
```
puts "setting the Company data with I18n :en :it"
Company.new(name: "ABC srl", building: "Roma's office", sector: "Chemical", locale: :en).save
Company.last.update(building: "Ufficio di Roma", sector: "Chimico", locale: :it)

puts "setting the Company data with I18n :en :it"
Company.new(name: "ABC srl", building: "Roma's office", sector: "Chemical", locale: :en).save
Company.last.update(building: "Ufficio di Roma", sector: "Chimico", locale: :it)
```


Aggiungiamo il seme/record alla tabella.

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails db:seed
```

I> Nota: "$ rails db:setup" avrebbe svuotato la tabella prima di inserire il record.




## Salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add seed companies"
```




## Popoliamo manualmente la tabella

Usiamo la console di rails per popolare la tabella del database.


{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails c
> Company.new(name: "DEF srl", sector: "Pharmaceutical", locale: :en).save
> Company.last.update(sector: "Farmaceutico", locale: :it)

> Company.all
> c1 = Company.first
> c1.sector
> I18n.locale
> I18n.locale = :en
> c1.sector

> Company.new(name:"GHI SpA", sector:"Breweries").save
> c3 = Company.last
> c3.sector
> I18n.locale = :it
> c3.sector
> c3.sector = "Birrerie"
> c3.sector
> c3.save

> c2 = Company.find 2

> exit
```




## Salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "add companies Manually"
```

I> Nota: Questo git commit è solo per lasciare un commento perché le modifiche fatte sul database non sono passate tramite git.




## Publichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku cs:master
$ heroku run rake db:migrate
```

I> Lato produzione su heroku c'è un database indipendente da quello di sviluppo quindi risulta vuoto.

per popolare il database di heroku basta aprire la console con il comando:

{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku run rails db:seed
$ heroku run rails c
```

E rieseguire i passi già fatti nel paragrafo precedentemente


Verifichiamo preview su heroku.

Andiamo all'url:

* https://elisinfo.herokuapp.com/companies

E verifichiamo che l'elenco delle aziende è popolato.




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge cs
$ git branch -d cs
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```
