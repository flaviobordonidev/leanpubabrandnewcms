# <a name="top"></a> Cap 3.2 - Instradamenti annidati

In questo capitolo creiamo degli instradamneti annidati `lessons/#/steps/#` ed aggiorniamo i relativi controllers e le views.


## Risorse interne

- [99-code_references/active_records/20_00-sharks_and_posts](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/99-code_references/active_records/20_00-sharks_and_posts.md)



## Apriamo il branch "Lessons Seeds"

Continuiamo con il branch aperto nei capitoli precedenti.



## Instradamenti annidati (Nested Routes)

In automatico, con il *generate scaffold...* sono state create due voci distinte per gli instradamenti *Restful*.

*** code 01 - .../config/routes.rb  - line:11 ***

```ruby
  resources :steps
  resources :lessons
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_01-config-routes.rb)

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
  resources :lessons do
    resources :steps
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_02-config-routes.rb)



## Aggiorniamo il controller *steps*

Implementiamo l'associazione "figlio" di *steps* rispetto a *lessons*.
L'associazione tra i nostri modelli ci fornisce la possibilità di creare nuove istanze di *steps* associate a specifiche *lessons*.

Vediamo il controller *steps* creato dallo scaffold.

*** code 03 - .../app/controllers/steps_controller.rb - line:1 ***

```ruby
class StepsController < ApplicationController
  before_action :set_step, only: %i[ show edit update destroy ]

  # GET /steps or /steps.json
  def index
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_03-controllers-steps_controller.rb)

I metodi del controller, chiamati *azioni*, funzionano con le istanze della classe *Step* associata. 
Ad esempio, l'azione `new` crea una nuova istanza della classe *Step*, l'azione `index` acquisisce tutte le istanze della classe e l'azione `set_step` usa **find** e **params** per selezionare uno specifica istanza di `step` tramite **id**. 

Ma noi vogliamo che le istanze di `step` siano associate a specifiche istanze di `lesson`, quindi dobbiamo modificare questo codice, perché la classe `Step` sta attualmente operando come un'entità indipendente.

L'associazione ed il routing annidato ci rendono disponibili instradamenti di collezioni di *steps* associati a specifiche *lessons*. Esempio: `lessons/1/steps`. 
Ci sono anche helpers di instradamento come `lesson_steps_path(@lesson)` e `edit_lessons_steps_path(@lesson)` che fanno riferimento a questi percorsi annidati.

Iniziamo scrivendo il metodo, `set_lesson`, che verrà eseguito prima di ogni azione nel controller. Questo metodo creerà una variabile di istanza locale `@lesson` trovando un'istanza di lezione da `lesson_id`. Con questa variabile a nostra disposizione, sarà possibile correlare i passaggi a una lezione specifica negli altri metodi.

> In pratica `set_lesson` è quasi identico a quello del `lessons_controller`. La differenza è che in questo caso usiamo la chiave esterna `lesson_id` perché siamo sullo `steps_controller`.

Aggiungiamo il metodo nella sezione *private*.

*** code n/a - .../app/controllers/steps_controller.rb - line:11 ***

```ruby
private
  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
```

Quindi, aggiungiamo il relativo *before_action*.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
class StepsController < ApplicationController
  before_action :set_lesson
```

Ciò garantirà che `set_lesson` sia eseguito prima di ogni altra azione.

Successivamente, utilizziamo questa istanza `@lesson` per riscrivere il metodo index. Invece di acquisire tutte le istanze della classe `Step`, vogliamo che questo metodo restituisca tutte le istanze di `step` **associate** a una specifica istanza di `lesson`.

Aggiorniamo l'azione *index*.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
  def index
    @steps = @lesson.steps
  end
```

L'azione `new` ha bisogno di una revisione simile, poiché vogliamo che una nuova istanza di `step` sia associata a una particolare `lesson`. Per ottenere ciò, possiamo utilizzare il metodo `build`, insieme alla nostra variabile di istanza locale `@lesson`.

