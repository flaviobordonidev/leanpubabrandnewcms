# <a name="top"></a> Cap 4.2 - Implementiamo la sicurezza e la protezione di Devise

Facciamo degli ultimi aggiustamenti. (sintonia fine)



## Risorse interne

- [code_references-authentication_devise-02-devise]
- [code_references-params]



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



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/01_00-manage_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_00-browser_tab_title_users-it.md)
