# <a name="top"></a> Cap 4.2 - Associamo le risposte all'utente che le ha date



## Adesso associamo ad ogni risposta l'utente loggato

Al momento, le risposte non appartengono a nessuno. Creiamo un migration per associare ogni risposta all'utente loggato.

> Per far questo dobbiamo solo aggiungere una chiave esterna *user_id* alla tabella *answers*.

Ogni risposta (answer) appartiene a un utente (user), quindi ogni risposta deve avere un *user_id* che identifichi l'utente:

Per tenere traccia di quale risposta (answer) è data da ogni utente, dobbiamo fare un'associazione tra gli utenti (users) e le loro risposte (answers).
 
```bash
$ rails g migration AddUserRefToAnswers user:references
```

Si poteva anche usare `rails g migration AddUserIdToAnswers user_id:integer` ma è meglio usare `references` perché ottimizza meglio gli indici.

vediamo il migrate generato

***code 01 - .../db/migrate/xxx_add_user_ref_to_answers.rb- line:1***

```ruby
class AddUserRefToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_reference :answers, :user, null: false, foreign_key: true
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-step-answers/02_01-db-migrate-xxx_add_user_ref_to_answers.rb)

Da Rails 5 il `.references ..., foreign_key: true` aggiunge già le chiavi esterne e l'indice (come si può vedere su .../db/schema.rb dopo il migrate del database) e mi risparmia di fare:

Effettuiamo il migrate del database che aggiungerà la colonna user_id e l'indice alla tabella answers.

Attenzione!
Prima di fare il migrate dobbiamo svuotare la tabella answers altrimenti il "null: false" ci darà errore impedendo di applicare la colonna user_id.

```bash
$ rails c
$ Answer.destroy_all
```

```bash
$ sudo service postgresql start
$ rails db:migrate
```

Se guardiamo in db/schema vedremo il risultato:

***code n/a - .../db/schema.rb - line:1***

```
  create_table "answers", force: :cascade do |t|
    t.string "content"
    t.bigint "step_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["step_id"], name: "index_answers_on_step_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end
```
  


## Implementiamo la relazione 1-a-molti nei models

Questa volta non abbiamo nessun aiuto dal `:references` e quindi dobbiamo inserire entrambi i lati dell'associazione 1-a-molti.
Lato model *Answer* inseriamo che appartiene ad *user*, ossia che ogni risposta ha 1 utente associato tramite la chiave esterna *user_id*.

Su # == Relationships nel sottogruppo ## many-to-one

***code 02 - .../app/models/answer.rb- line:1***

```
  belongs_to :user
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-step-answers/02_02-models-answer.rb)


Lato model *User* inseriamo che ha molte risposte, ossia che ogni utente può avere molte risposte associate.

Su # == Relationships nel sottogruppo ## many-to-one

***code 03 - .../app/models/user.rb- line:1***

```
  has_many :answers
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-step-answers/02_03-models-user.rb)



## Aggiorniamo il controller? No la view.

Normalmente per associare l'utente alla tabella *answers* aggiorneremmo *answers_controller* in modo che l'azione che eseguiamo con il submit del form (`create` o `update`) , associ l'utente loggato ad ogni risposta.

***code n/a - .../app/controllers/answers_controller.rb- line:n/a***

```ruby
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    #@answer.user_id = current_user.id
```

Analizziamo il codice:

- il metodo di *Devise* `current_user` restituisce l'utente che ha eseguito l'accesso.

Questo sarebbe anche più sicuro rispetto a passare la user_id attraverso il form. 

Ma nel nostro caso stiamo lavorando su un nested form che è passato da *steps_controller*. Il tutto è predisposto per poter creare più campi risposta attraverso javascript/stimulus e passarli tutti insieme. Quindi è più facile inserire l'utente loggato direttamente come valore di default nel field *user_id* del form annidato.

***code 04 - .../views/steps/_answer_fields.html.erb - line:n/a***

```html+erb
    <% if current_user %>
        <%= form.text_field :user_id, required: true, class: 'form-control', value:current_user.id  %>
    <% else %>
        <%= form.text_field :user_id, required: true, class: 'form-control', value:2 %>
    <% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-step-answers/02_04-views-steps-_answer_fields.html.erb)



## Refactoring per associare current_user

Un modo più sicuro e più elegante è agire sul model Answer.

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



## Verifichiamo da console

Effettuiamo il login ed inseriamo alcune risposte. Poi andiamo sulla console e verifichiamo le risposte date dall'utente loggato.

```bash
> u1 = User.first
> u1.answers
> u1.answers[1]
> u1.answers[1].step
> u1.answers[1].step.lesson
```



## Mostriamo il nome dell'utente affianco alla risposta

***code 05 - .../views/steps/show.html.erb - line:1***

```html+erb
        <%= answer.content %> - by <%= answer.user.name %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-step-answers/02_05-views-steps-show.html.erb)

