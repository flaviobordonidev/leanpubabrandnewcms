# <a name="top"></a> Cap 15.3 - Implementiamo le autorizzazioni per users

Autentichiamo ed Autorizziamo la gestione degli utenti (users) in funzione del ruolo.

Finalmente cominciamo ad attivare la sicurezza ed iniziamo definendo le autorizzazioni per la gestione degli utenti.



## Risorse interne

- [99-rails_references/authentication_authorization_roles/05-pundit]()



## Apriamo il branch "Authorization Users"

```bash
$ git checkout -b au
```



## Aggiungiamo policy per User

Per aggiungere una policy per un modello specifico aggiungiamo il nome del model.

```bash
$ rails g pundit:policy User
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (main) $ rails g pundit:policy User
      create  app/policies/user_policy.rb
      invoke  test_unit
      create    test/policies/user_policy_test.rb
user_fb:~/environment/bl7_0 (main) $ 
```

questo ci crea la seguente policy


***codice 01 - .../app/policies/user_policy.rb - line: 1***

```ruby
class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/03_01-policies-user_policy.rb)



## Attenzione con aws IAM users

> Normalmente possiamo saltare questo paragrafo

Se come IAM user può succedere un problema di autorizzazioni sui files.
Se non si fossero gestite bene le autorizzazioni potrebbe essere necessario lanciare lo script come root. 
Si dovrà successivamente rivedere le autorizzazioni dei files creati o ricopiare il codice su nuovi files. 
Se il file è stato creato lanciando lo script come root per poter modificare i files crearne uno nuovo, copiarci tutto il codice ed eliminare il vecchio.

Esempio:

```bash
cloud9:~/environment/rigenerabatterie (au) $ sudo su
[root@ip-172-31-7-7 rigenerabatterie]# rails g pundit:policy User
Running via Spring preloader in process 574
      create  app/policies/user_policy.rb
      invoke  test_unit
      create    test/policies/user_policy_test.rb
[root@ip-172-31-7-7 rigenerabatterie]# exit
exit
```



## Aggiungiamo il ruolo di amministratore al primo utente da console

Al momento qualsiasi utente che fa login può impostare il ruolo di admin da interfaccia grafica (GUI).
Però a breve limiteremo la GUI.
Quindi rivediamo come assegnare il ruolo di amministratore da console. 

> Usando *enum* associamo il ruolo *admin* al primo utente.

```bash
$ rails c
-> u= User.first
-> u.role = :admin
-> u.save(validate: false)
```

> Usiamo il codice che ci permette di "skippare" delle eventuali validazioni nel model.
> Altrimenti avremmo potuto anche usare `User.first.admin!` o `User.first.update(role: :admin)`.

Esempio:
  
```bash

2.6.3 :004 > u= User.first
  User Load (0.5ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
 => #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2019-11-05 15:17:00", updated_at: "2020-01-16 11:46:44", role: "admin"> 
2.6.3 :005 > u.role = :admin
 => :admin 
2.6.3 :006 > u.save(validate: false)
 => true 
```




## Solo *admin* può creare nuovo utente

Implementiamo la policy che autorizza la creazione di un nuovo utente solo a chi è ammministratore.

***codice 02 - .../app/policies/user_policy.rb - line: 3***

```ruby
  def create?
    @user.admin?
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/03_02-policies-user_policy.rb)

Questo codice indica a pundit di vedere se siamo nell'azione create del controller e la autorizza solo se l'utente è "admin". 
Infatti *@user.admin?* è *TRUE* se l'utente ha il ruolo di amministratore. Altrimenti *@user.admin?* è *FALSE* e pundit non autorizza l'esecuzione.

Non dobbiamo implementare anche la poilcy `def new?` perché su *application_policy* come valori di default abbiamo che `new?` prende le stesse autorizzazioni di `create?`.

***codice n/a - .../app/policies/application_policy.rb - line: 23***

```ruby
  def new?
    create?
  end
```



## Implementiamo nel controller

Adesso che la policy di autorizzazione è pronta possiamo indicare alle azioni *create* e *new* del controller *user* di passare per l'autorizzazione (`authorize @user`).

***codice 03 - .../app/controllers/users_controller.rb - line: 14***

```ruby
  # GET /users/new
  def new
    @user = User.new
    authorize @user
```

***codice 03 - ...continua - line: 28***

