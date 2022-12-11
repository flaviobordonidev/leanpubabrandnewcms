# <a name="top"></a> Cap 16.4 - Attiviamo il controllo degli accessi con pundit

Attiviamo il controllo degli accessi con pundit per `lessons`, `steps` e `answers`.
Pundit usa delle *policies* per fare il controllo degli accessi.



## Apriamo il branch "Users Answers Pundit"

```bash
$ git checkout -b uap
```



## Aggiungiamo policy per Answer

Per aggiungere una policy per un modello specifico aggiungiamo il nome del model.

```bash
$ rails g pundit:policy Answer
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (vps)$rails g pundit:policy Answer
      create  app/policies/answer_policy.rb
      invoke  test_unit
      create    test/policies/answer_policy_test.rb
ubuntu@ubuntufla:~/ubuntudream (vps)$
```

questo ci crea la seguente policy


***Codice n/a - .../app/policies/answer_policy.rb - linea:01***

```ruby
class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
```



## La logica della answer_policy

Vediamo uno schema della logica delle autorizzazioni simile allo schema delle autorizzazioni.

Legenda ruoli utenti:

- `ruolo "user"` : login fatto da uno studente (student)
- `ruolo "author"` : login fatto da un professore o istruttore (instructor)
- `ruolo "moderator"` : login fatto da un moderatore (per le risposte non serve perché sono private. quindi gli diamo gli stessi accessi di `user`.)
- `ruolo "admin"` : può fare tutto! è un superuser ^_^.

index
- Utente con ruolo "user"      : autorizzato SOLO sui propri records
- Utente con ruolo "author"    : autorizzato SOLO sui propri records
- Utente con ruolo "moderator" : autorizzato SOLO sui propri records
- Utente con ruolo "admin"     : autorizzato su TUTTI i records
- Utente non loggato           : NON autorizzato su tutti i records

show
- Utente con ruolo "user"      : autorizzato SOLO sui propri records
- Utente con ruolo "author"    : autorizzato SOLO sui propri records
- Utente con ruolo "moderator" : autorizzato SOLO sui propri records
- Utente con ruolo "admin"     : autorizzato su TUTTI i records
- Utente non loggato           : NON autorizzato su tutti i records

new/create
- Utente con ruolo "user"      : autorizzato SOLO sui propri records
- Utente con ruolo "author"    : autorizzato SOLO sui propri records
- Utente con ruolo "moderator" : autorizzato SOLO sui propri records
- Utente con ruolo "admin"     : autorizzato su TUTTI i records
- Utente non loggato           : NON autorizzato su tutti i records

edit/update
- Utente con ruolo "user"      : autorizzato SOLO sui propri records
- Utente con ruolo "author"    : autorizzato SOLO sui propri records
- Utente con ruolo "moderator" : autorizzato SOLO sui propri records
- Utente con ruolo "admin"     : autorizzato su TUTTI i records
- Utente non loggato           : NON autorizzato su tutti i records

destroy
 - Utente con ruolo "user"      : autorizzato SOLO sui propri records
 - Utente con ruolo "author"    : autorizzato SOLO sui propri records
 - Utente con ruolo "moderator" : autorizzato SOLO sui propri records
 - Utente con ruolo "admin"     : autorizzato su TUTTI i records
 - Utente non loggato           : NON autorizzato su tutti i records


Legenda accessi:

- `all records` : tutte le righe della tabella `answers`.
- `my records`  : le righe con relazione: `answers.user_id = current_user`.
- `no records`  : nessuna riga della tabella `answers`.


***Codice 01 - .../app/policies/answer_policy.rb - linea:03***

