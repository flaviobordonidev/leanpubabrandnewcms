# <a name="top"></a> Cap 76.2 - Salva la risposta solo se utile per capitolo diario

Aggiorniamo il controller.

Inseriamo il codice che salva la risposta solo se è presente un riferimento ad un capitolo del diario; ossia solo se `diary_chap > 0`.


## Risorse interne

- [code_references/active_record-migration/06_00-add_column](/Users/FB/leanpubabrandnewcms/code_references/active_record-migration/06_00-add_column.md)
- []()



## Branch

continuiamo con il branch aperto nel capitolo precedente



## Quale controller dobbiamo aggiornare?

Vado nella prima lezione (Mount Vernon) al secondo step (che colore è il cane) e sul submit del form della risposta scrivo "pretuzzo" e premo submit.

Nella log vedo:

```bash
Started PATCH "/lessons/1/steps/2?locale=pt" for 192.168.64.1 at 2023-08-01 15:27:02 +0200
Cannot render console from 192.168.64.1! Allowed networks: 127.0.0.0/127.255.255.255, ::1
  ActiveRecord::SchemaMigration Pluck (1.0ms)  SELECT "schema_migrations"."version" FROM "schema_migrations" ORDER BY "schema_migrations"."version" ASC
DEPRECATION WARNING: 'include Pundit' is deprecated. Please use 'include Pundit::Authorization' instead.
 (called from include at /home/ubuntu/ubuntudream/app/controllers/application_controller.rb:4)
Processing by StepsController#update as HTML
  Parameters: {"authenticity_token"=>"[FILTERED]", "step"=>{"answers_attributes"=>{"0"=>{"_destroy"=>"false", "user_id"=>"1", "content"=>"pretuzzo"}}}, "commit"=>"Atualizar Step", "locale"=>"pt", "lesson_id"=>"1", "id"=>"2"}
  User Load (0.8ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 ORDER BY "users"."id" ASC LIMIT $2  [["id", 1], ["LIMIT", 1]]
  Lesson Load (0.6ms)  SELECT "lessons".* FROM "lessons" WHERE "lessons"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  ↳ app/controllers/steps_controller.rb:82:in `set_lesson'
  Step Load (0.5ms)  SELECT "steps".* FROM "steps" WHERE "steps"."lesson_id" = $1 AND "steps"."id" = $2 LIMIT $3  [["lesson_id", 1], ["id", 2], ["LIMIT", 1]]
  ↳ app/controllers/steps_controller.rb:87:in `set_step'
  TRANSACTION (0.3ms)  BEGIN
  ↳ app/controllers/steps_controller.rb:50:in `block in update'
  User Load (8.1ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  ↳ app/controllers/steps_controller.rb:50:in `block in update'
  Mobility::Backends::ActiveRecord::KeyValue::StringTranslation Load (1.3ms)  SELECT "mobility_string_translations".* FROM "mobility_string_translations" WHERE "mobility_string_translations"."translatable_id" = $1 AND "mobility_string_translations"."translatable_type" = $2 AND "mobility_string_translations"."key" IN ($3, $4, $5)  [["translatable_id", 2], ["translatable_type", "Step"], ["key", "question"], ["key", "cheneso"], ["key", "youtube_video_id"]]
  ↳ app/controllers/steps_controller.rb:50:in `block in update'
  Answer Create (122.2ms)  INSERT INTO "answers" ("content", "step_id", "created_at", "updated_at", "user_id") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["content", "pretuzzo"], ["step_id", 2], ["created_at", "2023-08-01 13:27:03.797610"], ["updated_at", "2023-08-01 13:27:03.797610"], ["user_id", 1]]
  ↳ app/controllers/steps_controller.rb:50:in `block in update'
  TRANSACTION (104.1ms)  COMMIT
  ↳ app/controllers/steps_controller.rb:50:in `block in update'
  Step Load (0.7ms)  SELECT "steps".* FROM "steps" WHERE "steps"."lesson_id" = $1 AND (id > 2) ORDER BY "steps"."id" ASC LIMIT $2  [["lesson_id", 1], ["LIMIT", 1]]
  ↳ app/models/step.rb:33:in `next'
  CACHE Step Load (0.1ms)  SELECT "steps".* FROM "steps" WHERE "steps"."lesson_id" = $1 AND (id > 2) ORDER BY "steps"."id" ASC LIMIT $2  [["lesson_id", 1], ["LIMIT", 1]]
  ↳ app/models/step.rb:33:in `next'
Redirected to http://192.168.64.7:3000/lessons/1/steps/6?locale=pt
Completed 302 Found in 693ms (ActiveRecord: 264.4ms | Allocations: 72625)


Started GET "/lessons/1/steps/6?locale=pt" for 192.168.64.1 at 2023-08-01 15:27:04 +0200
Cannot render console from 192.168.64.1! Allowed networks: 127.0.0.0/127.255.255.255, ::1
Processing by StepsController#show as HTML
  Parameters: {"locale"=>"pt", "lesson_id"=>"1", "id"=>"6"}
