{id: 01-base-09-manage_users-01-manage_users}
# Cap 9.1 -- Implementiamo la gestione degli utenti

Come amministatore creiamo nuovi utenti e gestiamo i loro ruoli.
Adesso che abbiamo tutto predisposto iniziamo ad incorporare l'autorizzazione nel template della nostra applicazione


Risorse interne:

* 99-rails_references-authentication_devise-02-devise




## Apriamo il branch "Gestione Utenti"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b gu
```




## UsersController

non avendo usato lo scaffold per la creazione della tabella users non ho nè le views nè il controller.

Creiamo il controller per la tabella users.

I> Nota che “users” è plurale quando si crea il controller. (al contrario dello scaffold in cui si usa il singolare)

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g controller users index


user_fb:~/environment/bl6_0 (gu) $ rails g controller users index
Running via Spring preloader in process 4015
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
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/users.scss
```

Inizializiamo con la sola azione " index " perché le altre le aggiungiamo di volta in volta.
Avremmo potuto inizializzare tutte e 7 le azioni restfull con " $ rails g controller users index show new edit create update destroy "




## Un controller di esempio

Creiamoci anche uno scaffold di esempio per aiutarci ad inserire il codice nel nostro controller rispettando le convenzioni rails.
Per i campi possiamo rifarci allo schema del database

{id: "01-07-06_01", caption: ".../db/schema.rb -- codice 01", format: ruby, line-numbers: true, number-from: 18}
```
  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
```