> Da Rails 4 `build` è un alias di `new` quindi possiamo usare `new`

Aggiorniamoa l'azione *new*.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
  def new
    #@step = @lesson.steps.build
    @step = @lesson.steps.new
  end
```

Questa azione crea un oggetto `step` che è associato ad una specifica istanza di `lesson` richiamata con il metodo `set_lesson`.


Aggiorniamo l'azione *create*.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
def create
  #@step = @lesson.steps.build(step_params)
  @step = @lesson.steps.new(step_params)
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

L'azione `create` fa due cose: crea una nuova istanza di *step* usando i parametri che gli utenti hanno inserito nel *form new* e, se non ci sono errori, salva quell'istanza e usa il route helper `redirect_to` per reindirizzare gli utenti a dove possono vedere il nuovo *step*. In caso di errori, esegue nuovamente il rendering del *form new*.

Aggiorniamo l'azione *update*. 

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
  # PATCH/PUT /steps/1 or /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
```

L'aggiornamento lo facciamo nel metodo `set_step`. L'azione *update* (come show, edit, and destroy) accetta una variabile `@step` dal metodo `set_step` che è richiamato dal *before_action*.

- `before_action :set_step, only: [:show, :edit, :update, :destroy]`
- `set_step` -> `@step = Step.find(params[:id])`

In linea con le azioni che abbiamo già aggiornato, aggiorniamo anche questo metodo in modo che `@step` si riferisca a un'istanza specifica della *collection* di *steps* che è associata ad una specifica *lesson*. 

Aggiorniamo il metodo *set_step*.

*** code n/a - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
private
...
  def set_step
    @step = @lesson.steps.find(params[:id])
  end
```

Invece di trovare un'istanza specifica dell'intera classe *Step* tramite *id*, cerchiamo un *id* corrispondente alla collection di *steps* associati ad una specifica *lesson*.


Aggiorniamo l'azione *update*.

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

> `lesson_step_path(@lesson)` reindirizza alla view *index* di *steps* della *lesson* selezionata.
          steps

Aggiorniamo l'azione *destroy*.

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

> `lesson_steps_path(@lesson)` reindirizza alla view *index* di *steps* della *lesson* selezionata.


Vediamo lo *steps_controller* finito.

*** code 04 - .../app/controllers/steps_controller.rb - line:2 ***

```ruby
class StepsController < ApplicationController
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_04-controllers-steps_controller.rb)

Il nostro controller ora riflette la relazione tra i modelli Lesson e Step, in cui gli steps sono associate a specidiche *lessons*.

Possiamo passare ad aggiornare le views. 



## Aggiorniamo le *views*

Il comando `rails generate scaffold`, ha generato delle views che trattano gli *steps* come entità indipendenti.

Quindi aggiorniamo per riflettere l'annidamento `lessons/#/steps/#`.

Iniziamo con il partial *_form*.

*** code 05 - .../views/steps/_form.html.erb - line:1 ***

```html+erb
<%#= form_with(model: step, local: true) do |form| %>
<%= form_with(model: [@lesson, step], local: true) do |form| %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_05-views-steps-_form.html.erb)

L'unica modifica è da `form_with(model: step)` a `form_with(model: [@lesson, step])`.

> Passiamo al parametro `model:` di `form_with` l'array `[@lesson, step]` invece della sola voce `step`. In questo modo stiamo passiamo `lesson` con `step` annidato.

> Prima di rails 7 era importante inserire il parametro `local: true`: <br/>
> `<%= form_with(model: step, local: true) do |form| %>` <br/>
> Ma da rails 7 questo parametro è impostato di default quindi si può evitare di inserirlo.



Aggiorniamo il partial *_steps*.

*** code 06 - .../views/steps/_steps.html.erb - line:14 ***

```html+erb
    <%#= step.lesson_id %>
    <%= step.lesson.name %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_06-views-steps-_steps.html.erb)


