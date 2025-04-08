# <a name="top"></a> Cap 15.2 - Annidiamo gli steps

In questo capitolo creiamo gli instradamneti annidati `lessons/:id/steps/:id` ed aggiorniamo i relativi controllers e le views.

In pratica:

- le `lessons` diventano i *parents* degli `steps`.
- gli `steps` diventano i *children* delle `lessons`.



## Risorse interne

- [code_references/active_records-associations/20_00-sharks_and_posts](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/code_references/active_records-associations/20_00-sharks_and_posts.md)



## Instradamenti annidati (Nested Routes)

In automatico, con il *generate scaffold...* sono state create due voci distinte per gli instradamenti *Restful*.

***Codice 01 - .../config/routes.rb  - linea:02***

```ruby
  resources :steps
  resources :lessons
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_01-config-routes.rb)

L'attuale codice stabilisce una relazione indipendente tra i nostri instradamenti (routes), quando ciò che vorremmo esprimere è una relazione di dipendenza tra le lezioni (:lessons) e i loro passi (:steps) associati.

Vogliamo che siano annidate: `lessons/:id/steps/:id`.

Ad esempio:

- la `lessons/1` ha gli steps da `steps/1` a `steps/17`.
- la `lessons/2` ha gli steps da `steps/18` e `steps/35`.
- ... 
- la `lessons/12` ha gli steps da `steps/254` e `steps/276`.
- e così via.


Aggiorniamo i nostri istradamenti (routes) per rendere `:lessons` il *genitore* (parent) di `:steps`. 

***Codice 02 - .../config/routes.rb  - linea:11***

```ruby
  resources :lessons do
    resources :steps
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_02-config-routes.rb)



## Aggiorniamo il controller *steps*

Implementiamo l'associazione *figlio* (child) di `steps` rispetto a `lessons`.
L'associazione tra i nostri modelli ci fornisce la possibilità di creare nuove istanze di `steps` associate a specifiche `lessons`.

Vediamo il controller `steps` creato dallo scaffold.

***Codice 03 - .../app/controllers/steps_controller.rb - linea:01***

```ruby
class StepsController < ApplicationController
  before_action :set_step, only: %i[ show edit update destroy ]

  # GET /steps or /steps.json
  def index
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_03-controllers-steps_controller.rb)

Le *azioni* del controller, ossia i suoi *metodi*, agiscono sulle istanze della classe *Step* associata. 
Ad esempio, l'azione `new` crea una nuova istanza della classe *Step*, l'azione `index` acquisisce tutte le istanze della classe e l'azione `set_step` usa **find** e **params** per selezionare una specifica istanza di `step` tramite l'**id**. 

Ma noi vogliamo che le istanze di `step` siano associate a specifiche istanze di `lesson`, quindi dobbiamo modificare questo codice, perché la classe `Step` sta attualmente operando come un'entità indipendente.

L'associazione ed il routing annidato ci rendono disponibili instradamenti di collezioni di *steps* associati a specifiche *lessons*. Esempio: `lessons/1/steps`. 
Ci sono anche helpers di instradamento come `lesson_steps_path(@lesson)` e `edit_lessons_steps_path(@lesson)` che fanno riferimento a questi percorsi annidati.

Iniziamo scrivendo il metodo, `set_lesson`, che verrà eseguito prima di ogni azione nel controller. Questo metodo creerà una variabile di istanza locale `@lesson` trovando un'istanza di lezione da `lesson_id`. Con questa variabile a nostra disposizione, sarà possibile correlare i passaggi a una lezione specifica negli altri metodi.

> In pratica `set_lesson` è quasi identico a quello del `lessons_controller`. La differenza è che in questo caso usiamo la chiave esterna `lesson_id` perché siamo sullo `steps_controller`.

Aggiungiamo il metodo nella sezione *private*.

***Codice 04 - .../app/controllers/steps_controller.rb - linea:67***

```ruby
    def set_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end
```

Quindi, aggiungiamo il relativo *before_action*.

***Codice 04 - ...continua - linea:02***

```ruby
class StepsController < ApplicationController
  before_action :set_lesson
```

Ciò garantirà che `set_lesson` sia eseguito prima di ogni altra azione.

Successivamente, utilizziamo questa istanza `@lesson` per riscrivere il metodo index. Invece di acquisire tutte le istanze della classe `Step`, vogliamo che questo metodo restituisca tutte le istanze di `step` **associate** a una specifica istanza di `lesson`.

Aggiorniamo l'azione `index`.

***Codice 04 - ...continua - linea:05***

```ruby
  # GET /steps or /steps.json
  def index
    #@steps = Step.all
    @steps = @lesson.steps
  end
