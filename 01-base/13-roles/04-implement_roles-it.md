# <a name="top"></a> Cap 13.4 - Implementiamo i ruoli sulla nostra applicazione

Adesso che abbiamo i ruoli nella nostra tabella *users* possiamo implementarli nelle views dellla nostra applicazione.



## Risorse interne

- [99-rails_references-models-04-public-protected-private]()



## Apriamo branch

continuiamo con lo stesso branch del capitolo precedente



## Inseriamo il campo *language* nelle *views*

Aggiungiamo il campo nel partial *_user* usato dalle views *show* ed *index*.

***codice 01 - .../app/views/users/_user.html.erb - line: 17***

```html+erb
  <p>
    <strong>Role:</strong>
    <%= user.role %>
  </p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/04_01-views-users-_user.html.erb)


Nel partial *_form* usato dalle views *edit* e *new*, aggiungiamo un selettore (menu a cascata) per permettere di cambiare ruolo.

***codice 02 - .../app/views/users/_form.html.erb - line: 42***

```html+erb
  <div>    
    <%= form.label :role %>
    <%= form.select(:role, User.roles.keys.map {|role| [role.titleize,role]}) %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/04_02-views-users-_form.html.erb)

> Per approfondimenti vedi sezione rails_references/data_types/select-collection_select

L'elenco a cascata è pronto e se diamo il *submit* del form ci dice che tutto è aggiornato correttamente, ma non è così.
Per far passare realmente il valore al database dobbiamo attivare la *whitelist* sul controller.



## Attiviamo la *whitelist* sul controller

Mettiamo il campo *:role* nella whitelist di *users_controller*.

***codice 03 - .../app/controllers/users_controller.rb - line: 70***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      if params[:user][:password].blank?
        params.require(:user).permit(:name, :email, :language, :role)
      else
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :language, :role)
      end
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/04_03-users_controller.rb)

Questo ancora **non** ci permette di aggiornare il campo *language* nella tabella *users* perché è bloccato da *devise*.




## Attiviamo la *whitelist* su devise


> ATTENZIONE -- MI HA FUNZIONATO SENZA whitelist se devise!!!
>
> DA RIVEDERE!!!

Normalmente andremmo solo su *users_controller* ma siccome *User* e legato a *devise* dobbiamo usare anche *application_controller*.

> **NON** E' VERO!!!
> MI SONO SBAGLIATO!
> FUNZIONA ANCHE SENZA!!!
> LO MANTENGO PERCHE' E' utile sapere questa parte di passare per devise ma NON è il caso di *language*
> Forse serve se vogliamo passare qualche parametro in fase di login o di qualche views che parla direttamente con *devise_controller*.

> POSSIAMO SALTARE QUESTO PARAGRAFO


> Devise non è come lo scaffold. Non ci crea già le azioni sul controller e le views.
> Per poter passare i parametri attraverso le views, o meglio il sumbit del form, dobbiamo inserirli nella white list del controller.
> Una procedura detta *Strong_params* o *mass-assignment*. Ma questo non è così facile su Devise perché di default ci nasconde tutto.

Abbiamo già visualizzato i controllers e le views di devise-users nei capitoli precedenti.
Possiamo passare i parametri in due modi:

1. Usando il controller *application* (metodo raccomandato dalla Plataformatec creatrice di Devise)
2. Usando i controllers dentro "controllers/users/" ma in questo caso dobbiamo dichiarare ogni controller usato nella routes.



### 1. Il metodo raccomandato da plataformatec. Il metodo Lazy way.

Permettiamo il passaggio del parametro "language" che con devise è fatto tramite "devise_parameter_sanitizer".
Questa è la sicurezza per il mass-assignment che nei controllers è fatto normalmente con "params.require(:my_model_name).permit(:column1_name, :column2_name)"

***codice 05 - .../app/controllers/application_controller.rb - line: 3***

```ruby
  before_action :configure_permitted_parameters, if: :devise_controller?
```

***codice 05 - ...continua - line: 10***

```
  #-----------------------------------------------------------------------------
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in)
    devise_parameter_sanitizer.permit(:sign_up)
    devise_parameter_sanitizer.permit(:account_update)

    #devise_parameter_sanitizer.permit(:sign_in, keys: [:language])
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:language])
    #devise_parameter_sanitizer.permit(:account_update, keys: [:language])

    #devise_parameter_sanitizer.permit(:sign_in, keys: [:role, :name, :language])
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name, :language])
    #devise_parameter_sanitizer.permit(:account_update, keys: [:role, :name, :language])
  end
```

[tutto il codice](#01-13-03_01all)

> il codice "protected" è prima del codice "private" perché è meno restrittivo.
>
> Dal più accessibile al più restrittivo abbiamo: "public" -> "protected" -> "private"

I loro nomi e parametri di default permessi sono:

- *sign_in* (Devise::SessionsController#create) - Permette solo le chiavi di autenticazione come il campo :email
- *sign_up* (Devise::RegistrationsController#create) - Permette le chiavi di autenticazione più i campi :password e :password_confirmation
- *account_update* (Devise::RegistrationsController#update) - Permette le chiavi di autenticazione più i campi :password, :password_confirmation e :current_password


Adesso finalmente riusciamo ad aggiornare il campo *language* nella tabella *users* perché è bloccato da *devise*.

> Una CURIOSITA': questa parte che abbiamo dovuto dare a causa di devise su *language* non è servita per il campo *name* !
> Da APPROFONDIRE! Cos'ha di differente *language* da *name*?



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
$ git push heroku re:main
$ heroku run rails db:migrate
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge re
$ git branch -d re
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03-roles-enum-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/14-enum_i18n/01-enum-i18n-it.md)
