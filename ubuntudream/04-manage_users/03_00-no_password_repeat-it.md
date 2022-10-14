# <a name="top"></a> Cap 4.2 - Implementiamo la sicurezza e la protezione di Devise

Evitiamo di dover ripetere la password per ogni modifica ad altre parti dell'account utente.
Se cambio il nome o il cognome o altro non mi chiede di reinserire la password.


## Risorse interne

- [code_references-authentication_devise-02-devise]
- [code_references-params]


## Apriamo il branch "Protect With Login"

```bash
$ git checkout -b pwl
```


## Evitiamo di dover sempre dare una password su modifica user

Avendo attivato la protezione `before_action :authenticate_user!` si attiva anche la **validazione** per la presenza della password che è implicida in devise.

Questo vuol dire che se si lascia vuoto il campo password si riceve un errore di validazione.
Questo vuol dire che si è costretti a reinserire sempre password e password_confirmation ogni modifica che facciamo.

> Vuol dire dover reimpostare la *password* anche per una semplice modifica del nome utente.

Per evitare questo ci sono diverse soluzioni:

- Creare due views: Una senza password ed una dedicata solo alla modifica della password. <br/> Questo da il vantaggio di non dover intervenire sul controller. (è quella che preferisco ^_^)
- Intervenire dirttemente sui `params` togliendo le variabili *password* e *password_confirmation*. <br/> Questo mi funzionava su Rails 6, ma non mi sta funzionando su Rails 7.
- Intervenire sui `params` a livello di *white-list*, sempre togliendo le variabili *password* e *password_confirmation*. <br/> Funziona anche su Rails 7.



## Creare due views

- [How To: Allow users to edit their password](https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-edit-their-password)

Questo approccio mi piace molto perché trovo che crei anche una User Interface migliore, perché la modifica della password, che è più delicata, ha una sua pagina separata.

L'esigenza è quella di visualizzare una view con i campi di modifica dell'utente (edit account) senza i campi della password.
Per la modifica della password c'è un'altra view dedicata.

Invece di creare due views differenti facciamo tutto nella stessa view e mettiamo un "if...else...end" passando tramite il link un params che ci dice quali campi visualizzare.

Nel nostro progetto chiamiamo questo parametro `:shown_fields`.
Lo usiamo nei links della view `users/show` nel chiamare la view `users/edit`.

***Codice 01 - .../app/views/users/show.html.erb - line:06***

```html+erb
  <%= link_to "Edit this user", edit_user_path(@user, shown_fields: 'account') %> |
  <%= link_to "Edit this user password", edit_user_path(@user, shown_fields: 'password') %> |
  <%= link_to "Edit this user all", edit_user_path(@user, shown_fields: 'all') %> |
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/04-manage_users/03_01-views-users-show.html.erb)


Quindi nella view `users/edit` usiamo il parametro con un *if...end*: <br/>
`<% if params[:shown_fields] == 'account' or params[:shown_fields] == 'all' %>`

***Codice n/a - .../app/views/users/_form.html.erb - line:06***

```html+erb
  <% if params[:shown_fields] == 'account' or params[:shown_fields] == 'all' %>
    <!-- i vari campi users (senza quelli della password) -->
  <% end %>

  <% if params[:shown_fields] == 'password' or params[:shown_fields] == 'all' %>
    <!-- i soli campi password e password_confirmation -->
  <% end %>
```

Questo funziona ma se ho un errore perdo il parametro `:shown_fields` perché l'azione `update` di `users_controller` in caso di errore fa un render della stessa view: <br/>
`format.html { render :edit, status: :unprocessable_entity }` </br>
...ed il render non riprende i parametri dall'url ma prende quelli passati dal submit del form con *POSTT*.

***Codice n/a - .../app/controllers/users_controller.rb - line:06***

```ruby
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

Per risolverlo è sufficiente mettere un campo nascosto che mi ripassa il parametro.

***Codice 02 - .../app/views/users/_form.html.erb - line:14***

```html+erb
  <!-- Manteniamo sull'url alcuni params - start --> 
  <%= hidden_field_tag(:shown_fields, params[:shown_fields]) %>
  <!-- Manteniamo sull'url alcuni params - end --> 
```

Per farci passare il parametro dobbiamo aggiornare anche la *white-list* del controller.

***Codice 03 - .../app/controllers/users_controller.rb - line:69***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :location, :bio, :phone_number, :email, :password, :password_confirmation, :shown_fields)
    end
```

E questo è tutto per quanto riguarda *edit*. Adesso è come se avessimo due views di edit differenti. 
Non ci resta che aggiornare sulla view *index* il link che chiama la pagina *new*.

***Codice 04 - .../app/views/users/index.html.erb - line:14***

```html+erb
<%= link_to "New user", new_user_path(@user, shown_fields: 'all') %>
```

Finito. 



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

- http://192.168.64.3:3000/users

Andiamo su show dell'utente e proviamo i vari links di *edit*.




## Interveniamo direttamente sui `params`

Il secondo approccio è quello di mantenere tutti i campi e di evitare la validazione di non poter lasciare la password bianca.

Soluzione usata su Rails 6.
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



## Interveniamo sui `params` attraverso la *white-list*

Il terzo approccio è uguale al secondo, quello di mantenere tutti i campi e di evitare la validazione di non poter lasciare la password bianca.
Cambia solo dove interveniamo a nascondere i *params[:password]* e *confirmation*.

Soluzione usata su Rails 7
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




## Salviamo su git

```bash
$ git add -A
$ git commit -m "Implement no password repit"
```



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



## Pubblichiamo su render.com

premiamo il pulsante



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/01_00-manage_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_00-browser_tab_title_users-it.md)
