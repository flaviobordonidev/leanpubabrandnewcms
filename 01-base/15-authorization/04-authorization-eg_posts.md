# <a name="top"></a> Cap 15.4 - Implementiamo le autorizzazioni per eg_posts

Autentichiamo ed Autorizziamo la gestione degli articoli (eg_posts) in funzione del ruolo.
Siccome molti passaggi sono simili a quelli del capitolo precedente, in questo capitolo inseriamo meno passaggi e meno spiegazioni.



## Apriamo il branch "Authorization ExamplePost"

```bash
$ git checkout -b aep
```



## Aggiungiamo policy per ExamplePost

```bash
$ rails g pundit:policy EgPost


user_fb:~/environment/bl6_0 (aep) $ rails g pundit:policy EgPost
Running via Spring preloader in process 3865
      create  app/policies/eg_post_policy.rb
      invoke  test_unit
      create    test/policies/eg_post_policy_test.rb
```

questo crea la seguente policy

***codice n/a - .../app/policies/eg_post_policy.rb - line: 1***

```ruby
class EgPostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
```



## Implementiamo tutte le policies per tutte le azioni di eg_posts

Vediamo uno schema della logica delle autorizzazioni

Legenda:
- per "records" si intendono gli "articoli di esempio" (eg_posts)
- per "propri records" si intendono gli "articoli di esempio di cui l'utente è proprietario". Ossia dove ha una relazione uno-a-molti.

index
- Utente non loggato           : autorizzato su tutti i records
- Utente con ruolo "user"      : autorizzato su tutti i records
- Utente con ruolo "author"    : autorizzato su tutti i records
- Utente con ruolo "moderator" : autorizzato su tutti i records
- Utente con ruolo "admin"     : autorizzato su tutti i records

show
- Utente non loggato           : NON autorizzato su tutti i records
- Utente con ruolo "user"      : autorizzato su tutti i records
- Utente con ruolo "author"    : autorizzato su tutti i records
- Utente con ruolo "moderator" : autorizzato su tutti i records
- Utente con ruolo "admin"     : autorizzato su tutti i records

new/create
- Utente non loggato           : NON autorizzato su tutti i records
- Utente con ruolo "user"      : NON autorizzato su tutti i records
- Utente con ruolo "author"    : autorizzato SOLO sui propri records
- Utente con ruolo "moderator" : autorizzato SOLO sui propri records
- Utente con ruolo "admin"     : autorizzato SOLO sui propri records


edit/update
- Utente non loggato           : NON autorizzato su tutti i records
- Utente con ruolo "user"      : NON autorizzato su tutti i records
- Utente con ruolo "author"    : autorizzato SOLO sui propri records
- Utente con ruolo "moderator" : autorizzato SOLO sui propri records
- Utente con ruolo "admin"     : autorizzato su tutti i records

destroy
- Utente non loggato           : NON autorizzato su tutti i records
- Utente con ruolo "user"      : NON autorizzato su tutti i records
- Utente con ruolo "author"    : autorizzato SOLO sui propri records
- Utente con ruolo "moderator" : autorizzato su tutti i records
- Utente con ruolo "admin"     : autorizzato su tutti i records


***codice 01 - .../app/policies/eg_post_policy.rb - line: 3***

```ruby
  def index?
    true
  end

  def show?
    if @user.present?
      true
    else
      false
    end
  end
  
  def create?
    if @user.present?
      @user.author? or @user.moderator? or @user.admin?
    else
      false
    end
  end
  
  def update?
    if @user.present?
      if @user.user?
        false
      else
        @user.id == @record.user_id or @user.admin?
      end
    else
      false
    end
  end

  def destroy?
    if @user.present?
      @user.id == @record.user_id or @user.moderator? or @user.admin?
    else
      false
    end
  end
```

