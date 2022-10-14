# <a name="top"></a> Cap 4.2 - Implementiamo la sicurezza e la protezione di Devise

Facciamo degli ultimi aggiustamenti. (sintonia fine)



## Risorse interne

- [code_references-authentication_devise-02-devise]
- [code_references-params]



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

***Codice 08 - .../app/controllers/users_controller.rb - linea:15***

```ruby
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



## Pubblichiamo su Heroku

```bash
$ git push heroku pwl:main
$ heroku run rails db:migrate
```

> Possiamo anche non eseguire `$ heroku run rails db:migrate` perché non tocchiamo il database



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/01_00-manage_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_00-browser_tab_title_users-it.md)
