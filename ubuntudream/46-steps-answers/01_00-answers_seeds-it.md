# <a name="top"></a> Cap 16.1 - Le risposte per ogni utente

In questo capitolo usiamo gli utenti ed il login già sviluppato nei capitoli precedenti e creiamo una tabella di risposte in modo che alle varie domande di ogni lezione associamo una risposta differente per ogni utente.

> Ogni utente avrà quindi un suo registro degli esercizi svolti e delle risposte date. Anche se per gli esercizi di allenamento contano poco, diventano invece importanti nel percorso coaching. <br/>
> Più avanti, nel percorso coaching, inseriremo anche un campo boolean per le domande importanti, ossia quelle che utilizzeremo nei giornali di viaggio dell'utente. 

***Attenzione:***

- NON stiamo parlando di tabella polimorfica. (Vedi 50-elisinfo/04-Companies/06-polymorfic_telephonable)
  quindi **niente** tabella `userable`.
  
- NON stiamo parlando di tabella "ponte" molti-a-molti (Vedi 50-elisinfo/06-company_person_maps/01-company_person_maps_seeds)
  quindi **niente** tabella `answer_user_maps`.



## Risorse interne

- [code_references/active_record-associations/21_00-users_posts_and_comments]()
- [code_references/active_record-associations/22_00-users_and_books]()



## Apriamo il branch "Users Answers"

```bash
$ git checkout -b ua
```



## Progettiamo la tabela answers

Siccome ogni utente darà la sua personale risposta dobbiamo creare una tabella *answers* che avrà una relazione molti-a-uno con *steps*.
Ogni step c'è una tranche di video e una domanda. A quella domanda ci sono molte risposte; una risposta per ogni utente.

Abbiamo diviso le varie colonne della tabella in principali e secondarie perché non implementeremo tutte le colonne da subito ma iniziamo con le principali e poi aggiungiamo le altre di volta in volta facendo dei migrate di aggiunta ed aggiornando controller, model e views.

Colonne principali:

Colonna                 | Descrizione
| :-                    | :-
`content:string`        | (255 caratteri) Le risposte sono brevi, un po' alla twitter, per non perdere la concentrazione sulla visualizzazione. (un'alternativa poteva essere: `value:string`)


Colonne secondarie:

- nessuna


Tabelle collegate 1-a-molti (chiavi esterne)

- steps:ref
- users:ref


Tabelle collegate molti-a-1 (non ho campi di chiave esterna perché saranno sull'altra tabella)

- nessuna



## Impementiamo la tabella

Creiamo la tabella iniziale con le colonne principali e la colonna della chiave primaria esterna `step_id`.

> A scopo didattico, la colonna con la chiave esterna `user_id` la inseriamo più avanti.

Quando *generiamo* una nuova tabella **ci conviene** usare lo `scaffold` ed eventualmente eliminare il controller e le views che non ci servono.

I> ATTENZIONE: con "rails generate scaffold ..." -> usiamo il SINGOLARE
    -> lui in automatico genera correttamente la tabella, il controller e le views al plurale.

```bash
$ rails g scaffold Answer content:string step:references
```

> Volendo al posto di `:references` si può usare l'alias `:belongs_to`.

> Nota: `step:references` crea la chiave esterna `step_id`, mette l'indice ed imposta la relazione 1-a-molti nei models.

vediamo il migrate generato

***Codice 01 - .../db/migrate/xxx_create_answers.rb - linea:01***

```ruby
class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :content
      t.references :step, null: false, foreign_key: true

      t.timestamps
    end
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/01_01-db-migrate-xxx_create_answers.rb)


Effettuiamo il migrate del database per creare la tabella sul database

```bash
$ rails db:migrate
```

Da Rails 5 il `.references ..., foreign_key: true` aggiunge già la chiave esterna e l'indice (come si può vedere su *.../db/schema.rb* dopo il migrate del database).

***Codice n/a - .../db/schema.rb - linea:n/a***

```ruby
  create_table "answers", force: :cascade do |t|
    t.string "content"
    t.bigint "step_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["step_id"], name: "index_answers_on_step_id"
  end
```



## Completiamo la relazione 1-a-molti nei models


Lato *Answer* l'associazione `belongs_to :step` la troviamo già inserita grazie al `:references` usato prima. Quello che inseriamo è la struttura di commenti per organizzare il model.

Model: `Answer`.

***Codice 02 - .../app/models/answer.rb - linea:01***

```ruby
class Answer < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================

  ## many-to-one
  belongs_to :step

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/15-steps-answers/01_02-models-answer.rb)


Lato *Step* l'associazione `has_many :answers` la inseriamo noi.

Model: `Step` - Gruppo: `# == Relationships` - Sottogruppo: `## one-to-many`.

***Codice 03 - .../app/models/step.rb - linea:14***

