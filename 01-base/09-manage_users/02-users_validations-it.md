# <a name="top"></a> Cap 9.2 - Validiamo i campi della tabella utenti

Implementiamo delle validazioni dei dati che saranno archiviati nel database.



## Risorse interne

- 99-rails_references/models/05-validations



## Le validazioni

- Il nome dell'utente deve essere presente (è obbligatorio)
- Il nome dell'utente non può essere più lungo di 50 caratteri
- la password è obbligatoria
- la password deve essere più lunga di 6 caratteri 
- la password non può essere più lunga di 25 caratteri

***codice 01 - .../app/models/users.rb - line: 1***

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

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/02_02-views-users-_form.html.erb)

I messaggi sono in inglese ma nei prossimi capitoli li personalizzeremo ed internazionalizzeremo (i18n).



## verifichiamo online

blabla

eseguiamo il submit del form.



## Verifichiamo da console
 
```bash
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