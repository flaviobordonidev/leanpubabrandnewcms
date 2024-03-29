# <a name="top"></a> 4.1 - Implementiamo la gestione degli utenti

Come amministatore creiamo nuovi utenti e gestiamo i loro ruoli.
Adesso che abbiamo tutto predisposto iniziamo ad incorporare l'autorizzazione nel template della nostra applicazione.



## Risorse interne

- [99-rails_references-authentication_devise-02-devise]



## Apriamo il branch "Gestione Utenti"

```bash
$ git checkout -b gu
```



## UsersController

La cartella `users` è stata creata direttamente da Devise.
Non avendo usato il comando *scaffold* per la creazione della tabella `users` non abbiamo nè `users_controller` nè le *views* standard *"restfull"*.

Creiamo il *controller* per la tabella `users`.

> Nota che `users` è **plurale** quando si crea il controller. 
> (al contrario dello scaffold in cui si usa il singolare)

```bash
$ rails g controller users index
```

Esempio:
  
```bash
ubuntu@ubuntufla:~/ubuntudream (gu)$rails g controller users index
      create  app/controllers/users_controller.rb
       route  get 'users/index'
      invoke  erb
       exist    app/views/users
      create    app/views/users/index.html.erb
      invoke  test_unit
      create    test/controllers/users_controller_test.rb
      invoke  helper
      create    app/helpers/users_helper.rb
      invoke    test_unit
ubuntu@ubuntufla:~/ubuntudream (gu)$
```

Inizializiamo con la sola azione *index* perché le altre le aggiungiamo di volta in volta.

> Avremmo potuto inizializzare tutte e 7 le azioni restfull con `$ rails g controller users index show new edit create update destroy`.



## Vediamo le colonne della tabela users

Le vediamo sullo schema del database.

***Codice 01 - .../db/schema.rb - linea:45***

```ruby
  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.string "bio"
    t.string "phone_number"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_01-db-schema.rb)

Queste colonne ci sono utili nel prossimo paragrafo in cui usiamo il comando *scaffold*.


## Usiamo *scaffold* per un controller di *esempio*

Usiamo il comando `generate scaffold` che non abbiamo potuto usare prima per creare la tabella `users` e lo usiamo per creare la tabella `eg_users` che usiamo solo come *esempio*.

> Mettiamo il prefisso *eg_* davanti al nome della tabella per indicare che è un *esempio*. <br/>
> In inglese *e.g.* è l'abbriviazione di *for example*, dal latino: *exempli gratia*. 

> Nota che `EgUser` è **singolare** perché stiamo usando lo *scaffold*. 

```bash
$ rails g scaffold EgUser username:string first_name:string last_name:string location:string bio:string phone_number:string email:string encrypted_password:string
```

> Il comando *scaffold* oltre alla tabella crea tutta l'infrastruttura *restfull* con controllers e views con già del codice coerente con le convenzioni rails.

- ***Non*** eseguiamo il *db:migrate* ed ***eliminiamo*** il file migrate `.../db/migrate/xxx_create_eg_users.rb` perché non vogliamo creare nel database la tabelle `eg_users`.
- ***eliminiamo*** il file `.../app/model/eg_user.rb`.
- ***eliminiamo*** la riga `resources :eg_users` su `.../config/routes.rb`.

> Mano a mano che li usiamo cancelliamo anche gli altri files "eg_users" perché ci servono solo come esempio per implementare i files "users".



## Implementiamo l'azione index

Aiutandoci con *eg_users_controler* implementiamo l'azione *index*.

***Codice 02 - .../app/controllers/users_controller.rb - linea:02***

```ruby
  # GET /users or /users.json
  def index
    @users = User.all
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_02-controllers-users_controller.rb)



## Creiamo la view index

Aiutandoci con `views/eg_users/index.html.erb` implementiamo la view *users/index*.

***Codice 03 - .../app/views/users/index.html.erb - linea:05***

```html+erb
<div id="users">
  <% @users.each do |user| %>
    <%= render user %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_03-views-users-index.html.erb)


***Codice 04 - .../app/views/users/_user.html.erb - linea:01***

```html+erb
<div id="<%= dom_id user %>">
  <p>
    <strong>Username:</strong>
    <%= user.username %>
  </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_04-views-users-_user.html.erb)

> Il codice rails `dom_id user` permette di dare un *id* per ogni utente: `<div id="user_1">`, `<div id="user_2">`, ...



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

- http://192.168.64.3:3000/users

> Se non siamo loggati abbiamo un errore! <br/>
> Non mettiamo un controllo perché questa view la renderemo visibile solo agli utenti loggati.



## Implementiamo l'azione show

Aggiorniamo il controller implementando l'azione *show* per visualizzare il singolo utente.
Copiamo ed implementiamo la parte di codice per l'azione *show*, il *before_action* lo lasciamo perché ci è utile per le prossime azioni che implementeremo.