```ruby
  def index?
    if @user.present?
      case @user.role
      when 'user'
        @user.id == @record.user_id #my records
      when 'author'
        @user.id == @record.user_id #my records
      when 'moderator'
        @user.id == @record.user_id #my records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end

  def show?
    if @user.present?
      case @user.role
      when 'user'
        @user.id == @record.user_id #my records
      when 'author'
        @user.id == @record.user_id #my records
      when 'moderator'
        @user.id == @record.user_id #my records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end
  
  def create?
    if @user.present?
      case @user.role
      when 'user'
        @user.id == @record.user_id #my records
      when 'author'
        @user.id == @record.user_id #my records
      when 'moderator'
        @user.id == @record.user_id #my records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end
  
  def update?
    if @user.present?
      case @user.role
      when 'user'
        @user.id == @record.user_id #my records
      when 'author'
        @user.id == @record.user_id #my records
      when 'moderator'
        @user.id == @record.user_id #my records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end

  def destroy?
    if @user.present?
      case @user.role
      when 'user'
        @user.id == @record.user_id #my records
      when 'author'
        @user.id == @record.user_id #my records
      when 'moderator'
        @user.id == @record.user_id #my records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/04_01-policies-answer_policy.rb)



## Aggiorniamo answers_controller

Assegnamo l'accesso pundit alle azioni del controller.
Inseriamo gli `authorize @answer/answers` nelle varie azioni.
Per `show edit update destroy` aggiorniamo il metodo `set_answer` chiamato dal `before_action`.

***Codice 02 - .../app/controllers/answers_controller.rb - linea:05***

```ruby
  def index
    @answers = Answer.all
    authorize @answers
```

***Codice 02 - ...continua - linea:15***

```ruby
  def new
    @answer = Answer.new
    authorize @answer
```

***Codice 02 - ...continua - linea:25***

```ruby
  def create
    @answer = Answer.new(answer_params)
    authorize @answer
```

***Codice 02 - ...continua - linea:65***

```ruby
    def set_answer
      @answer = Answer.find(params[:id])
      authorize @answer
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/04_01-policies-answer_policy.rb)

> Abbiamo anche inserito la protezione di `devise`: `before_action :authenticate_user!`
> ma già pundit ci rimandava al login quindi è una protezione aggiuntiva.



## Aggiungiamo policy per Step

Per aggiungere una policy per un modello specifico aggiungiamo il nome del model.

```bash
$ rails g pundit:policy Step
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (vps)$rails g pundit:policy Step
      create  app/policies/step_policy.rb
      invoke  test_unit
      create    test/policies/step_policy_test.rb
ubuntu@ubuntufla:~/ubuntudream (vps)$
```

questo ci crea la seguente policy


***Codice n/a - .../app/policies/step_policy.rb - linea:01***

```ruby
class StepPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
```



## La logica della step_policy

Sia step che lesson non hanno una relazione con l'utente.

> Non è pensato che autori diversi preparino le lezioni. Al momento c'è solo l'amministratore che prepara tutte le lezioni.<br/>
> Più avanti abiliteremo anche la possibilità ad utenti con ruolo di autori di creare delle lezioni ma al momento non è così.

Vediamo uno schema della logica delle autorizzazioni simile allo schema delle autorizzazioni.

Legenda accessi:
- `all records` : tutte le righe della tabella `steps`.
- `my records`  : le righe con relazione: `steps.user_id = current_user`. ***<-- Questo non c'è!***
- `no records`  : nessuna riga della tabella `steps`.

***Codice 02 - .../app/policies/step_policy.rb - linea:03***

```ruby
  def index?
    if @user.present?
      case @user.role
      when 'user'
        true #all records
      when 'author'
        true #all records
      when 'moderator'
        true #all records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end

  def show?
    if @user.present?
      case @user.role
      when 'user'
        true #all records
      when 'author'
        true #all records
      when 'moderator'
        true #all records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end
  
  def create?
    if @user.present?
      case @user.role
      when 'user'
        false #no records
      when 'author'
        false #no records
      when 'moderator'
        false #no records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end
  
  def update?
    if @user.present?
      case @user.role
      when 'user'
        false #no records
      when 'author'
        false #no records
      when 'moderator'
        false #no records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end

  def destroy?
    if @user.present?
      case @user.role
      when 'user'
        false #no records
      when 'author'
        false #no records
      when 'moderator'
        false #no records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/04_02-policies-steps_policy.rb)



## Aggiorniamo steps_controller

Assegnamo l'accesso pundit alle azioni del controller.
Inseriamo gli `authorize @step/steps` nelle varie azioni.
Per `show edit update destroy` aggiorniamo il metodo `set_step` chiamato dal `before_action`.

***Codice 04 - .../app/controllers/steps_controller.rb - linea:06***

```ruby
  def index
    #@steps = Step.all
    @steps = @lesson.steps
    authorize @steps