```

L'azione `new` ha bisogno di una revisione simile, poiché vogliamo che una nuova istanza di `step` sia associata a una particolare `lesson`. 

Aggiorniamoa l'azione *new*.

***Codice 04 - ...continua - linea:15***

```ruby
  # GET /steps/new
  def new
    #@step = Step.new
    @step = @lesson.steps.new
  end
```

Questa azione crea un oggetto `step` che è associato ad una specifica istanza di `lesson` richiamata con il metodo `set_lesson`.

> Potevamo utilizzare il metodo `build`, insieme alla nostra variabile di istanza locale `@lesson`: <br/>
> `@step = @lesson.steps.build` <br/>
> Da Rails 4 `build` è un alias di `new` quindi possiamo usare `new`.



## Aggiorniamo l'azione ***create***.

Controller: `steps` - azione:`create`

***Codice 04 - ...continua - linea:25***

```ruby
  # POST /steps or /steps.json
  def create
    #@step = Step.new(step_params)
    @step = @lesson.steps.new(step_params)

    respond_to do |format|
      if @step.save
        #format.html { redirect_to step_url(@step), notice: "Step was successfully created." }
        format.html { redirect_to lesson_steps_path(@lesson), notice: 'Step was successfully created.' }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end
```

> Potevamo usare `.build`: `@step = @lesson.steps.build(step_params)` ma preferisco `.new`

L'azione `create` fa due cose: crea una nuova istanza di *step* usando i parametri che gli utenti hanno inserito nel *form new* e, se non ci sono errori, salva quell'istanza e usa il route helper `redirect_to` per reindirizzare gli utenti a dove possono vedere il nuovo *step*. In caso di errori, esegue nuovamente il rendering del *form new*.



## Aggiorniamo l'azione ***update***

Controller: `steps` - azione:`update`

***Codice 04 - ...continua - linea:02***

```ruby
  # PATCH/PUT /steps/1 or /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        #format.html { redirect_to step_url(@step), notice: "Step was successfully updated." }
        format.html { redirect_to lesson_step_path(@lesson), notice: 'Step was successfully updated.' }
```

> `lesson_step_path(@lesson)` reindirizza alla view *index* di *steps* della *lesson* selezionata.


Inoltre modifichiamo il metodo `set_step`. 
L'azione *update* (come show, edit, and destroy) accetta una variabile `@step` dal metodo `set_step` che è richiamato dal *before_action*: `before_action :set_step, only: [:show, :edit, :update, :destroy]`.

In linea con le azioni che abbiamo già aggiornato, aggiorniamo anche questo metodo in modo che `@step` si riferisca a un'istanza specifica della *collection* di *steps* che è associata ad una specifica *lesson*. 

Controller: `steps` - metodo: `private` -> `set_step`.

***Codice 04 - ...continua - linea:02***

```ruby
  def set_step
    #@step = Step.find(params[:id])
    @step = @lesson.steps.find(params[:id])
  end
```

> Invece di trovare un'istanza specifica dell'intera classe *Step* tramite *id*, cerchiamo un *id* corrispondente alla collection di *steps* associati ad una specifica *lesson*.
>
> Questa parte potevamo anche lasciarla com'era tanto lo step-id su params[:id] è univoco per ogni step.
>
> Facciamo questa "forzatura" `@lesson.steps.` per allineare il codice e crea anche un minimo di sicurezza in più perché se passiamo uno step-id di un'altra lezione ci da errore.



## Aggiorniamo l'azione ***destroy***

Controller: `steps` - azione:`destroy`

***Codice 04 - ...continua - linea:02***

```ruby
  # DELETE /steps/1 or /steps/1.json
  def destroy
    @step.destroy

    respond_to do |format|
      #format.html { redirect_to steps_url, notice: "Step was successfully destroyed." }
      format.html { redirect_to lesson_steps_path(@lesson), notice: 'Step was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/02_04-controllers-steps_controller.rb)

> `lesson_steps_path(@lesson)` reindirizza alla view *index* di *steps* della *lesson* selezionata.

Il nostro controller ora riflette la relazione tra i modelli Lesson e Step, in cui gli steps sono associate a specidiche *lessons*.

Possiamo passare ad aggiornare le views. 



## Aggiorniamo le *views*

Il comando `rails generate scaffold`, ha generato delle views che trattano gli *steps* come entità indipendenti.

Quindi aggiorniamo per riflettere l'annidamento `lessons/:id/steps/:id`.

Iniziamo con il partial *_form*.



## Aggiorniamo `steps/_form`

***Codice 05 - .../views/steps/_form.html.erb - linea:1***

```html+erb
<%#= form_with(model: step) do |form| %>
<%= form_with(model: [@lesson, step]) do |form| %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-lessons-steps/02_05-views-steps-_form.html.erb)

L'unica modifica è da `form_with(model: step)` a `form_with(model: [@lesson, step])`.

> Passiamo al parametro `model:` di `form_with` l'array `[@lesson, step]` invece della sola voce `step`. In questo modo stiamo passiamo `lesson` con `step` annidato.

> Prima di rails 7 era importante inserire il parametro `local: true`: <br/>
> `<%= form_with(model: step, local: true) do |form| %>` <br/>
> `<%= form_with(model: [@lesson, step], local: true) do |form| %>` <br/>
> Ma da rails 7 questo parametro è impostato di default quindi si può evitare di inserirlo.

> Su Rails 6 lo style di base era leggermente diverso: <br/>
> `<div id="error_explanation">` vs `<div style="color: red">` <br/>
> e nei campi dentro il form `<div class="field">` <br/>
> e per il submit `<div class="actions">`.



## Aggiorniamo `steps/_step`

***Codice 06 - .../views/steps/_step.html.erb - linea:14***

```html+erb
    <%#= step.lesson_id %>
    <%= step.lesson.name %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-lessons-steps/02_06-views-steps-_step.html.erb)