***Codice 05 - .../app/controllers/users_controller.rb - linea:02***

```ruby
  before_action :set_user, only: %i[ show ]
```

> Su rails 6 si usava `before_action :set_user, only: [:show]`
> Su rails 7 si è scelto `before_action :set_user, only: %i[ show ]`

***Codice 05 - ...continua - linea:10***

```ruby
  # GET /eg_users/1 or /eg_users/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_05-controllers-users_controller.rb)

Per la sola azione *show* si poteva evitare il metodo privato *before_action*.

***codice n/a - .../app/controllers/users_controller.rb - line:n/a***

```ruby
  def show
      @user = User.find(params[:id])
  end
```

Ma è utile estrarre `@user = User.find(params[:id])` in un metodo private perché questo è chiamato anche da altre azioni (:show, :edit, :update e :destroy).



## Creiamo la view show

Aiutandoci con `views/eg_users/show.html.erb` implementiamo la view *users/show*.

***Codice 06 - .../app/views/users/show.html.erb - linea:03***

```html+erb
<%= render @user %>

<div>
  <%= link_to "Edit this user", edit_user_path(@user) %> |
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_06-views-users-show.html.erb)



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

- http://192.168.64.3:3000/users/1




## Implementiamo l'azione edit

Aggiorniamo il controller implementando le azioni *edit* ed *update* per editare i campi del singolo utente.
Copiamo da *eg_users_controller.rb* la parte di codice per le azioni *edit* ed *update* e la implementiamo.

***Codice 07 - .../app/controllers/users_controller.rb - linea:02***

```ruby
  before_action :set_user, only: %i[ show edit update ]
```

***Codice 07 - ...continua - linea:13***

```ruby
  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
```

> Su rails 6 si usava `redirect_to @user, notice: 'User was successfully updated.'`
> Su rails 7 si usa `redirect_to user_url(@user), notice: "User was successfully updated."`

> Su rails 6 si usava `render :edit`
> Su rails 7 si usa `render :edit, status: :unprocessable_entity` per via di turbo_drive.

***Codice 07 - ...continua - linea:36***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :location, :bio, :phone_number, :email, :encrypted_password)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_07-controllers-users_controller.rb)



## Creiamo la view edit

Aiutandoci con `views/eg_users/edit.html.erb` implementiamo la view *users/edit*.

***Codice 08 - .../app/views/users/edit.html.erb - linea:03***

```html+erb
<%= render "form", user: @user %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_08-views-users-edit.html.erb)


***Codice 09 - .../app/views/users/_form.html.erb - linea:01***

```html+erb
<%= form_with(model: user) do |form| %>
```

***Codice 09 - ...continua - linea:14***

```html+erb
  <div>
    <%= form.label :username, style: "display: block" %>
    <%= form.text_field :username %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_09-views-users-_form.html.erb)

> Su rails 6 si usava `<%= form_with(model: user, local: true) do |form| %>`
> Su rails 7 si usa `<%= form_with(model: user) do |form| %>` perché *local: true* è diventato di default.



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

- http://192.168.64.3:3000/users/1/edit

Con questo form possiamo cambiare il nome e l'email ma non possiamo cambiare la password perché è criptata. 
O meglio, se cambiamo la password criptata non possiamo più loggarci perché non possiamo risalire alla password in chiaro.



## Implementiamo i campi password e password_confirmation

Devise ci offre la soluzione perché accetta la password passata attraverso i campi *password* e *password_confirmation*
Quindi usiamo questi campi al posto del campo *encrypted_password*.

> Non dobbiamo avere questi campi nella tabella *users*. devise la cripta e l'archivia nel campo *encrypted_password*.

***Codice 10 - .../app/views/users/_form.html.erb - linea:49***

```html+erb
  <div>
    <%= form.label :password, style: "display: block" %>
    <%= form.password_field :password %>
  </div>

  <div>
    <%= form.label :password_confirmation, style: "display: block" %>
    <%= form.password_field :password_confirmation %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_10-views-users-_form.html.erb)

Ed aggiorniamo la *white-list* del controller 

***Codice 11 - .../app/controllers/users_controller.rb - linea:36***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :location, :bio, :phone_number, :email, :password, :password_confirmation, :encrypted_password)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_11-controllers-users_controller.rb)

Adesso L'update funziona per tutti i campi ma abbiamo un problema di sicurezza perché ogni utente può cambiare nome, email e password a tutti gli utenti.
Questo problema di sicurezza lo risolveremo nei prossimi capitoli.

> Nei prossimi capitoli toglieremo anche `:encrypted_password` sia dalla *white-list* che dalla view.



## Implementiamo l'azione new
Aggiorniamo il controller implementando le azioni *new* e *create* per creare un nuovo utente.
Copiamo ed implementiamo la parte di codice per le azioni *new* e *create*.

***Codice 12 - .../app/controllers/users_controller.rb - linea:14***

```ruby
  # GET /users/new
  def new
    @user = User.new
  end
