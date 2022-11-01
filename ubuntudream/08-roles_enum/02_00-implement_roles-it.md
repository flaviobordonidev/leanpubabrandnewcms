# <a name="top"></a> Cap 8.2 - Implementiamo i ruoli sulla nostra applicazione

Adesso che abbiamo i ruoli nella nostra tabella *users* possiamo implementarli nelle views dellla nostra applicazione.



## Risorse interne

- [99-rails_references-models-04-public-protected-private]()
- [rails_references/data_types/select-collection_select]()



## Inseriamo il campo *role* nelle *views*

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

***codice n/a - .../app/views/users/_form.html.erb - line: 42***

```html+erb
  <div>
    <%= form.label :role %>
    <%= form.select(:role, User.roles.keys.map {|role| [role.titleize,role]}) %>
  </div>
```


***codice 02 - .../app/views/users/_form.html.erb - line: 42***

```html+erb
  <div>
    <%= form.label :role %>
      <%= form.select :role, User.roles.keys.map {|role| [role.titleize,role]}, {}, class: "form-control" %>
  </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/04_02-views-users-_form.html.erb)

> Per approfondimenti vedi sezione rails_references/data_types/select-collection_select

L'elenco a cascata è pronto e se diamo il *submit* del form ci dice che tutto è aggiornato correttamente, ma non è così.
Per far passare realmente il valore al database dobbiamo attivare la *whitelist* sul controller.



## Attiviamo la *whitelist* sul controller

Mettiamo il campo *:role* nella whitelist di *users_controller*.

***codice 03 - .../app/controllers/users_controller.rb - line: 75***

```ruby
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:avatar_image, :username, :first_name, :last_name, :location, :bio, :phone_number, :email, :password, :password_confirmation, :shown_fields, :role)
    end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/04_03-users_controller.rb)



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

- http://192.168.64.3:3000/users

Andiamo in edit sui vari utenti e ne vediamo i vari ruoli. Volendo possiamo anche cambiarli.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Add role:enum to table users"
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



## Pubblichiamo su render.com

Lo fa in automatico




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/13-roles/03_00-roles-enum-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/14-enum_i18n/01_00-enum-i18n-it.md)