```

***Codice 04 - ...continua - linea:17***

```ruby
  def new
    #@step = Step.new
    @step = @lesson.steps.new
    authorize @step
```

***Codice 04 - ...continua - linea:28***

```ruby
  def create
    #@step = Step.new(step_params)
    @step = @lesson.steps.new(step_params)
    authorize @step
```

***Codice 04 - ...continua - linea:83***

```ruby
    def set_step
      #@step = Step.find(params[:id])
      @step = @lesson.steps.find(params[:id])
      authorize @step
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/04_04-controllers-steps_controller.rb)

> Abbiamo anche inserito la protezione di `devise`: `before_action :authenticate_user!`
> ma già pundit ci rimandava al login quindi è una protezione aggiuntiva.



## Aggiungiamo policy per Lesson

Per aggiungere una policy per un modello specifico aggiungiamo il nome del model.

```bash
$ rails g pundit:policy Lesson
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (vps)$rails g pundit:policy Lesson
      create  app/policies/lesson_policy.rb
      invoke  test_unit
      create    test/policies/lesson_policy_test.rb
ubuntu@ubuntufla:~/ubuntudream (vps)$
```

questo ci crea la seguente policy


***Codice n/a - .../app/policies/lesson_policy.rb - linea:01***

```ruby
class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
```



## La logica della lesson_policy

Come detto prima, sia step che lesson non hanno una relazione con l'utente.

> A `lesson` diamo gli stessi accessi dati a `step`.

Vediamo uno schema della logica delle autorizzazioni simile allo schema delle autorizzazioni.

Legenda accessi:
- `all records` : tutte le righe della tabella `lessons`.
- `my records`  : le righe con relazione: `lessons.user_id = current_user`. ***<-- Questo non c'è!***
- `no records`  : nessuna riga della tabella `lessons`.

***Codice 02 - .../app/policies/lesson_policy.rb - linea:03***

```ruby
  def index?
    if @user.present?
      case @user.role
      when 'user'
        true #all records
      when 'author'
        true #all records
      when 'moderator'
        true #all records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end

  def show?
    if @user.present?
      case @user.role
      when 'user'
        true #all records
      when 'author'
        true #all records
      when 'moderator'
        true #all records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end
  
  def create?
    if @user.present?
      case @user.role
      when 'user'
        false #no records
      when 'author'
        false #no records
      when 'moderator'
        false #no records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end
  
  def update?
    if @user.present?
      case @user.role
      when 'user'
        false #no records
      when 'author'
        false #no records
      when 'moderator'
        false #no records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end

  def destroy?
    if @user.present?
      case @user.role
      when 'user'
        false #no records
      when 'author'
        false #no records
      when 'moderator'
        false #no records
      when 'admin'
        true #all records
      else #role not defined
        false #no records
      end
    else
      false #no records
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/04_03-policies-lesson_policy.rb)



## Aggiorniamo lessons_controller

Assegnamo l'accesso pundit alle azioni del controller.
Inseriamo gli `authorize @lesson/lessons` nelle varie azioni.
Per `show edit update destroy` aggiorniamo il metodo `set_lesson` chiamato dal `before_action`.

***Codice 06 - .../app/controllers/lessons_controller.rb - linea:05***

```ruby
  def index
    @lessons = Lesson.all
    authorize @lessons
```

***Codice 06 - ...continua - linea:15***

```ruby
  def new
    @lesson = Lesson.new
    authorize @lesson
```

***Codice 06 - ...continua - linea:25***

```ruby
  def create
    @lesson = Lesson.new(lesson_params)
    authorize @lesson
```

***Codice 06 - ...continua - linea:65***

```ruby
    def set_lesson
      @lesson = Lesson.find(params[:id])
      authorize @lesson
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/16-steps-answers/04_04-controllers-lessons_controller.rb)

> Abbiamo anche inserito la protezione di `devise`: `before_action :authenticate_user!`
> ma già pundit ci rimandava al login quindi è una protezione aggiuntiva.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Add authorization to answer step lesson"
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge uap
$ git branch -d uap
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```


## Publichiamo su render.com

lo fa in automatico da aggiornamento del backup su Github.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/04-steps-answers/01_00-answers_seeds-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/56-ubuntudream/05-steps-show_video_with_events/01_00-mockups_youtube_player-it.md)