## Aggiorniamo `steps/index`

> Mostriamo l'elenco, o *collection*, di *steps* associati ad una specifica lezione (*lesson*).

***Codice 07 - .../views/steps/index.html.erb - linea:09***

```html+erb
      <%#= link_to "Show this step", step %>
      <%= link_to "Show this step", lesson_step_path(@lesson, step) %>
      <%= link_to 'Show this Lesson', [@lesson] %>
```

> Invece di indirizzare a `steps/id`, indirizziamo a `lessons/lesson_id/steps/id`.
> Perché abbiamo un instradamento annidato `lessons/#/steps/#`. <br/>
> Inoltre aggiungiamo indirizzamento a `lessons/lesson_id`. 


***Code 07 - ...continua - linea:15***

```html+erb
<%#= link_to "New step", new_step_path %>
<%= link_to 'New Step', new_lesson_step_path(@lesson) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-lessons-steps/02_07-views-steps-index.html.erb)


> Invece di indirizzare a `steps/new`, indirizziamo a `lessons/lesson_id/steps/new`. 
> Per farlo usiamo l'helper di routing `new_lesson_step_path(@lesson)`.



## Aggiorniamo `steps/show`

***code 08 - .../views/steps/show.html.erb - line:6***

```html+erb
  <%#= link_to "Edit this step", edit_step_path(@step) %>
  <%= link_to 'Edit this step', edit_lesson_step_path(@lesson, @step) %> |
  <%#= link_to "Back to steps", steps_path %>
  <%= link_to 'Back to lesson steps', lesson_steps_path(@lesson) %>

  <%#= button_to "Destroy this step", @step, method: :delete %>
  <%= button_to "Destroy this step", [@lesson, @step], method: :delete %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-lessons-steps/02_08-views-steps-show.html.erb)

> Invece di indirizzare a `steps/step_id/edit`, indirizziamo a `lessons/lesson_id/steps/step_id/edit`. 
> Per farlo usiamo l'helper di routing `lesson_step_path`.

> Impostiamo il percorso annidato corretto per il link *Destroy*.



## Aggiorniamo `steps/new`

***code 09 - .../views/steps/new.html.erb - line:8***

```html+erb
  <%#= link_to "Back to steps", steps_path %>
  <%= link_to "Back to lesson steps", lesson_steps_path(@lesson) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-lessons-steps/02_09-views-steps-new.html.erb)

> Aggiorniamo i riferimenti `link_to` per riflettere le modifiche che abbiamo apportato al nostro *partial _form*. Utilizziamo l'helper `lesson_steps_path(@lesson)`.



## Aggiorniamo `steps/edit`

***Codice 10 - .../views/steps/edit.html.erb - linea:08***

```html+erb
  <%#= link_to "Show this step", @step %>
  <%= link_to "Show this step", [@lesson, @step] %> |
  <%#= link_to "Back to steps", steps_path %>
  <%= link_to "Back to steps", lesson_steps_path(@lesson) %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-lessons-steps/02_10-views-steps-edit.html.erb)



## Visualizziamo preview

Attiviamo il preview

```bash
$ rails s -b 192.168.64.3
```

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

Adesso spostiamoci lato *lessons* per aggiornare le sue views come *parent* di steps

---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/01_00-lessons_seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/03_00-lessons_parent-it.md)
