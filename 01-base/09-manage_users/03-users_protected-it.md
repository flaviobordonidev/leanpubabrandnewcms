# <a name="top"></a> Cap 9.3 - Implementiamo la sicurezza e la protezione di Devise

Rendiamo non accessibili le pagine di gestione degli utenti a chi non è autenticato.
Questa è quasi una forma di autorizzazione ma l'autorizzazione vera è basata su ruoli differenti che hanno i vari utenti che fanno login / che si autenticano.
Quando implementeremo la parte di autorizzazione nei prossimi capitoli disattiveremo temporaneamente la non accessibilità creata con Devise alle pagine a cui possono accedere solo gli utenti loggati.



## Risorse interne

- 99-rails_references-authentication_devise-02-devise



## Apriamo il branch "Protect With Login"

```bash
$ git checkout -b pwl
```


## Proteggiamo le views users

Permettiamo l'accesso alle views users solo a chi ha fatto login, ossia a chi si è autenticato.

***codice 01 - .../app/controllers/users_controller.rb - line: 2***

```
  before_action :authenticate_user!
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_01-controllers-users_controller.rb)

> *before_action* ha sostituito il deprecato *before_filter*



## Reinstradiamo sull'utente dopo il login

Fino a Rails 6 una volta effettuato il login venivamo instradati sulla pagina principale (*root_path*).
Da Rails 7 una volta effettuato il login siamo instradati correttamente nella pagina che avevamo chiesto.

> Quindi da Rails 7 questo paragrafo è meno utile.

Inseriamo un metodo per tutti i controllers che reinstradi su *users/show* dell'utente che ha fatto login.

***codice 02 - .../app/controllers/application_controller.rb - line: 1***

```ruby
  def after_sign_in_path_for(resource_or_scope)
    current_user # goes to users/1 (if current_user = 1)
    #users_path #goes to users/index
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_02-controllers-application_controller.rb)

Però questo metodo ci permette di programmare degli instradare su qualsiasi pagina in funzione del ruolo dell'utente loggato.
Ad esempio: 
- Se è un amministratore lo potrei instradare su *users_path* così ha la lista di tutti gli utenti su cui può lavorare. 
- Se invece è un autore lo possiamo reinstradare sulla dashboard del blog. 
- Se è un lettore sulla pagina del blog. 
- ecc...



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

dalla root_path:

- https://mycloud9path.amazonaws.com/

facciamo login e vediamo che siamo reinstradati sulla pagina dell'utente loggato.



## Evitiamo di dover sempre dare una password

Una volta attivata la protezione `before_action :authenticate_user!` si attiva anche la validazione per la presenza della password. 
Questo vuol dire che se si lascia vuoto il campo password si riceve un errore di validazione. 
In questo caso è utile rimuovere nel controller la chiave "password" dall'hash "params" nel caso in cui il campo password del form è lasciato vuoto. 
Per farlo aggiungiamo il seguente codice nell'azione di *update*.

***codice 03 - .../app/controllers/users_controller.rb - line: 44***

```ruby
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_01-models-users.rb)



## Evitiamo che l'amministratore loggato possa eliminare se stesso

Evitiamo di fare come nei film comici e di *tagliarci il ramo su cui stiamo seduti*: `@user.destroy unless @user == current_user` e diamo un messaggio differente se eliminato o non eliminato.

***codice 04 - .../app/controllers/users_controller.rb - line: 60***

```ruby
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
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_01-models-users.rb)

Al momento tutti gli utenti hanno autorizzazione a fare tutto. 
Nei futuri capitoli implementeremo le autorizzazioni restringendo la possibilità di eliminazione degli utenti ai soli utenti con ruolo di amministratore.



## Verifichiamo preview

Partiamo col webserver

```bash
$ sudo service postgresql start
$ rails s
```

Andiamo sulla pagina degli utenti e proviamo ad eliminare l'utente loggato. 
Riceveremo il messaggio di mancata autorizzazione.

- https://mycloud9path.amazonaws.com/users

Possiamo creare un nuovo utente ed eliminarlo. 
L'utente verrà eliminato e riceveremo il messaggio di eliminazione avvenuta con successo.



## Nascondiamo il link di eliminazione per l'utente autenticato

Sulla view mostriamo il link di eliminazione solo se non è l'utente loggato `unless user == current_user`.