```ruby
  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    authorize @user
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/03_03-controllers-users_controller.rb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

- https://mycloud9path.amazonaws.com/login

Se ci logghiamo con il secondo utente (Bob) che **non** ha i diritti di amministratore, quando proviamo a creare un nuovo utente riceviamo l'errore: `"Pundit::NotAuthorizedError in UsersController#new"`. <br/>
Se ci logghiamo con il primo utente (Ann) che ha i diritti di amministratore (`role: :administrator`), possiamo creare un nuovo utente senza nessun errore.



## Aggiorniamo git 

```bash
$ git add -A
$ git commit -m "add pundit authorization on actions new and create of users"
```



## Rimuoviamo la protezione di Devise

Togliamo la protezione di Devise per le views *users* così rinforziamo il nostro scope di pundit (la nostra autorizzazione) includendo anche il caso di un utente non autenticato (non loggato).

***codice n/a - .../app/controllers/users_controller.rb - line: 2***

```ruby
  #before_action :authenticate_user!
```

Adesso possiamo arrivare a users/index anche senza essere loggati. 
Se proviamo a creare un nuovo utente riceviamo un errore ma non è un errore di autorizzazione di pundit. 
E' un errore nel codice dell'applicazione. Lo risolviamo ed implementiamo l'autorizzazione.

***codice n/a - .../app/policies/user_policy.rb - line: 2***

```ruby
  def create?
    if @user.present?
      @user.admin?
    else
      false
    end
  end
```

Adesso se si prova a creare un nuovo utente senza essere loggati si riceve un errore di **autorizzazione**.



## Completiamo implementando le policies per tutte le azioni rest-full di users

Autorizziamo l'index visibile a tutti mentre tutte le altre azioni le può eseguire solo l'amministratore. 
Inoltre mettiamo un controllo per vedere se è presente un utente loggato. 
Nel caso in cui nessuno ha fatto login permettiamo solo la visualizzazione dell'index e vietiamo tutto il resto.

Unica eccezione è l'azione show che può essere eseguita:

- sia dall'amministratore per tutti i record della tabella users.
- sia da qualsiasi utente loggato ma SOLO per il suo record della tabella users.

***codice 04 - .../app/policies/user_policy.rb - line: 2***

```ruby
  def index?
    true
  end

  def show?
    if @user.present?
      @user.admin? or @user == @record
    else
      false
    end
  end

  def create?
    if @user.present?
      @user.admin?
    else
      false
    end
  end

  def update?
    if @user.present?
      @user.admin?
    else
      false
    end
  end

  def destroy?
    if @user.present?
      @user.admin?
    else
      false
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/03_04-policies-user_policy.rb)

La linea di codice `@user == @record` verifica se l'utente loggato è lo stesso del record a cui si vuole accedere.

Questo perché nelle policies di pundit abbiamo che:

- la variabile ***@user*** rappresenta l'utente loggato.
- la variabile ***@record*** rappresenta l'utente nel database.

> Attenzione a non confondersi! Perché nel resto del codice abbiamo che: <br/>
> Normalmente in Rails per riferirci all'utente loggato usiamo il metodo ***current_user***.
> e per riferirci all'utente nel database usiamo la variabile ***@user***.

La variabile ***@record*** è definita sulla classe *ApplicationPolicy* da cui la ereditiamo.



## Implementiamo nel controller

Adesso che la policy di autorizzazione è pronta possiamo indicare a tutte le azioni del controller *users* di passare per l'autorizzazione (`authorize @user`).

Le azioni *new* e *create* le abbiamo già fatte. Autorizziamo l'azione *index*.

***codice 05 - .../app/controllers/users_controller.rb - line: 9***

```ruby
  # GET /users or /users.json
  def index
    @users = User.all
    authorize @users
```

Per le azioni *[:show, :edit, :update, :destroy]*, che chiamano la funzione *set_user* con il *before_action*, inserisco l'autorizzazione direttamente sulla funzione *set_user*.

***codice 05 - ...continua - line: 81***