```ruby
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc{ |attr| attr['content'].blank? }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/01_03-models-step.rb)


Analizziamo il codice:

- `dependent: :destroy` -> questa opzione fa in modo che quando eliminiamo uno step in automatico vengano cancellate anche tutte le sue risposte (*answers*).
- `allow_destroy: true` -> permette di cancellare le form annidate.
- `reject_if: proc{ |attr| attr['content'].blank? }` -> evita che vengano salvate form annidate in cui non è stato compilato il campo *content*.



## Inseriamo delle risposte da console

```bash
$ rails c

> l1 = Lesson.first
> l1.steps
> l1.steps[0]
> l1.steps[0].answers
> l1.steps[0].answers.new(content: "mattoni").save
> a1 = l1.steps[0].answers.first
> a2 = l1.steps[0].answers.new(content: "cartone")
> a2.save

> l1 = Lesson.first
> step2 = l1.steps.second
> step2.answers.new(content: "vino").save
> step2.answers.new(content: "birra").save
> step2.answers.new(content: "rock and roll").save
> l1.steps[1].answers
> exit
```

> Curiosità: <br/>
> il comando `> a2 = l1.steps[0].answers.new(content: "cartone").save` avrebbe associato alla variabile a2 il valore True, ossia il risultato del salvataggio.
> Non avrebbe associato l'oggetto `answers[2]`.



## Implementiamo sulle views

Mostriamo le risposte caricate da console. <br/>
Sulla pagina *views/steps/show* inseriamo la visualizzazione di tutte le risposte.

***Codice 04 - .../views/steps/show.html.erb - linea:33***

```html+erb
<p>
  <strong>Answers</strong>
  <ul>
    <% @step.answers.each do |answer| %>
      <li>
        <%= answer.content %>
      </li>
    <% end %>
  </ul>
</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/01_04-views-steps-show.html.erb)



## Inseriamo il form per aggiungere risposte

Inseriamo il form per inserire manualmente una nuova risposta.

> All'interno del `form_with(model: [@lesson, @step]) do` che interagisce con il controller `steps_controller` e che ha una route annidata *lessons/#/steps/#*, inseriamo un **form annidato** per le *answers* attraverso il comando `.fields_for :answers`.

***Codice 05 - .../views/steps/show.html.erb - linea:45***

```html+erb
<%= form_with(model: [@lesson, @step]) do |form| %>
  <!-- Creiamo nuovo Record -->
  <%= form.fields_for :answers, Answer.new do |answer| %>
    <%= render "answer_fields", form: answer %>
  <% end %>
  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/01_05-views-steps-show.html.erb)


> Si può anche scrivere `form_with(model: [@lesson, @step], local: true) do |form|` ma il parametro `local: true` da Rails 7 è l'opzione di default e quindi si può omettere.


***Codice 06 - .../views/steps/_answer_fields.html.erb- linea:01***

```html+erb
<div class="nested-fields">
  <div class="form-group">
    <%= form.hidden_field :_destroy %>
    <%= form.text_field :content, placeholder: "rispondi", class: "form-control" %>
  </div>
</div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/04-steps-answers/01_06-views-steps-_answer_fields.html.erb)


Ogni volta che facciamo submit del form aggiungiamo una nuova risposta.

> Attenzione! <br/>
> Oltre ad inserire la risposta avanziamo di uno step! Quindi se vogliamo vedere la risposta inserita dobbiamo tornare indietro di uno step. (unica eccezione è l'ultimo record.)
>
> Doppia Attenzione!  <br/>
> Se non aggiorniamo lo steps_controller per accettare i dati di *answers* non sono salvati.



## Aggiorniamo il controller

Permettiamo che siano passati i parametri relativi alle risposte (*answers*).
Per farlo aggiungiamo `answers_attributes[]` al `params.require(:step).permit`. Questo lo possiamo fare perché abbiamo inserito nel model *Step* la voce `accepts_nested_attributes_for :answers`.

***Codice 07 - .../app/controllers/steps_controller.rb- linea:01***

```ruby
    # Only allow a list of trusted parameters through.
    def step_params
      params.require(:step).permit(:question, :answer, :lesson_id, answers_attributes: [:_destroy, :id, :content])
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/01_07-controllers-steps_controller.rb)

Lato server / back-end abbiamo terminato.


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
$ git commit -m "Add answer table"
```



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



## Publichiamo su render.com

Lo fa in automatico prendendo gli aggiornamenti dal backup su Github.

Verifichiamo preview in produzione.

Andiamo all'url:

- https://ubuntudream.onrender.com/lessons/1/steps

E diamo le risposte ai vari steps della prima lezione.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/03-lessons-steps/04_00-steps_sequence-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/04-steps-answers/02_00-users_answers-it.md)
