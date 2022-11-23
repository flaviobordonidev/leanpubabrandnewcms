# <a name="top"></a> Cap 16.2 - Associamo le risposte all'utente che le ha date

Nel capitolo precedente abbiamo creato la tabella risposte ed un form che inserisce nuove risposte su uno specifico step. In questo capitolo le associamo anche all'utente loggato.



## Apriamo il branch "Users Answers"

```bash
$ git checkout -b ua
```



## Adesso associamo ad ogni risposta l'utente loggato

Al momento, le risposte non appartengono a nessuno. Creiamo un migration per associare ogni risposta all'utente loggato.

> Per far questo dobbiamo solo aggiungere la chiave esterna *user_id* alla tabella *answers*.

Per tenere traccia di quale risposta (answer) è data da ogni utente, facciamo un'associazione tra gli utenti (users) e le loro risposte (answers) attraverso la chiave esterna *user_id* nella tabella *answers*.
 
```bash
$ rails g migration AddUserRefToAnswers user:references
```

> Si poteva anche usare `rails g migration AddUserIdToAnswers user_id:integer` ma è meglio usare `references` perché ottimizza meglio gli indici.

vediamo il migrate generato

***Codice 01 - .../db/migrate/xxx_add_user_ref_to_answers.rb- linea:01***

```ruby
class AddUserRefToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_reference :answers, :user, null: false, foreign_key: true
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/02_01-db-migrate-xxx_add_user_ref_to_answers.rb)

> Da Rails 5 il `.references ..., foreign_key: true` aggiunge già le chiavi esterne e l'indice (come si può vedere su .../db/schema.rb dopo il migrate del database).

Effettuiamo il migrate del database che aggiungerà la colonna `user_id` e l'*indice* alla tabella *answers*.

> Attenzione! <br/>
> Prima di fare il migrate dobbiamo svuotare la tabella *answers* altrimenti l'opzione `null: false` ci darà errore impedendo di applicare la colonna `user_id`.

```bash
$ rails c
$ Answer.destroy_all
```

Eseguiamo il migrate.

```bash
$ rails db:migrate
```

Se guardiamo in db/schema vediamo l'aggiunta di `user_id` e dell'indice *index_answers_on_user_id*.

***Codice n/a - .../db/schema.rb - linea:55***

```ruby
  create_table "answers", force: :cascade do |t|
    t.string "content"
    t.bigint "step_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["step_id"], name: "index_answers_on_step_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end
```



## Implementiamo la relazione 1-a-molti nei models

Questa volta non abbiamo nessun aiuto dal `:references` e quindi dobbiamo inserire entrambi i lati dell'associazione 1-a-molti.

Lato *Answer* inseriamo che appartiene ad *user*, ossia che ogni risposta ha 1 utente associato tramite la chiave esterna *user_id*.

Model: `Answer` - Gruppo: `# == Relationships` - Sottogruppo: `## one-to-many`.

***Codice 02 - .../app/models/answer.rb- linea:12***

```ruby
  belongs_to :user
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/02_02-models-answer.rb)


Lato *User* inseriamo che ha molte risposte, ossia che ogni utente può avere molte risposte associate.

Model: `User` - Gruppo: `# == Relationships` - Sottogruppo: `## many-to-one`.

***Codice 03 - .../app/models/user.rb- linea:25***

```ruby
  has_many :answers
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/02_03-models-user.rb)



## Aggiorniamo il controller? No la view.

Normalmente per associare l'utente alla tabella *answers* aggiorneremmo *answers_controller* in modo che l'azione che eseguiamo con il submit del form (`create` o `update`) , associ l'utente loggato ad ogni risposta.

***Codice n/a - .../app/controllers/answers_controller.rb - linea:n/a***

```ruby
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    #@answer.user_id = current_user.id
```

> il metodo di *Devise* `current_user` restituisce l'utente che ha eseguito l'accesso.

Questo sarebbe anche più sicuro rispetto a passare la `user_id` attraverso il form. 

Ma nel nostro caso stiamo lavorando su un nested form che è passato da *steps_controller*. Il tutto è predisposto per poter creare più campi risposta attraverso javascript/stimulus e passarli tutti insieme. 

Quindi è più facile inserire l'utente loggato direttamente come valore di default nel field *user_id* del form annidato.

***Codice 04 - .../views/steps/_answer_fields.html.erb - linea:05***

```html+erb
    <% if current_user %>
        <%= form.text_field :user_id, required: true, class: 'form-control', value:current_user.id  %>
    <% else %>
        <%= form.text_field :user_id, required: true, class: 'form-control', value:1 %>
    <% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/02_04-views-steps-_answer_fields.html.erb)


