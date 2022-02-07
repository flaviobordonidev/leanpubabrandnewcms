# <a name="top"></a> Cap 13.4 - Implementiamo i ruoli sulla nostra applicazione

Adesso che abbiamo i ruoli nella nostra tabella *users* possiamo implementarli nelle views dellla nostra applicazione.



## Risorse interne

- 99-rails_references-models-04-public-protected-private



## Apriamo il branch "Implement Roles"

```bash
$ git checkout -b ir
```



## Attiviamo la white list sul controller

Invece di cambiare i ruoli da console adesso li cambiamo sulla nostra view.
Abbiamo un piccolo problema. Devise non è come lo scaffold. Non ci crea già le azioni sul controller e le views.

Per poter passare i parametri attraverso le views, o meglio il sumbit del form, dobbiamo inserirli nella white list del controller. Una procedura detta "Strong_params" o "mass-assignment". Ma questo non è così facile su Devise perché di default ci nasconde tutto.

Abbiamo già visualizzato i controllers e le views di devise-users nei capitoli precedenti.
Possiamo passare i parametri in due modi:

1. Usando il controller application (metodo raccomandato dalla Plataformatec creatrice di Devise)
2. Usando i controllers dentro "controllers/users/" ma in questo caso dobbiamo dichiarare ogni controller usato nella routes



### 1. Il metodo raccomandato da plataformatec. Il metodo Lazy way.

Mettiamo nella whitelist la colonna :role. Normalmente andremmo solo su users_controller ma per devise dobbiamo usare anche application_controller.

***codice 01 - .../app/controllers/application_controller.rb - line: 2***

```ruby
  before_action :configure_permitted_parameters, if: :devise_controller?
```

***codice 01 - ...continua - line: 9***

```
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:role])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
end
```

[tutto il codice](#01-13-03_01all)

> il codice "protected" è prima del codice "private" perché è meno restrittivo.
>
> Dal più accessibile al più restrittivo abbiamo: "public" -> "protected" -> "private"

I loro nomi e parametri di default permessi sono:

- sign_in (Devise::SessionsController#create) - Permette solo le chiavi di autenticazione come il campo :email
- sign_up (Devise::RegistrationsController#create) - Permette le chiavi di autenticazione più i campi :password e :password_confirmation
- account_update (Devise::RegistrationsController#update) - Permette le chiavi di autenticazione più i campi :password, :password_confirmation e :current_password


Inoltre mettiamo il campo *:role* nella whitelist di *users_controller*.

***codice 02 - .../app/controllers/users_controller.rb - line: 83***

```ruby
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end
```

[tutto il codice](#01-13-03_02all)



### 2. l'alternativa con i controllers in *controllers/users/*

Non usiamo questa alternativa ma riportiamo comunque un esempio per *users/registration_controller*

***codice n/a - .../app/controllers/users/registrations_controller.rb - line: 11***

```ruby
class RegistrationsController < Devise::RegistrationsController

  ...

  private

  def sign_up_params
    params.require(:user).permit(:role, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:role, :email, :password, :password_confirmation, :current_password)
  end
end
```

L'aggiunta dell'instradamento di *users/registration_controller*.

***codice n/a - .../app/config/routes.rb - line: 8***

```ruby
  devise_for :users, controllers: {sessions: 'users/sessions', registration: 'users/registration'}, path: '', path_names: {sign_in: 'login'}
```



## Aggiorniamo la view

Aggiungiamo un selettore per permettere di cambiare ruolo

***codice n/a - .../app/views/users/_form.html.erb - line: 22***

```html+erb
  <div class="field">    
    <%= form.label :role %>
    <%#= form.text_field :role %>
    <%= form.select(:role, User.roles.keys.map {|role| [role.titleize,role]}) %>
  </div>
```

[Codice 06](#01-09-03_06all)

Attenzione: deve essere attivo solo uno dei due campi: "form.text_field :role" o "form.select(:role...". Se attiviamo entrambi i campi verrà passato come params solo il valore dell'ultimo campo perché hanno lo stesso nome.

> Per approfondimenti vedi sezione rails_references/data_types/select-collection_select


Mostriamo i ruoli anche nell'elenco iniziale degli utenti. Li mettiamo al posto della colonna "Remember created at"

***codice n/a - .../app/views/users/index.html.erb - line: 11***

```html+erb
      <th>Role</th>
```

***codice n/a - ...continua - line: 22***

```html+erb
        <td><%= user.role %></td>
```



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

- https://mycloud9path.amazonaws.com/users

Andiamo in edit sui vari utenti e ne vediamo i vari ruoli. Volendo possiamo anche cambiarli.
(se proviamo a cambiarli dobbiamo reinserire anche password e password_confirmation altrimenti abbiamo un errore di validazione. Più avanti risolveremo anche questo)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Add role:enum to table users"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku re:master
$ heroku run rails db:migrate
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge re
$ git branch -d re
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