***codice 05 - .../app/views/users/index.html.erb - line: 23***

```
        <td><%= link_to 'Destroy', user,  method: :delete, data: { confirm: 'Are you sure?' } unless user == current_user %></td>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_01-models-users.rb)



## Verifichiamo preview

Partiamo col webserver

```bash
$ sudo service postgresql start
$ rails s
```

Andiamo sulla pagina degli utenti.

- https://mycloud9path.amazonaws.com/users

Vedremo che nell'elenco degli utenti l'utente loggato non ha il link di "destroy".



## Implementiamo un re-login automatico su cambio password

Al momento cambiando la password siamo automaticamente riportati al login, perché adesso è attiva la *protezione di devise* con *before_action :authenticate_user!*.
Questa protezione permette di entrare solo a chi è stato autenticato tramite login.
Facciamo in modo di essere **loggati di nuovo automaticamente** col *sign_in/login* di Devise **bypassando le validazioni**.

Nell'azione *update* del controller scriviamo la logica interrompendo il codice con `raise` che fa sorgere un errore (raise an error).

***codice 06 - .../app/controllers/users_controller.rb - line: 49***

```ruby
    respond_to do |format|
      if current_user.present? and current_user == @user
        raise "Current_user #{current_user.email} vuole modificare se stesso! (utente #{@user.email})"
        #qui mettiamo il codice con la modifica di saltare la validazione
      elsif current_user.present? and current_user != @user
        raise "Current_user #{current_user.email} vuole modificare utente #{@user.email}"
        #qui lasciamo il codice così com'era
      else
       raise "NON SEI LOGGATO"
       #qui non dovremmo poter arrivare perché la protezione di devise è attiva
       #comunque reinstradiamo su homepage perché è bene non lasciare "raise" in produzione
      end
```

Adesso che abbiamo la logica impostata possiamo associarci il codice:

- se modifichiamo un'altro utente, lasciamo il codice così com'è che già va bene.
- se modifichiamo l'utente loggato, allora mettiamo del codice che rieffettua un login automatico.

***codice 07 - .../app/controllers/users_controller.rb - line: 15***

```ruby
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    respond_to do |format|
      if current_user.present? and current_user == @user
        #raise "Current_user #{current_user.email} vuole modificare se stesso! (utente #{@user.email})"
        if @user.update(user_params)
          format.html do
            # Logghiamoci di nuovo automaticamente bypassando le validazioni
            sign_in(@user, bypass: true)
            redirect_to @user, notice: 'User was successfully updated.'
          end
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      elsif current_user.present? and current_user != @user
        #raise "Current_user #{current_user.email} vuole modificare utente #{@user.email}"
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        redirect_to root_path, notice: 'Effettua prima il login.'
      end
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_01-models-users.rb)

Questo codice funziona ma è veramente brutto perché duplichiamo due grandi pezzi di codice.



## Facciamo un refactoring

Il problema è sulla riga `if @user.update(user_params)` che fa sia l'azione di update che il controllo se è andata a buon fine.
Quando l'update è fatto sull'utente loggato (ossia il *current_user*) questo è immediatamente buttato fuori (logged out) ed il *current_user* è svuotato (=nil).
Questo mi impedisce di fare un più elegante `sign_in(@user, bypass: true) if @user == current_user`.
Possiamo farlo usando una variabile di appoggio che chiamiamo " current_user_temp " e che ci manterrà attivo l'utente che era loggato giusto il tempo di loggarlo di nuovo in automatico.

{id: "01-07-07_08", caption: ".../app/controllers/users_controller.rb -- codice 08", format: ruby, line-numbers: true, number-from: 15}
```
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
          # Logghiamoci di nuovo automaticamente bypassando le validazioni se ci siamo cambiati i nostri dati
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
```

[tutto il codice](#01-07-07_08all)

Adesso è molto meglio ^_^




## Salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "Implement devise protection to users and more"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku pwl:master
$ heroku run rails db:migrate
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge pwl
$ git branch -d pwl
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Permettiamo agli utenti di editare la loro password

QUESTO PARAGRAFO NON L'HO IMPLEMENTATO

Questo non so se mi serve... Mi sa che lo posso eliminare....

ApplicationController.rb:
```
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end
end
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/08-authentication_i18n/01-devise_i18n-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02-users_validations-it.md)