```ruby
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      authorize @user
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/03_05-controllers-users_controller.rb)


> Attenzione: L'azione *index* ha `authorize @users` (plurale), tutte le altre azioni hanno `authorize @user` (singolare).



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

- https://mycloud9path.amazonaws.com/users

Se non siamo loggati come amministratori, tentando *editare* *creare nuovo* o *eliminare* un utente, riceveremo l'errore di azione non autorizzata: *Pundit::NotAuthorizedError*.



## Aggiorniamo git 

```bash
$ git add -A
$ git commit -m "add pundit authorization on all actions of users"
```



## Messaggio di non autorizzato invece dell'errore

In fase di sviluppo l'errore Pundit::NotAuthorizedError è gestibile ma in fase di produzione no. 
Riceveremmo solo una pagina bianca con "Ops! c'è stato un errore".
E' quindi opportuno gestire l'errore reindirizzando sulla pagina che ha provocato l'azione non autorizzata e visualizzando un messaggio di "non autorizzato".

Per farlo aggiungiamo il `rescue_from Pundit::NotAuthorizedError` ad *ApplicationController*.

***codice 6 - .../app/controllers/application_controller.rb - line. 6***

```ruby
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
```

e nella sezione *private* mettiamo il metodo `user_not_authorized`.

***codice 6 - ...continua - line: 56***

```ruby
    def user_not_authorized
      redirect_to request.referrer || root_path, notice: "You are not authorized to perform this action."
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/03_06-controllers-application_controller.rb)


> il codice *protected* è prima del codice *private* perché è meno restrittivo.
>
> Dal più accessibile al più restrittivo abbiamo: *public* -> *protected* -> *private*.



## verifichiamo

```bash
$ sudo service postgresql start
$ rails s
```

Se non siamo loggati come amministratori, tentando violare le autorizzazioni impostate, riceveremo il messaggio "You are not authorized to perform this action." ("Non sei autorizzato ad eseguire questa azione.").



## Aggiorniamo git 

```bash
$ git add -A
$ git commit -m "Rescue from Pundit::NotAuthorizedError"
```



## Rimettiamo la protezione di Devise 

Rimettiamo la protezione di Devise per le views *users*.

***codice n/a - .../app/controllers/users_controller.rb - line: 2***

```ruby
  before_action :authenticate_user!
```



## Implementiamo l'autorizzazione per il cambio di ruolo

Solo admin deve poter cambiare il ruolo!
Lo so che tutta l'azione edit è già autorizzata da pundit ma aggiungiamo questa nel caso in cui volessimo permettere modifiche solo al proprio record dell'utente loggato, come facciamo per show. 

> Non sarà comunque il nostro caso perché le eventuali modifiche dell'utente loggato le faremmo fare a "registerable" di devise, però una sicurezza in più non guasta ^_^.

Per questa autorizzazione non ci serve scomodare pundit. Scomodiamo solo l'helper di Devise.

Inseriamo un controllo nel selettore che permettere di cambiare ruolo e lo visualizziamo solo se siamo amministratori

***codice 07 - .../app/views/users/_form.html.erb - line: 12***

```html+erb
  <%# if user_signed_in? and current_user.admin? %>
  <% if current_user.present? and current_user.admin? %>
    <div>
      <%= form.label :role %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/03_07-views-users-_form.html.erb)

Adesso solo se l'utente è amministratore può cambiare i ruoli.

> Se ti stai domandando qual'è la differenza fra `user_signed_in?` e `current_user.present?` la risposta è **non c'è nessuna differenza**.



## Evitiamo che l'utente loggato come amministratore cambi il suo ruolo

Evitiamo di tagliarci il ramo su cui siamo seduti (`@user != current_user`) ^_^.

***codice n/a - .../app/views/users/_form.html.erb - line: 12***

```html+erb
  <% if current_user.present? and current_user.admin? and @user != current_user %>
    <div>
      <%= form.label :role %>
```

> Ti ricordo che `!=` è l'opposto di `==`. <br/>
> Ad esempio le due condizioni seguenti sono identiche:
> - `unless user == current_user`
> - `if user != current_user`



## Aggiorniamo git 

```bash
$ git add -A
$ git commit -m "Pundit authorized views/users/edit"
```



## Publichiamo su heroku

```bash
$ git push heroku au:master
```

Non serve `heroku run rails db:migrate` perché non abbbiamo fatto modifiche al database.

Rendiamo amministratore anche il primo utente nel database di heroku.

```bash
$ heroku run rails c
-> u= User.first
-> u.role = :admin
-> u.save(validate: false)
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge au
$ git branch -d au
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