[tutto il codice](#01-07-06_01all)



{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g scaffold EgUser name:string email:string encrypted_password:string
```

questo crea il migrate:

{caption: ".../db/migrate/xxx_create_eg_users.rb -- codice 02", format: yaml, line-numbers: true, number-from: 1}
```
class CreateEgUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :eg_users do |t|
      t.string :name
      t.string :email
      t.string :encrypted_password

      t.timestamps
    end
  end
end
```

Effettuiamo il migrate del database per creare la tabella sul database

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate
```

Vediamo che lo schema del database si è aggiornato

{id: "01-07-06_03", caption: ".../db/schema.rb -- codice 03", format: ruby, line-numbers: true, number-from: 18}
```
  create_table "eg_users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "encrypted_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
```

[tutto il codice](#01-07-06_03all)

Potevamo evitare di fare il migrate ed eliminare il file di migrate (.../db/migrate/xxx_create_eg_users.rb) perché questa tabella non la useremo. Lo abbiamo fatto solo a scopo didattico.




### Una furbata

invece di crearci lo scaffold di una tabella example_users avremmo potuto lanciare il comando come se stessimo creando la tabella users senza eseguire il " $ rails db:migrate " e cancellando il file di migrate

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g scaffold User name:string email:string encrypted_password:string remember_created_at:datetime
```

in questo modo avremmo avuto tutto già pronto. :)
Però per la didattica di questo libro creiamo il controller User da zero aiutandoci con EgUser.








## Implementiamo l'azione index 

Vediamo l'index nel controller " eg_users_controler " creato con lo scaffold 

{id: "01-07-06_04", caption: ".../app/controllers/users_controller.rb -- codice 04", format: ruby, line-numbers: true, number-from: 4}
```
  # GET /eg_users
  # GET /eg_users.json
  def index
    @eg_users = EgUser.all
  end
```

[tutto il codice](#01-07-06_04all)

ed aggiorniamo il controller " users_controller " implementando l'azione index per visualizzare l'elenco di tutti gli utenti

{caption: ".../app/controllers/users_controller.rb -- codice 05", format: ruby, line-numbers: true, number-from: 1}
```
class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

end
```




## Creiamo la view index

Apriamo il nuovo file "index.html.erb" dentro la cartella "views/users". Ci copiamo il contenuto di "views/eg_users/index.html.erb" e lo riadattiamo

{id: "01-07-06_06", caption: ".../app/views/users/index.html.erb -- codice 06", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<p id="notice"><%= notice %></p>

<h1>Users</h1>

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Email</th>
```

[tutto il codice](#01-07-06_06all)

Se avessimo voluto tenere tutto organizzato in una sottocartella tipo "views/users/accounts" avremmo dovuto lavorare sul controller e sulla routes come faremo più avanti per authors/posts.




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

* https://mycloud9path.amazonaws.com/users




## Implementiamo l'azione show

Aggiorniamo il controller implementando l'azione show per visualizzare il singolo utente.
Copiamo ed implementiamo la parte di codice per l'azione show, il before_action lo lasciamo perché ci è utile per le prossime azioni che implementeremo.

{id: "01-07-06_07", caption: ".../app/controllers/users_controller.rb -- codice 07", format: ruby, line-numbers: true, number-from: 2}
```
  before_action :set_user, only: [:show]
```

{caption: ".../app/controllers/users_controller.rb -- segue", format: ruby, line-numbers: true, number-from: 10}
```
  # GET /users/1
  # GET /users/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
```

[tutto il codice](#01-07-06_07all)


Per la sola azione user non serviva il before_action con il metodo private. Bastava:

{caption: ".../app/controllers/users_controller.rb -- esempio", format: ruby, line-numbers: true, number-from: 2}
```
  # GET /users/1
  # GET /users/1.json
  def show
      @user = User.find(params[:id])
  end
```

Ma è utile ed elegante estrarre " @user = User.find(params[:id]) " in un metodo private perché questo è chiamato anche da altre azioni (:show, :edit, :update e :destroy)




## Creiamo la view show

Creiamo il nuovo file "show.html.erb" dentro la cartella "views/users". Ci copiamo il contenuto di "views/example_users/show.html.erb" e lo riadattiamo

{id: "01-07-06_08", caption: ".../app/views/users/show.html.erb -- codice 08", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<p id="notice"><%= notice %></p>

<p>
  <strong>Name:</strong>
  <%= @user.name %>
</p>
```

[tutto il codice](#01-07-06_08all)




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

* https://mycloud9path.amazonaws.com/users/1




## Implementiamo l'azione edit

Aggiorniamo il controller implementando le azioni edit ed update per editare i campi del singolo utente.
Copiamo ed implementiamo la parte di codice per le azioni edit ed update.

{id: "01-07-06_09", caption: ".../app/controllers/users_controller.rb -- codice 09", format: ruby, line-numbers: true, number-from: 2}
```
  before_action :set_user, only: [:show, :edit, :update]
```

{caption: ".../app/controllers/users_controller.rb -- segue", format: ruby, line-numbers: true, number-from: 15}
```
  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
```

{caption: ".../app/controllers/users_controller.rb -- segue", format: ruby, line-numbers: true, number-from: 39}
```
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :encrypted_password)
    end
```

[tutto il codice](#01-07-06_09all)




## Creiamo la view edit

Creiamo i nuovi files "edit.html.erb" e "_form.html.erb" dentro la cartella "views/users". Ci copiamo il contenuto dei files su "views/example_users/..." e lo riadattiamo.

{id: "01-07-06_10", caption: ".../app/views/users/edit.html.erb -- codice 10", format: HTML+Mako, line-numbers: true, number-from: 3}
```
<%= render 'form', user: @user %>
```

[tutto il codice](#01-07-06_10all)


{id: "01-07-06_11", caption: ".../app/views/users/_form.html.erb -- codice 11", format: HTML+Mako, line-numbers: true, number-from: 1}
```
<%= form_with(model: user, local: true) do |form| %>

  <div class="field">
    <%= form.label :password %>
    <%= form.text_field :password %>
  </div>

  <div class="field">
    <%= form.label :password_confirmation %>
    <%= form.text_field :password_confirmation %>
  </div>
```

[tutto il codice](#01-07-06_11all)




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

* https://mycloud9path.amazonaws.com/users/1/edit

Con questo form possiamo cambiare il nome e l'email ma non possiamo cambiare la password perché è criptata. O meglio, se cambiamo la password criptata non possiamo più loggarci perché non possiamo risalire alla password in chiaro.




## Implementiamo i campi password e password_confirmation

Devise ci offre la soluzione perché accetta la password passata attraverso i campi " password " e " password_confirmation "
Quindi usiamo questi campi al posto del campo " encrypted_password "

{caption: ".../app/views/users/_form.html.erb -- codice 12", format: HTML+Mako, line-numbers: true, number-from: 24}
```
  <div class="field">
    <%= form.label :password %>
    <%= form.text_field :password %>
  </div>

  <div class="field">
    <%= form.label :password_confirmation %>
    <%= form.text_field :password_confirmation %>
  </div>
```

[tutto il codice](#01-07-06_12all)

Ed aggiorniamo la white-list del controller 

{caption: ".../app/controllers/users_controller.rb -- vedi prossimo codice", format: ruby, line-numbers: true, number-from: 40}
```
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
```

Adesso L'update funziona per tutti i campi ma abbiamo un problema di sicurezza perché ogni utente può cambiare nome, email e password a tutti gli utenti.
Questo problema di sicurezza lo risolveremo nei prossimi capitoli.




## Implementiamo l'azione new
Aggiorniamo il controller implementando le azioni new e create per creare un nuovo utente.
Copiamo ed implementiamo la parte di codice per le azioni new e create.

{id: "01-07-06_13", caption: ".../app/controllers/users_controller.rb -- codice 13", format: ruby, line-numbers: true, number-from: 15}
```
  # GET /users/new
  def new
    @user = User.new
  end
```

{caption: ".../app/controllers/users_controller.rb -- segue", format: ruby, line-numbers: true, number-from: 24}
```
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
```

[tutto il codice](#01-07-06_13all)




## Creiamo la view new

Creiamo il nuovo file "new.html.erb" dentro la cartella "views/users". Ci copiamo il contenuto del file su "views/example_users/..." e lo riadattiamo.

{id: "01-07-06_14", caption: ".../app/views/users/new.html.erb -- codice 14", format: HTML+Mako, line-numbers: true, number-from: 3}
```
<%= render 'form', user: @user %>
```

[tutto il codice](#01-07-06_14all)


Il file "_form.html.erb" lo abbiamo già creato implementando "edit".
In pratica la differenza tra "edit" e "new" è tutta nelle azioni del controller.




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

* https://mycloud9path.amazonaws.com/users/new

Oltre Ann creiamo altri cinque utenti in modo da avere 6 utenti come seguente tabella:

name  | email           | password
------------------------------------------
Ann	  | ann@test.abc    | passworda
Bob	  | bob@test.abc    | passwordb
Carl	| carl@test.abc   | passwordc
David	| david@test.abc  | passwordd
Elvis	| elvis@test.abc  | passworde
flav  | flav@test.abc   | passwordf




## Definiamo le autenticazioni

Le autenticazioni con devise sono implementate in fase di creazione degli utenti. 
Quindi i seguenti utenti che abbiamo già creato hanno tutti il processo di autenticazione con devise:

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c
-> User.all


user_fb:~/environment/bl6_0 (gu) $ rails c
Running via Spring preloader in process 7552
Loading development environment (Rails 6.0.0)
2.6.3 :001 > User.all
  User Load (0.3ms)  SELECT "users".* FROM "users" LIMIT $1  [["LIMIT", 11]]
 => #<ActiveRecord::Relation [#<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2019-11-05 15:17:00", updated_at: "2019-11-11 12:02:16">, #<User id: 2, name: "Bob", email: "bob@test.abc", created_at: "2019-11-11 14:04:30", updated_at: "2019-11-11 14:04:30">, #<User id: 3, name: "Carl", email: "carl@test.abc", created_at: "2019-11-11 14:04:49", updated_at: "2019-11-11 14:04:49">, #<User id: 4, name: "David", email: "david@test.abc", created_at: "2019-11-11 14:05:11", updated_at: "2019-11-11 14:05:11">, #<User id: 5, name: "Elvis", email: "elvis@test.abc", created_at: "2019-11-11 14:05:36", updated_at: "2019-11-11 14:05:36">, #<User id: 6, name: "Flav", email: "flav@test.abc", created_at: "2019-11-11 14:06:22", updated_at: "2019-11-11 14:06:22">]> 
```

Ognuno di questi utenti viene autenticato inserendo la sua user e password nella pagina di login. In altre parole è accettato ad entrare.

Una volta dentro sarà autorizzato o meno a seconda dei ruoli che gli vengono assegnati.




## Implementiamo l'azione destroy

Aggiorniamo il controller implementando l'azione destroy per eliminare un utente.
copiamo ed implementiamo la parte di codice per l'azione destroy.

{id: "01-07-06_15", caption: ".../app/controllers/users_controller.rb -- codice 15", format: ruby, line-numbers: true, number-from: 2}
```
  before_action :set_user, only: [:show, :edit, :update, :destroy]
```

{caption: ".../app/controllers/users_controller.rb -- segue", format: ruby, line-numbers: true, number-from: 15}
```
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
```

[tutto il codice](#01-07-06_15all)




## Verifichiamo il link "destroy" nella view index

{caption: ".../app/views/users/index.html.erb -- verifica", format: HTML+Mako, line-numbers: true, number-from: 25}
```
        <td><%= link_to 'Destroy', user, method: :delete, data: { confirm: 'Are you sure?' } %></td>
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

* https://mycloud9path.amazonaws.com/users

Eliminiamo l'utente "flav" (id: 6)




## Salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Implement views to manage users"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku gu:master
$ heroku run rails db:migrate
```

popoliamo con i 6 utenti anche il database remoto su heroku

Lo potremmo fare da console con

{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku run rails c
```

Ma visto che abbiamo implementato l'interfaccia grafica lo facciamo a partire dall'URL:

* https://bl6-0.herokuapp.com/users




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge gu
$ git branch -d gu
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo





{id: "01-07-06_01all", caption: ".../db/schema.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
```

[tutto il codice](#01-07-06_01)