# <a name="top"></a> Cap 9.2 - Implementiamo la sicurezza e la protezione di Devise

Rendiamo non accessibili le pagine di gestione degli utenti a chi non è autenticato.
Questa è quasi una forma di autorizzazione ma l'autorizzazione vera è basata su ruoli differenti che hanno i vari utenti che fanno login / che si autenticano.
Quando implementeremo la parte di autorizzazione nei prossimi capitoli disattiveremo temporaneamente la non accessibilità creata con Devise alle pagine a cui possono accedere solo gli utenti loggati.



## Risorse interne

- [99-rails_references-authentication_devise-02-devise]



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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_01-controllers-users_controller.rb)

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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_02-controllers-application_controller.rb)

Però questo metodo ci permette di programmare degli instradare su qualsiasi pagina in funzione del ruolo dell'utente loggato.
Ad esempio: 
- Se è un amministratore lo potrei instradare su *users_path* così ha la lista di tutti gli utenti su cui può lavorare. 
- Se invece è un autore lo possiamo reinstradare sulla dashboard del blog. 
- Se è un lettore sulla pagina del blog. 
- ecc...



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

dalla root_path:

- https://mycloud9path.amazonaws.com/

facciamo login e vediamo che siamo reinstradati sulla pagina dell'utente loggato.



## Evitiamo di dover sempre dare una password su modifica user

Non stiamo parlando di una protezione ma di dover reimpostare la *password* anche per una semplice modifica del nome utente.
Questo perché una volta attivata la protezione `before_action :authenticate_user!` si attiva anche la **validazione** per la presenza della password che è implicida in devise.
Questo vuol dire che se si lascia vuoto il campo password si riceve un errore di validazione. 

Soluzione usata su Rails 6:
Per ovviare rimuoviamo nel controller la chiave "password" dall'hash "params" nel caso in cui il campo password del form è lasciato vuoto. 
Per farlo aggiungiamo `params[:user].delete(...)` all'azione *update*.

***codice n/a - .../app/controllers/users_controller.rb - line: 44***

```ruby
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
```

Soluzione usata su Rails 7:
Per ovviare agiamo a livello di metodo **user_params** non includendo *:password* e *:password_confirmation* nel *permit* se il campo *password* nel form è lasciato vuoto.

***codice 03 - .../app/controllers/users_controller.rb - line: 67***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      if params[:user][:password].blank?
        params.require(:user).permit(:name, :email)
      else
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_03-controllers-users_controller.rb)




### Working Around Rails 7’s Turbo

> Attenzione:
> C'è un bug tra Rails 7 e devise per cui una volta cambiata correttamente la password non siamo reinstradati sulla pagina di login
> a questo link c'è la soluzione: https://betterprogramming.pub/devise-auth-setup-in-rails-7-44240aaed4be
>
> Di seguito il contenuto del link:

Now, we need to do something a little special for Rails 7. Rails 7 includes Turbo as a cornerstone component. 
Turbo lets you run asynchronous page updates without writing any Javascript (which is nifty) but it does it by hijacking the normal flow of submitting forms and following links. 
Devise isn’t (yet) prepared for that and it won’t be able to display flash messages — which it relies heavily on — by default. 
We need to alter the code that Devise generates for us to deal with Turbo.
So, once you’ve run rails generate `devise:install` we need to alter the Devise initializer config in several places beyond what the Devise README instructs us to do and add a controller as Devise’s parent controller. 
Credit where it’s due: these changes are from [Go Rails video](https://gorails.com/episodes/devise-hotwire-turbo) on the topic which also explains why these changes are necessary.

***codice 04 - .../app/controllers/turbo_devise_controller.rb - line: 1***

```ruby
class TurboDeviseController < ApplicationController
  class Responder < ActionController::Responder
    def to_turbo_stream
      controller.render(options.merge(formats: :html))
    rescue ActionView::MissingTemplate => error
      if get?
        raise error
      elsif has_errors? && default_action
        render rendering_options.merge(formats: :html, status: :unprocessable_entity)
      else
        redirect_to navigation_location
      end
    end
  end

  self.responder = Responder
  respond_to :html, :turbo_stream
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_04-controllers-turbo_devise_controller.rb)

Inoltre dobbiamo aggiungere e attivare alcuni parametri sulla *configurazione di inizializzazione di devise*.
Vediamo come si presenta la configurazione iniziale:

***codice 05 - .../config/initializers/devise.rb - line: 1***

```ruby
# frozen_string_literal: true

# Assuming you have not yet modified this file, each configuration option below
# is set to its default value. Note that some are commented out while others
# are not: uncommented lines are intended to protect your configuration from
# breaking changes in upgrades (i.e., in the event that future versions of
# Devise change the default values for those options).
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_05-config-initializers-devise.rb)


Di seguito facciamo le modifiche:

***codice 06 - .../config/initializers/devise.rb - line:11***

