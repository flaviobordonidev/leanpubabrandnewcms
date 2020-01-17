{id: 01-base-13-roles-03-roles-enum}
# Cap 13.3 -- Roles - enum

Questo approccio è semplice e permette di avere più ruoli fissi (es: user, vip, admin) o (es: silver, gold, platinum, diamond).
Questo livello permette di gestire più del 90% delle esigenze delle applicazioni web. Usato con pundit e devise riesce a coprire quasi tutte le esigenze di autorizzazione.
Per questo motivo rolify è stato messo su una sezione distinta, proprio perché è una gemma che, quasi sempre, possiamo evitare di installare.

Aggiungiamo i vari ruoli utilizzando un attributo (role attribute) e non un intero modello.
Questo vuol dire aggiungere una colonna "role" di tipo integer sulla tabella "users" e dichiarare l'uso di "enum" sul model User.

Volendo usare "rolify" possiamo saltare direttamente alla sezione 10-rolification


Risorse interne:

* 99-rails_references/authentication_authorization_roles/04-roles_enum




## Apriamo il branch "Roles Enum"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b re
```




## Aggiungiamo il campo roles:enum alla tabella users

nel db postgresql si possono implementare dei campi di tipo "enum" ma per attivare la gestione "enum" di Rails usiamo la tipologia "integer" nel db. Implementeremo la gestione del campo con la tipologia "enum" direttamente nel model più avanti in questo capitolo.

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g migration add_role_to_users role:integer
```

Modifichiamo il migrate aggiungendo un default e l'indice per velocizzare queries che usano "role"