Aggiorniamo la view *index*.

> Mostriamo l'elenco, o *collection*, di *steps* associati ad una specifica lezione (*lesson*).

*** code 07 - .../views/steps/index.html.erb - line:9 ***

```html+erb
      <%#= link_to "Show this step", step %>
      <%= link_to "Show this step", lesson_step_path(@lesson, step) %>
      <%= link_to 'Show this Lesson', [@lesson] %>
```

> Invece di indirizzare a `steps/id`, indirizziamo a `lessons/lesson_id/steps/id`.
> Perché abbiamo un instradamento annidato `lessons/#/steps/#`. <br/>
> Inoltre aggiungiamo indirizzamento a `lessons/lesson_id`. 


*** code 07 - ...continua - line:15 ***

```html+erb
<%#= link_to "New step", new_step_path %>
<%= link_to 'New Step', new_lesson_step_path(@lesson) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_07-views-steps-index.html.erb)


> Invece di indirizzare a `steps/new`, indirizziamo a `lessons/lesson_id/steps/new`. 
> Per farlo usiamo l'helper di routing `new_lesson_step_path(@lesson)`.


Aggiorniamo la view *show*.

*** code 08 - .../views/steps/show.html.erb - line:6 ***

```html+erb
  <%#= link_to "Edit this step", edit_step_path(@step) %>
  <%= link_to 'Edit this step', edit_lesson_step_path(@lesson, @step) %> |
  <%#= link_to "Back to steps", steps_path %>
  <%= link_to 'Back to lesson steps', lesson_steps_path(@lesson) %>

  <%#= button_to "Destroy this step", @step, method: :delete %>
  <%= button_to "Destroy this step", [@lesson, @step], method: :delete %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_08-views-steps-show.html.erb)

> Invece di indirizzare a `steps/step_id/edit`, indirizziamo a `lessons/lesson_id/steps/step_id/edit`. 
> Per farlo usiamo l'helper di routing `lesson_step_path`.

> Impostiamo il percorso annidato corretto per il link *Destroy*.


Aggiorniamo la view *new*.

*** code 09 - .../views/steps/new.html.erb - line:8 ***

```html+erb
  <%#= link_to "Back to steps", steps_path %>
  <%= link_to "Back to lesson steps", lesson_steps_path(@lesson) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_09-views-steps-new.html.erb)

> Aggiorniamo i riferimenti `link_to` per riflettere le modifiche che abbiamo apportato al nostro *partial _form*. Utilizziamo l'helper `lesson_steps_path(@lesson)`.


Aggiorniamo la view *edit*.

*** code 10 - .../views/steps/edit.html.erb - line:8 ***

```html+erb
  <%#= link_to "Show this step", @step %> |
  <%= link_to "Show this step", [@lesson, @step] %> |
  <%#= link_to "Back to steps", steps_path %>
  <%= link_to "Back to steps", lesson_steps_path(@lesson) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_10-views-steps-edit.html.erb)



## Visualizziamo preview

I links non sono ancora completamente attivi...

Attiviamo il preview

Andando sugli specifici urls vediamo l'annidamento

- http://192.168.64.3:3000/lessons/1/steps
- http://192.168.64.3:3000/lessons/1/steps/1
- http://192.168.64.3:3000/lessons/1/steps/2
- http://192.168.64.3:3000/lessons/2/steps
- http://192.168.64.3:3000/lessons/2/steps/3
- http://192.168.64.3:3000/lessons/2/steps/3/edit
- http://192.168.64.3:3000/lessons/2/steps/new


## Aggiorniamo git

```bash
$ git add -A
$ git commit -m "Nest routes lessons-steps"
```



## Andiamo in produzione

```bash
$ git push heroku lp:main
```



## Chiudiamo il branch

Lo chiudiamo nel prossimo capitolo.


se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge cs
$ git branch -d cs
```



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_00-lessons_seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/03_00-lessons_parent-it.md)
