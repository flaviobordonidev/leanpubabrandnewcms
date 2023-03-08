# <a name="top"></a> Cap 11.3 - Implementiamo le autorizzazioni per users

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
ubuntu@ubuntufla:~/ubuntudream (pi)$rails g pundit:policy User
      create  app/policies/user_policy.rb
      invoke  test_unit
      create    test/policies/user_policy_test.rb
ubuntu@ubuntufla:~/ubuntudream (pi)$
```

questo ci crea la seguente policy


***Codice n/a - .../app/policies/user_policy.rb - linea:01***

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



## Solo *admin* può creare nuovo utente

Implementiamo la policy che autorizza la creazione di un nuovo utente solo a chi è ammministratore.

***Codice n/a - .../app/policies/user_policy.rb - linea:01***

```ruby
class UserPolicy < ApplicationPolicy
  def create?
    @user.admin?
  end
  
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
```

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

***Codice n/a - .../app/controllers/users_controller.rb - line: 14***

```ruby
  # GET /users/new
  def new
    @user = User.new
    authorize @user
```

***Codice n/a - ...continua - line: 28***

```ruby
  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    authorize @user
```



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

- http://192.168.64.3:3000/users

Se ci logghiamo con un utente che **non** ha i diritti di amministratore, quando proviamo a creare un nuovo utente riceviamo l'errore: `"Pundit::NotAuthorizedError in UsersController#new"`.

Se ci logghiamo con un utente che ha i diritti di amministratore (`role: :administrator`), possiamo creare un nuovo utente senza nessun errore.



## Completiamo implementando le policies per tutte le azioni rest-full di users

Autorizziamo l'index visibile a tutti mentre tutte le altre azioni le può eseguire solo l'amministratore. 
Inoltre mettiamo un controllo per vedere se è presente un utente loggato. 
Nel caso in cui nessuno ha fatto login permettiamo solo la visualizzazione dell'index e vietiamo tutto il resto.

Uniche eccezioni sono le azioni `show` ed `edit/update` che possono essere eseguite da:

- l'amministratore per tutti i record della tabella users.
- Qualsiasi utente loggato ma SOLO per il suo record della tabella users.

***Codice 01 - .../app/policies/user_policy.rb - linea:02***

```ruby
  def index?
    @user.admin?
  end

  def show?
    @user.admin? or @user == @record
  end

  def create?
    @user.admin?
  end

  def update?
    @user.admin? or @user == @record
  end

  def destroy?
    @user.admin?
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/11-authorization/03_01-policies-user_policy.rb)

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

***Codice 02 - .../app/controllers/users_controller.rb - linea:06***

```ruby
  # GET /users or /users.json
  def index
    @users = User.all
    authorize @users
```

Per le azioni *[:show, :edit, :update, :destroy]*, che chiamano la funzione *set_user* con il *before_action*, inserisco l'autorizzazione direttamente sulla funzione *set_user*.

***Codice 02 - ...continua - linea:72***

```ruby
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      authorize @user
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/11-authorization/03_02-controllers-users_controller.rb)


> Attenzione: L'azione *index* ha `authorize @users` (plurale), tutte le altre azioni hanno `authorize @user` (singolare).



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

- http://192.168.64.3:3000/users

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

Per farlo aggiungiamo il `rescue_from Pundit::NotAuthorizedError` ad `ApplicationController`.

***Codice 03 - .../app/controllers/application_controller.rb - linea:05***

```ruby
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
```

e nella sezione *private* mettiamo il metodo `user_not_authorized`.

***Codice 03 - ...continua - linea:29***

```ruby
    # Pundit rescue_from
    def user_not_authorized
      redirect_to request.referrer || root_path, notice: "You are not authorized to perform this action."
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/11-authorization/03_03-controllers-application_controller.rb)

> il codice `protected` è prima del codice `private*`perché è meno restrittivo. <br/>
> Dal più accessibile al più restrittivo abbiamo: `public` -> `protected` -> `private`.



## Implementiamo l'autorizzazione per il cambio di ruolo

Solo admin deve poter cambiare il ruolo!

> Per questa autorizzazione non ci serve scomodare pundit. Scomodiamo solo l'helper di *devise*.

Inseriamo un controllo nel selettore che permettere di cambiare ruolo e lo visualizziamo solo se siamo amministratori

***Codice n/a - .../app/views/users/_form.html.erb - linea:12***

```html+erb
  <% if current_user.admin? %>
    <div>
      <%= form.label :role %>
```

Adesso solo se l'utente è amministratore può cambiare i ruoli.



## Evitiamo che l'utente loggato come amministratore cambi il suo ruolo

Evitiamo di tagliarci il ramo su cui siamo seduti (`@user != current_user`) ^_^.

***codice 04 - .../app/views/users/_form.html.erb - line: 12***

```html+erb
  <% if current_user.admin? and @user != current_user %>
    <div>
      <%= form.label :role %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/03_07-views-users-_form.html.erb)

> Ti ricordo che `!=` è l'opposto di `==`. <br/>
> Ad esempio le due condizioni seguenti sono identiche:
> - `unless user == current_user`
> - `if user != current_user`



## Aggiorniamo git 

```bash
$ git add -A
$ git commit -m "Pundit authorized users"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/02_00-authorization-pundit-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/04_00-authorization-eg_posts-it.md)
