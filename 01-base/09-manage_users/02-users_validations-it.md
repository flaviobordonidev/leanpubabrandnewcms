# <a name="top"></a> Cap 9.2 - Validiamo i campi della tabella utenti

Implementiamo delle validazioni dei dati che saranno archiviati nel database.



## Risorse interne

- 99-rails_references/models/05-validations



## Apriamo il branch "Validiamo Utenti"

```bash
$ git checkout -b vu
```


## Le validazioni

- Il nome dell'utente deve essere presente (è obbligatorio)
- Il nome dell'utente non può essere più lungo di 50 caratteri
- la password è obbligatoria
- la password deve essere più lunga di 6 caratteri 
- la password non può essere più lunga di 25 caratteri

***codice 01 - .../app/models/users.rb - line: 7***

```ruby
  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 50 }

  validates :email, presence: true,
                    uniqueness: true,
                    length: { maximum: 50 },
                    format: { with: URI::MailTo::EMAIL_REGEXP } 

  validates :password, presence: true,
                       length: { in: 6..25 }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_01-models-users.rb)



## Codice di generazione errore nel form

Il codice di visualizzazione dei messaggi d'errore è già creato in fase di scaffold. 
Verifichiamo il codice in cui è generato l'elenco dei messaggi d'errore.

***codice 02 - .../views/users/_form.html.erb - line: 1***

```html+erb
  <% if user.errors.any? %>
    <div style="color: red">
      <h2><%= pluralize(user.errors.count, "error") %> prohibited this user from being saved:</h2>

      <ul>
        <% user.errors.each do |error| %>
          <li><%= error.full_message %></li>
        <% end %>
      </ul>
    </div>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_02-views-users-_form.html.erb)

I messaggi sono in inglese ma nei prossimi capitoli li personalizzeremo ed internazionalizzeremo (i18n).

Su Rails 6 la parte dei messaggi d'errore era fatta così:

***codice n/a - .../views/users/_form.html.erb - line: 1***

```html+erb
      <ul>
        <% user.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
```


## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

- https://mycloud9path.amazonaws.com/users

Proviamo a creare un nuovo utente violando le validazioni (ad esempio non mettiamo il nome) e verifichiamo i messaggi d'errore sul *submit* del form.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_fig01-new_user_validation_errors.png)



## Verifichiamo da console

Di seguito una validazione che è pensata per le persone che hanno solo la validazione della presenza del nome.

```bash
$ rails console
-> Person.create(name: "John Doe").valid? # => true
-> Person.create(name: nil).valid? # => false

-> p = Person.new(name: "John Doe")
   # => <Person id: nil, name: "John Doe", created_at: nil, updated_at: nil>
-> p.new_record?
   # => true
-> p.save
   # => true
-> p.new_record?
   #=> false
```

Esempio:

```bash
3.1.0 :002 > User.create(name: "John Doe").valid?
  TRANSACTION (0.1ms)  BEGIN
  User Exists? (0.8ms)  SELECT 1 AS one FROM "users" WHERE "users"."name" = $1 LIMIT $2  [["name", "John Doe"], ["LIMIT", 1]]
  User Exists? (0.2ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", ""], ["LIMIT", 1]]
  TRANSACTION (0.2ms)  ROLLBACKg for requests to finish
  User Exists? (0.9ms)  SELECT 1 AS one FROM "users" WHERE "users"."name" = $1 LIMIT $2  [["name", "John Doe"], ["LIMIT", 1]]
  User Exists? (1.1ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", ""], ["LIMIT", 1]]
 => false                      
3.1.0 :003 > 




## Salviamo su git

```bash
$ git add -A
$ git commit -m "Implement validation users"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku vu:main
$ heroku run rails db:migrate
```

- https://bl7-0.herokuapp.com/users



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge vu
$ git branch -d vu
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/01-manage_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-users_protected-it.md)