```ruby
# Turbo doesn't work with devise by default.
# Keep tabs on https://github.com/heartcombo/devise/issues/5446 for a possible fix
# Fix from https://gorails.com/episodes/devise-hotwire-turbo
class TurboFailureApp < Devise::FailureApp
  def respond
    if request_format == :turbo_stream
      redirect
    else
      super
    end
  end

  def skip_format?
    %w(html turbo_stream */*).include? request_format.to_s
  end
end
```

***codice 06 - ...continua - line:37***

```ruby
  # ==> Controller configuration
  # Configure the parent class to the devise controllers.
  config.parent_controller = 'TurboDeviseController'
```

***codice 06 - ...continua - line:276***

```ruby
 # ==> Navigation configuration
  # Lists the formats that should be treated as navigational. Formats like
  # :html, should redirect to the sign in page when the user does not have
  # access, but formats like :xml or :json, should return 401.
  #
  # If you have any extra navigational formats, like :iphone or :mobile, you
  # should add them to the navigational formats lists.
  #
  # The "*/*" below is required to match Internet Explorer requests.
  # config.navigational_formats = ['*/*', :html]
  config.navigational_formats = ['*/*', :html, :turbo_stream]
```

***codice 06 - ...continua - line:296***

```ruby
  # ==> Warden configuration
  # If you want to use other strategies, that are not supported by Devise, or
  # change the failure app, you can configure them inside the config.warden block.
  #
  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  # end
  config.warden do |manager|
    manager.failure_app = TurboFailureApp
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_06-config-initializers-devise.rb)



## Evitiamo che l'amministratore loggato possa eliminare se stesso

Evitiamo di fare come nei film comici e di *tagliarci il ramo su cui stiamo seduti*: `@user.destroy unless @user == current_user` e diamo un messaggio differente se eliminato o non eliminato.

***codice 07 - .../app/controllers/users_controller.rb - line: 60***

```ruby
  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy unless @user == current_user

    respond_to do |format|
      format.html do 
        redirect_to users_url, notice: "User was successfully destroyed." unless @user == current_user
        redirect_to users_url, notice: "The logged in user cannot be destroyed." if @user == current_user
      end
      format.json { head :no_content }
    end
  end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_07-controllers-users_controller.rb)

Al momento tutti gli utenti hanno autorizzazione a fare tutto. 
Nei futuri capitoli implementeremo le autorizzazioni restringendo la possibilità di eliminazione degli utenti ai soli utenti con ruolo di amministratore.



## Verifichiamo preview

Partiamo col webserver

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

Andiamo sulla pagina degli utenti e proviamo ad eliminare l'utente loggato. 
Riceveremo il messaggio di mancata autorizzazione.

- https://mycloud9path.amazonaws.com/users

Possiamo creare un nuovo utente ed eliminarlo. 
L'utente verrà eliminato e riceveremo il messaggio di eliminazione avvenuta con successo.



## Nascondiamo il link di eliminazione per l'utente autenticato

Sulla view mostriamo il link di eliminazione solo se non è l'utente loggato `unless user == current_user`.

***codice 08 - .../app/views/users/show.html.erb - line:9***

```html+erb
  <%= button_to "Destroy this user", @user, method: :delete unless @user == current_user %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_08-views-users-show.html.erb)



## Verifichiamo preview

Partiamo col webserver

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

Andiamo sulla pagina degli utenti.

- https://mycloud9path.amazonaws.com/users

Vedremo visualizzando l'utente loggato (*Show this user*) non avrà il bottone *"destroy this user"*.



## Implementiamo un re-login automatico su cambio password


> DA RIVEDERE CON CALMA perché non mi funziona. LA SALTIAMO E LA RIVEDIAMO PIù AVANTI.


Al momento cambiando la password siamo automaticamente riportati al login, perché adesso è attiva la *protezione di devise* con *before_action :authenticate_user!*.
Questa protezione permette di entrare solo a chi è stato autenticato tramite login.
Facciamo in modo di essere **loggati di nuovo automaticamente** col *sign_in/login* di Devise **bypassando le validazioni**.

Nell'azione *update* del controller scriviamo la logica interrompendo il codice con `raise` che fa sorgere un errore (raise an error).

***codice 09 - .../app/controllers/users_controller.rb - line: 49***

```ruby
  def update
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

- se modifichiamo l'utente loggato, allora mettiamo del codice che rieffettua un login automatico.
- se modifichiamo un'altro utente, lasciamo il codice così com'è che già va bene.
- se non siamo loggati reinstradiamo sull'homepage (root_path).

***codice 10 - .../app/controllers/users_controller.rb - line: 15***

```ruby
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
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



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

- https://mycloud9path.amazonaws.com/users

Editiamo la password dell'utente attivo e vediamo che non ci "butta fuori".



## Salviamo su git

```bash
$ git add -A
$ git commit -m "Implement devise protection to users and more"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku pwl:main
$ heroku run rails db:migrate
```

> Possiamo anche non eseguire `$ heroku run rails db:migrate` perché non tocchiamo il database



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge pwl
$ git branch -d pwl
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/01_00-manage_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_00-browser_tab_title_users-it.md)