> Non è elegante inserire if...else forzando value:1 nel caso non sia loggato nessun utente. <br/>
> la situazione di nessun utente loggato non deve avvenire quindi mi sembra un controllo superfluo.



## Aggiorniamo controller

Inseriamo `:user_id` nella white-list; dentro `answers_attributes: [...]`.

***Codice 05 - .../controllers/steps_controller.html.erb - linea:87***

```ruby
    # Only allow a list of trusted parameters through.
    def step_params
      params.require(:step).permit(:question, :answer, :lesson_id, answers_attributes: [:_destroy, :id, :content, :user_id])
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/02_05-controllers-steps_controller.rb)

In questo modo il valore dell'user_id è passato nel database ed inserito nella tabella *steps*.



## Mostriamo il nome dell'utente affianco alla risposta

***Codice 06 - .../views/steps/show.html.erb - linea:38***

```html+erb
        <%= answer.content %> - by <%= answer.user.username %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-step-answers/02_06-views-steps-show.html.erb)


> Se l'utente non è loggato prende errore? <br/>
> No, perché abbiamo impostato che l'utente deve essere presente nella risposta. <br/>
> Potremmo mettere un controllo `if answer.user.present?` ma non serve. <br/>
> `<%= answer.content %> <%= "- by #{answer.user.name}" if answer.user.present? %>`



## Refactoring per associare current_user

Un modo più sicuro e più elegante è agire sul model *Answer*.

Vediamo un esempio tratto dalla home page di https://rubyonrails.org/ che ora ha RAILS 7.
ESEMPIO:

***code n/a - .../models/article.rb - line:1***

```ruby
class Article < ApplicationRecord
  belongs_to :author, default: -> { Current.user }
  has_many   :comments

  has_one_attached :avatar
  has_rich_text :content, encrypted: true
  enum status: [ :drafted, :published ]

  scope :recent, -> { order(created_at: :desc).limit(25) }

  after_save_commit :deliver_later, if: :published?

  def byline
    "Written by #{author.name} on #{created_at.to_s(:short)}"
  end

  def deliver_later
    Article::DeliveryJob.perform_later self
  end
end
```

Mooolto interessante questa riga:
  `belongs_to :author, default: -> { Current.user }`

che per noi potrebbe diventare sul model Answer:
  `belongs_to :step, default: -> { Current.user }`

oppure
  `belongs_to :step, default: -> { current_user }`

> `current_user` ci viene da *Devise*.



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

Andiamo all'url:

- http://192.168.64.3:3000/lessons/1/steps/1


Effettuiamo il login ed inseriamo alcune risposte. Poi andiamo sulla console e verifichiamo le risposte date dall'utente loggato.

**Verifichiamo da console**

```bash
> u1 = User.first
> u1.answers
> u1.answers[1]
> u1.answers[1].step
> u1.answers[1].step.lesson
```

> Da notare che da ogni singola risposta possiamo risalire alla domanda (*step*) e alla lezione (*lesson*)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Relation answers to users"
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge ua
$ git branch -d ua
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```


## Publichiamo su heroku

Come fatto per il database locale di sviluppo (*bl7_development*), prima di eseguire il migrate su heroku cancelliamo tutti i records dalla tabella *answers* altrimenti riceviamo errore perché nella tabella *answers* la chiave esterna *user_id*, che serve per la relazione uno-a-molti fra *users* ed *answers*, non può essere vuota.

```bash
$ git push heroku cs:main
$ heroku run rails c
> Answer.destroy_all
> exit
$ heroku run rails db:migrate
```

Verifichiamo preview su heroku.

Andiamo all'url:

- https://bl7-0.herokuapp.com/users
- https://bl7-0.herokuapp.com/lessons/1/steps/1

Prima ci logghiamo e poi diamo le risposte ai vari steps della prima lezione.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/04-steps-answers/01_00-answers_seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/01_00-mockups_youtube_player-it.md)