```

Nel codice di log in alto si vede che è stato fatto un inserimento nel database della risposta.

```bash
Answer Create (122.2ms)  INSERT INTO "answers" ("content", "step_id", "created_at", "updated_at", "user_id") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["content", "pretuzzo"], ["step_id", 2], ["created_at", "2023-08-01 13:27:03.797610"], ["updated_at", "2023-08-01 13:27:03.797610"], ["user_id", 1]]
  ↳ app/controllers/steps_controller.rb:50:in `block in update'
```

E questa chiamata è stata fatta dal controller `steps_controller.rb`.

Infatti se andiamo nella view `steps/show` vediamo la chiamata al form rimanda a [@lesson, @step] e questa è la chiamata annidata che nella route instrada a `steps_controller.rb`.

***code 01 - .../app/views/steps/show.html.erb - line:18***

```html+erb
					<div id="<%= dom_id @step %>">
						<%= form_with(model: [@lesson, @step], local: true, id: "answer-form", html: {'data-turbo': "false", style: "display: none; "}) do |form| %>
```

***code 01 - ...continua - line:49***

```html+erb
														<!-- Creiamo nuovo Record -->
														<%= form.fields_for :answers, Answer.new do |answer| %>
															<%= render "answer_fields", form: answer %>
														<% end %>
														<div class="actions bg-dark-input">
															<%= form.submit class: "btn btn-lg btn-primary"%>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/01_04-views-steps-show.html.erb)


Il form annidato `form.fields_for :answers` è richiamato nello `steps_controller.rb`.
Tutto parte da questa linea sul metodo `def update`.

***code 01 - .../app/views/steps/show.html.erb - line:50***

```ruby
        if @step.update(step_params)
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/01_04-views-steps-show.html.erb)


Infatti il comando `@step.update(step_params)` esegue l'update dello step (che comporta anche l'inserimento della nuova risposta nella tabella answers) e da come risposta `TRUE` se l'update va a buon fine, oppure `FALSE` se non va a buon fine.
Questa risposta lo usiamo nel nostro cicolo `if` per le azioni successive. 

L'update di step aggiunge anche una nuova risposta nella tabella answers perché l'abbiamo sia nei parametri passati (annidata con `answers_attributes[...]`):

```ruby
    def step_params
      params.require(:step).permit(:id, :question, :lesson_id, :youtube_video_id, answers_attributes: [:_destroy, :id, :content, :user_id])
    end
```

sia nel model Step:

```ruby
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc{ |attr| attr['content'].blank? }
```



## Aggiorniamo il controller - parte 1

Abbiamo capito che dobbiamo intervenire sull'azione `update` del controller `steps_controller`.
Nello specifico sulla linea 50: `if @step.update(step_params)`.

Facciamo un primo intervento grossolano con un "ciclo if" che replica tutto il codice dopo la linea 50 ma senza fare il salvataggio.
Inizialmente diamo al "ciclo if" la condizione `true` in modo che esegua sempre ls parte di codice che non fa il salvataggio. (`if true ... else ... end`)

```ruby
  # PATCH/PUT /steps/1 or /steps/1.json
  def update
    respond_to do |format|
      if true
        #params["my_diary"].present?
        #----
        #Non aggiornare lo step e vai solo avanti
        format.html do 
          if @step.next.present?
            redirect_to lesson_step_path(@lesson, @step.next.id), notice: 'Step was successfully updated.' 
          else
            redirect_to lesson_step_path(@lesson), notice: 'Step was successfully updated. - Ultima risposta'
          end
        end
        format.json { render :show, status: :ok, location: @step }
        #----
        #tutto questo blocco è stato aggiunto semplicemente per evitare di salvare la risposta sul db. *_*
      else
        #Aggiorna lo step e vai avanti
        if @step.update(step_params)
          #format.html { redirect_to step_url(@step), notice: "Step was successfully updated." }
          #format.html { redirect_to lesson_step_path(@lesson), notice: 'Step was successfully updated.' }
          format.html do 
            if @step.next.present?
              redirect_to lesson_step_path(@lesson, @step.next.id), notice: 'Step was successfully updated.' 
            else
              redirect_to lesson_step_path(@lesson), notice: 'Step was successfully updated. - Ultima risposta'
            end
          end
          format.json { render :show, status: :ok, location: @step }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @step.errors, status: :unprocessable_entity }
        end
      end
    end
  end
```

Funziona!
Adesso se diamo una risposta e facciamo il submit del form, questa non è salvata nel database.

Più avanti faremo un refactory per rendere il codice più elegante e più "asciutto" (DRY: Do Not Repeat Yourself).



## Aggiorniamo il controller - parte 2

Ma noi vogliamo che in alcuni casi la risposta sia salvata.

Quindi cambiamo la condizione che da sempre `true` con una condizione che valuta se la risposta è utile o no. E questa condizione la abbiamo con il campo `diary_chap `.

Se `diary_chap > 0` -> salva la risposta, altrimenti non la salvare.

Questo campo lo abbiamo inserito nel database nel capitolo precedente ed abbiamo anche già aggiunto il codice nel form nelle views ed accettato nello `step_params` -> `params.require(:step).permit(...)`.













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