```

***Codice 12 - ...continua - linea:23***

```ruby
  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_12-controllers-users_controller.rb)



## Creiamo la view new

Aiutandoci con `views/eg_users/new.html.erb` implementiamo la view *users/new*.

***Codice 13 - .../app/views/users/new.html.erb - linea:03***

```html+erb
<%= render 'form', user: @user %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_13-views-users-new.html.erb)

> Il file *_form.html.erb* lo abbiamo già creato implementando l'azione *edit*.
> In pratica la differenza tra *edit* e *new* è tutta nelle azioni del controller.



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

- http://192.168.64.3:3000/users/new

Oltre Ann creiamo altri utenti in modo da averne 6 come da seguente tabella:

name  | email           | password
:-    | :-              |:-
Ann	  | ann@test.abc    | passworda
Bob	  | bob@test.abc    | passwordb
Carl	| carl@test.abc   | passwordc
David	| david@test.abc  | passwordd
Elvis	| elvis@test.abc  | passworde
Flav	| flav@test.abc   | passwordf



## Definiamo le autenticazioni

Le autenticazioni con devise sono implementate in fase di creazione degli utenti. 
Quindi tutti gli utenti che creiamo hanno già il processo di autenticazione con *devise*.

```bash
$ rails c
-> User.all
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (gu) $ rails c
Loading development environment (Rails 7.0.1)
3.1.0 :001 > User.all
  User Load (0.4ms)  SELECT "users".* FROM "users"
 =>                                                         
[#<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2022-01-30 11:50:16.615885000 +0000", updated_at: "2022-02-01 13:59:03.823225000 +0000">,
 #<User id: 2, name: "Bob", email: "bob@test.abc", created_at: "2022-02-01 16:26:18.569214000 +0000", updated_at: "2022-02-01 16:26:18.569214000 +0000">,
 #<User id: 3, name: "Carl", email: "carl@test.abc", created_at: "2022-02-01 16:27:25.761382000 +0000", updated_at: "2022-02-01 16:27:25.761382000 +0000">,
 #<User id: 4, name: "David", email: "david@test.abc", created_at: "2022-02-01 16:28:14.397848000 +0000", updated_at: "2022-02-01 16:28:14.397848000 +0000">,
 #<User id: 5, name: "Elvis", email: "elvis@test.abc", created_at: "2022-02-01 16:29:06.259332000 +0000", updated_at: "2022-02-01 16:29:06.259332000 +0000">,
 #<User id: 6, name: "Flav", email: "flav@test.abc", created_at: "2022-02-01 16:30:09.311443000 +0000", updated_at: "2022-02-01 16:30:09.311443000 +0000">] 
3.1.0 :002 > 
```

Ognuno di questi utenti viene ***autenticato*** inserendo la sua user e password nella pagina di login. 
In altre parole è accettato ad entrare.

Una volta dentro sarà ***autorizzato*** o meno a seconda dei ruoli che gli vengono assegnati.

> l'***autenticazione*** certifica ***che sei tu*** e normalmente ti fa entrare.
> l'***autorizzazione*** è quello ***che puoi fare*** una volta entrato.



## Implementiamo l'azione destroy

Aggiorniamo il controller implementando l'azione destroy per eliminare un utente.
Copiamo ed implementiamo la parte di codice per l'azione destroy.


***Codice 14 - .../app/controllers/users_controller.rb - linea:02***

```ruby
  before_action :set_user, only: %i[ show edit update destroy ]
```

***Codice 14 - ...continua - linea:51***

```ruby
  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_14-controllers-users_controller.rb)

L'azione *destroy* appena aggiunta è attivata dal pulsante che è su *views/users/show*.

***codice n/a - .../app/views/users/show.html.erb - line: 9***

```
  <%= button_to "Destroy this user", @user, method: :delete %>
```

> Su rails 6 si usava `<%= link_to 'Destroy', user, method: :delete, data: { confirm: 'Are you sure?' } %>`
> Su rails 7 si usa `<%= button_to "Destroy this user", @user, method: :delete %>`
> Quindi non abbiamo più la richiesta di conferma di eliminazione.



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

- http://192.168.64.3:3000/users

Eliminiamo l'ultimo utente "flav".

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/01_fig01-user_successfully_destroyed.png)


## Salviamo su git

```bash
$ git add -A
$ git commit -m "Implement views to manage users"
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge gu
$ git branch -d gu
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



## Pubblichiamo su render.com

Da https://dashboard.render.com/ -> Manual Deploy -> Deploy latest commit.

(il db:migrate lo fa in automatico ^_^)

Popoliamo con i 6 utenti anche il database remoto. Lo facciamo a partire dall'URL:

- https://ubuntudream.onrender.com/users

> se non siamo loggati abbiamo un errore.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/05_00-navbar-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/02_00-users_protected-it.md)