{id: "01-13-03_01", caption: ".../db/migrate/xxx_add_role_to_users.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
    add_column :users, :role, :integer, default: 0
    add_index :users, :role, unique: false
```

[tutto il codice](#01-13-03_01all)


Effettuiamo il migrate del database per creare la tabella sul database

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails db:migrate
```


ed otteniamo le seguenti modifiche alla tabella "users"

{id: "01-13-03_02", caption: ".../db/schema.rb -- codice 02", format: ruby, line-numbers: true, number-from: 77}
```
    t.integer "role", default: 0
```

{caption: ".../db/schema.rb -- continua", format: ruby, line-numbers: true, number-from: 80}
```
    t.index ["role"], name: "index_users_on_role"
```

[tutto il codice](#01-13-03_02all)


Avremmo potuto aggiungere l'indice anche in un secondo momemento

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g migration add_index_to_role_to_users
```

{title=".../db/migrate/xxx_add_index_to_role_to_users.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
    add_index :users, :role, unique: false
```




## Aggiorniamo il Model implementando ENUM

{id: "01-13-03_03", caption: ".../models/user.rb -- codice 03", format: ruby, line-numbers: true, number-from: 3}
```
  #enum role: [:user, :admin, :moderator, :author]
  enum role: {user: 0, admin: 1, moderator:2, author:3}
```

[tutto il codice](#01-13-03_03all)

Le due linee di codice in alto sono equivalenti solo la seconda linea di codice è più flessibile per eventuali aggiunte o eliminazioni all'elenco.


Se non avessimo voluto usare il default lato database con "default: 0" avremmo potuto farlo nel model in questo modo:  

{caption: ".../models/user.rb -- codice s.n.", format: ruby, line-numbers: true, number-from: 7}
```
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end
```

ma lato database è più pulito e più prestazionale.




## Assegnamo un ruolo ai nostri utenti da terminale rails

Apriamo il terminale

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c


c2-user:~/environment/myapp (ra) $ rails c
Running via Spring preloader in process 5590
Loading development environment (Rails 5.2.2)
2.4.1 :001 > 
```

verifichiamo tutti i ruoli presenti nella colonna "role" assegnata ad enum.

{caption: "terminal", format: bash, line-numbers: false}
```
-> User.roles


2.4.1 :001 > User.roles
 => {"user"=>0, "admin"=>1, "moderator"=>2, "author"=>3} 
```

verifichiamo che tutti gli utenti hanno il campo della colonna role con il valore di default "0", che per enum corrisponde al valore "user".

{caption: "terminal", format: bash, line-numbers: false}
```
-> User.all


2.4.1 :002 > User.all
  User Load (0.3ms)  SELECT  "users".* FROM "users" LIMIT $1  [["LIMIT", 11]]
 => #<ActiveRecord::Relation [#<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2019-01-04 11:53:46", updated_at: "2019-01-06 09:32:02", role: "user">, #<User id: 2, name: "Bob", email: "bob@test.abc", created_at: "2019-01-06 09:40:34", updated_at: "2019-01-06 09:40:34", role: "user">, #<User id: 3, name: "Carl", email: "carl@test.abc", created_at: "2019-01-06 09:40:51", updated_at: "2019-01-06 09:40:51", role: "user">, #<User id: 4, name: "David", email: "david@test.abc", created_at: "2019-01-06 09:41:12", updated_at: "2019-01-06 09:41:12", role: "user">, #<User id: 5, name: "Elvis", email: "elvis@test.abc", created_at: "2019-01-06 09:41:30", updated_at: "2019-01-06 23:46:51", role: "user">]> 
```




## rendiamo il primo utente amministratore.

{caption: "terminal", format: bash, line-numbers: false}
```
-> User.first.admin!

oppure

-> User.first.update(role: :admin)

oppure

-> u= User.first 
-> u.role = :admin 
-> u.save 
```

ATTENZIONE! se ho dei validation potrei ricevere un errore perché rails si aspetta che gli vengano passati tutti i parametri!

In questo caso o commentiamo i "validates" nel model oppure usiamo ".save(validate: false)" come possiamo vedere in questo esempio:

{caption: "terminal", format: bash, line-numbers: false}
```
2.6.3 :069 > User.first.admin!
  User Load (0.7ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
   (0.3ms)  BEGIN
  User Exists? (0.4ms)  SELECT 1 AS one FROM "users" WHERE "users"."name" = $1 AND "users"."id" != $2 LIMIT $3  [["name", "Ann"], ["id", 1], ["LIMIT", 1]]
  User Exists? (0.2ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 AND "users"."id" != $2 LIMIT $3  [["email", "ann@test.abc"], ["id", 1], ["LIMIT", 1]]
   (0.2ms)  ROLLBACK
Traceback (most recent call last):
        2: from (irb):69
        1: from (irb):69:in `rescue in irb_binding'
ActiveRecord::RecordInvalid (translation missing: it.activerecord.errors.messages.record_invalid)
2.6.3 :070 > User.first.update(role: :admin)
  User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
   (0.3ms)  BEGIN
  User Exists? (0.3ms)  SELECT 1 AS one FROM "users" WHERE "users"."name" = $1 AND "users"."id" != $2 LIMIT $3  [["name", "Ann"], ["id", 1], ["LIMIT", 1]]
  User Exists? (0.2ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 AND "users"."id" != $2 LIMIT $3  [["email", "ann@test.abc"], ["id", 1], ["LIMIT", 1]]
   (0.1ms)  ROLLBACK
 => false 
2.6.3 :071 > u= User.first
  User Load (0.6ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
 => #<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2019-11-05 15:17:00", updated_at: "2020-01-16 11:34:23", role: "user"> 
2.6.3 :072 > u.role = :admin
 => :admin 
2.6.3 :073 > u.save
   (0.5ms)  BEGIN
  User Exists? (0.3ms)  SELECT 1 AS one FROM "users" WHERE "users"."name" = $1 AND "users"."id" != $2 LIMIT $3  [["name", "Ann"], ["id", 1], ["LIMIT", 1]]
  User Exists? (0.3ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 AND "users"."id" != $2 LIMIT $3  [["email", "ann@test.abc"], ["id", 1], ["LIMIT", 1]]
   (0.2ms)  ROLLBACK
 => false 
2.6.3 :074 > u.save(validate: false)
   (0.6ms)  BEGIN
  User Update (0.5ms)  UPDATE "users" SET "updated_at" = $1, "role" = $2 WHERE "users"."id" = $3  [["updated_at", "2020-01-16 11:46:44.730414"], ["role", 1], ["id", 1]]
   (1.2ms)  COMMIT
 => true 
2.6.3 :075 > u.admin?
 => true 
2.6.3 :076 > 
```




## verifichiamo che ruolo hanno il primo ed il secondo utente

{caption: "terminal", format: bash, line-numbers: false}
```
-> User.first.admin?
 => true 

-> User.second.admin? 
 => false 

-> User.second.user?
 => true

-> User.first.role
 => "admin" 

-> User.second.role
 => "user" 
```

prendiamo una lista di tutti gli :admin

{caption: "terminal", format: bash, line-numbers: false}
```
-> User.admin


2.4.1 :024 > User.admin
  User Load (0.2ms)  SELECT  "users".* FROM "users" WHERE "users"."role" = $1 LIMIT $2  [["role", 1], ["LIMIT", 11]]
 => #<ActiveRecord::Relation [#<User id: 1, name: "Ann", email: "ann@test.abc", created_at: "2019-01-04 11:53:46", updated_at: "2019-01-08 11:43:42", role: "admin">]> 
```

prendiamo una lista di tutti gli :user

{caption: "terminal", format: bash, line-numbers: false}
```
-> User.user


2.4.1 :025 > User.user
  User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."role" = $1 LIMIT $2  [["role", 0], ["LIMIT", 11]]
 => #<ActiveRecord::Relation [#<User id: 2, name: "Bob", email: "bob@test.abc", created_at: "2019-01-06 09:40:34", updated_at: "2019-01-06 09:40:34", role: "user">, #<User id: 3, name: "Carl", email: "carl@test.abc", created_at: "2019-01-06 09:40:51", updated_at: "2019-01-06 09:40:51", role: "user">, #<User id: 4, name: "David", email: "david@test.abc", created_at: "2019-01-06 09:41:12", updated_at: "2019-01-06 09:41:12", role: "user">, #<User id: 5, name: "Elvis", email: "elvis@test.abc", created_at: "2019-01-06 09:41:30", updated_at: "2019-01-06 23:46:51", role: "user">]> 
```

prendiamo una lista di tutti i :moderator

{caption: "terminal", format: bash, line-numbers: false}
```
-> User.moderator


2.4.1 :026 > User.moderator
  User Load (0.6ms)  SELECT  "users".* FROM "users" WHERE "users"."role" = $1 LIMIT $2  [["role", 2], ["LIMIT", 11]]
 => #<ActiveRecord::Relation []> 
```

usciamo

{caption: "terminal", format: bash, line-numbers: false}
```
-> exit
```




## Salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Add role:enum to table users"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku re:master
$ heroku run rails db:migrate
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge re
$ git branch -d re
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#01-09-03_01)

{id="01-09-03_01all", title=".../db/migrate/xxx_add_role_to_users.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :integer, default: 0
    add_index :users, :role, unique: false
  end
end
```




[Codice 02](#01-09-03_02)

{id="01-09-03_02all", title=".../db/schema.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_08_110724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "example_companies", force: :cascade do |t|
    t.string "name"
    t.text "sector"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "example_posts", force: :cascade do |t|
    t.string "title"
    t.text "incipit"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_example_posts_on_user_id"
  end

  create_table "example_users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "encrypted_password"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "example_posts", "users"
end
```




[Codice 03](#01-09-03_03)

{id="01-09-03_03all", title=".../models/user.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
class User < ApplicationRecord
  #enum role: [:user, :admin, :moderator, :author]
  enum role: {user: 0, admin: 1, moderator:2, author:3}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :eg_posts
end
```




[Codice 04](#01-09-03_04)

{id="01-09-03_04all", title=".../db/schema.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    users_path
    #current_user
  end

  protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:role])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
      devise_parameter_sanitizer.permit(:account_update, keys: [:role])
    end
end
```




[Codice 05](#01-09-03_05)

{id="01-09-03_05all", title=".../app/controllers/users_controller.rb", lang=ruby, line-numbers=on, starting-line-number=1}
```
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end
  
  # GET /users/1/edit
  def edit
  end

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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    current_user_temp = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html do
          # Logghiamoci di nuovo automaticamente bypassando le validazioni
          sign_in(@user, bypass: true) if @user == current_user_temp
          redirect_to @user, notice: 'User was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy unless @user == current_user
    respond_to do |format|
      format.html do 
        redirect_to users_url, notice: 'User was successfully destroyed.' unless @user == current_user
        redirect_to users_url, notice: 'Non posso eliminare utente loggato.' if @user == current_user
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :remember_created_at, :role)
    end

end
```




[Codice 06](#01-09-03_06)

{id="01-09-03_06all", title=".../app/views/users/_form.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```

```
