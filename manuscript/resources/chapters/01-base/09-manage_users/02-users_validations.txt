{id: 01-base-09-manage_users-02-users_validations}
# Cap 9.2 -- Validiamo i campi della tabella utenti

Implementiamo delle validazioni dei dati che saranno archiviati nel database.

Risorse interne:

* 99-rails_references/models/05-validations




## Le validazioni

* Il nome dell'utente deve essere presente (è obbligatorio)
* Il nome dell'utente non può essere più lungo di 50 caratteri
* la password è obbligatoria
* la password deve essere più lunga di 6 caratteri 
* la password non può essere più lunga di 25 caratteri

{id: "01-09-02_01", caption: ".../app/models/users.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
  validates :name, presence: true,
                   uniqueness: true,
                   length: { maximum: 50 }

  validates :email, presence: true,
                    uniqueness: true,
                    length: { maximum: 50 },
                    format: { with: URI::MailTo::EMAIL_REGEXP } 

  validates :password, presence: true,
                       length: { in: 6..25 }


  validates :email, presence: true,
                    uniqueness: true,
                    length: { maximum: 50 },
                    format: { with: URI::MailTo::EMAIL_REGEXP } 

  validates :password, presence: true,
                       length: { in: 6..25 }
```

[tutto il codice](#01-09-02_01all)




## Codice di generazione errore nel form

Il codice di visualizzazione dei messaggi d'errore è già creato in fase di scaffold. 
Verifichiamo il codice in cui è generato l'elenco di messaggi d'errore

{id: "01-09-02_02", caption: ".../views/users/_form.html.erb -- codice 02", format: HTML+Mako, line-numbers: true, number-from: 1}
```
  <% if user.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(user.errors.count, "error") %> prohibited this user from being saved:</h2>

      <ul>
        <% user.errors.full_messages.each do |message| %>
          <li><%= message %></li>
        <% end %>
      </ul>
    </div>
  <% end %>
```

[tutto il codice](#01-09-02_02all)


I messaggi sono in inglese ma nei prossimi capitoli li personalizzeremo ed internazionalizzeremo (i18n).




## verifichiamo online

blabla

eseguiamo il submit del form.




## Verifichiamo da console
 
```
$ rails console
> Person.create(name: "John Doe").valid? # => true
> Person.create(name: nil).valid? # => false

> p = Person.new(name: "John Doe")
=> #<Person id: nil, name: "John Doe", created_at: nil, updated_at: nil>
> p.new_record?
=> true
> p.save
=> true
> p.new_record?
=> false
```




## git




## heroku




## close branch