[tutto il codice](#01-15-04_01all)




## Facciamo dei piccoli refactoring

Poiché con la chiamata "@user.present?" ottengo già TRUE o FALSE, non ho bisogno del ciclo if...else...end.
Quindi possiamo riscrivere la policy per show

***codice n/a - .../app/policies/example_post_policy.rb - line: 7***

```ruby
  def show?
    @user.present?
  end
```

Invece per la policy di update togliamo la verifica "if @user.user?". Questo permette all'utente di modificare i suoi propri record ma non potendoli creare non ha record da modificare.

***codice n/a - ...continua - line: 17***
```
  def update?
    if @user.present?
      @user.id == @record.user_id or @user.admin?
    else
      false
    end
  end
```



## Implementiamo nel controller

Implementiamo l'autorizzazione all'interno del controller.

***codice 02 - .../app/controllers/eg_posts_controller.rb - line: 6***

```ruby
  def index
    @eg_posts = EgPost.all
    authorize @eg_posts
```

***codice 02 - ...continua - line: 17***

```ruby
  def new
    @eg_post = EgPost.new
    authorize @eg_post
```


***codice 02 - ...continua - line: 28***

```ruby
  def create
    @eg_post = EgPost.new(eg_post_params)
    authorize @eg_post
```

Per le azioni [:show, :edit, :update, :destroy], che chiamano la funzione *set_user* con il *before_action*, inserisco l'autorizzazione direttamente sulla funzione *set_user*.

***codice 02 - ...continua - line: 71***

```ruby
    def set_eg_post
      @eg_post = EgPost.find(params[:id])
      authorize @eg_post
```

[tutto il codice](#01-15-04_02all)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

- https://mycloud9path.amazonaws.com/eg_posts



## aggiorniamo git 

```bash
$ git add -A
$ git commit -m "add pundit authorization on all actions of eg_post"
```



## Un refactoring sulla logica della policy

riportiamo la gestione della logica della policy ad una situazione simile allo schema della logica delle autorizzazioni: 

index
- Utente non loggato           : autorizzato su tutti i records
- Utente con ruolo "user"      : autorizzato su tutti i records
- Utente con ruolo "author"    : autorizzato su tutti i records
- Utente con ruolo "moderator" : autorizzato su tutti i records
- Utente con ruolo "admin"     : autorizzato su tutti i records

show
- Utente non loggato           : NON autorizzato su tutti i records
- Utente con ruolo "user"      : autorizzato su tutti i records
- Utente con ruolo "author"    : autorizzato su tutti i records
- Utente con ruolo "moderator" : autorizzato su tutti i records
- Utente con ruolo "admin"     : autorizzato su tutti i records

new/create
- Utente non loggato           : NON autorizzato su tutti i records
- Utente con ruolo "user"      : NON autorizzato su tutti i records
- Utente con ruolo "author"    : autorizzato SOLO sui propri records
- Utente con ruolo "moderator" : autorizzato SOLO sui propri records
- Utente con ruolo "admin"     : autorizzato SOLO sui propri records


edit/update
- Utente non loggato           : NON autorizzato su tutti i records
- Utente con ruolo "user"      : NON autorizzato su tutti i records
- Utente con ruolo "author"    : autorizzato SOLO sui propri records
- Utente con ruolo "moderator" : autorizzato SOLO sui propri records
- Utente con ruolo "admin"     : autorizzato su tutti i records

destroy
 - Utente non loggato           : NON autorizzato su tutti i records
 - Utente con ruolo "user"      : NON autorizzato su tutti i records
 - Utente con ruolo "author"    : autorizzato SOLO sui propri records
 - Utente con ruolo "moderator" : autorizzato su tutti i records
 - Utente con ruolo "admin"     : autorizzato su tutti i records


***codice 03 - .../app/policies/eg_post_policy.rb - line: 3***

```ruby
  def index?
    if @user.present?
      case @user.role
      when 'user'
        true
      when 'author'
        true
      when 'moderator'
        true
      when 'admin'
        true
      else
        false #se arrivo qui c'è un errore quindi non autorizzo
      end
    else
      true
    end
  end

  def show?
    if @user.present?
      case @user.role
      when 'user'
        true
      when 'author'
        true
      when 'moderator'
        true
      when 'admin'
        true
      else
        false #se arrivo qui c'è un errore quindi non autorizzo
      end
    else
      false
    end
  end
  
  def create?
    if @user.present?
      case @user.role
      when 'user'
        false
      when 'author'
        true
      when 'moderator'
        true
      when 'admin'
        true
      else
        false #se arrivo qui c'è un errore quindi non autorizzo
      end
    else
      false
    end
  end
  
  def update?
    if @user.present?
      case @user.role
      when 'user'
        false
      when 'author'
        @user.id == @record.user_id
      when 'moderator'
        @user.id == @record.user_id
      when 'admin'
        true
      else
        false #se arrivo qui c'è un errore quindi non autorizzo
      end
    else
      false
    end
  end

  def destroy?
    if @user.present?
      case @user.role
      when 'user'
        false
      when 'author'
        @user.id == @record.user_id
      when 'moderator'
        true
      when 'admin'
        true
      else
        false #se arrivo qui c'è un errore quindi non autorizzo
      end
    else
      false
    end
  end
```

[Codice 03](#01-09-06_03all)

In questo modo mi è molto più chiaro capire la logica delle autorizzazioni.




## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

- https://mycloud9path.amazonaws.com/eg_posts



## aggiorniamo git 

```bash
$ git add -A
$ git commit -m "Refactor policies conditions like the logical schema"
```



## Publichiamo su heroku

```bash
$ git push heroku aep:master
$ heroku run rake db:migrate
```

Ricordiamo che lato produzione su heroku c'è un database indipendente da quello di sviluppo. Se si è seguito il tutorial avremo la tabella già con i records inseriti e quindi speculare a quella di sviluppo.



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge aep
$ git branch -d aep
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin master
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
