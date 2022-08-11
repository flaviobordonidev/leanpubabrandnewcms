# Models validations

Validations for data consistency.
Il Model permette di evitare di salvare i dati nel database se ci sono dati incorretti.

> è importante tener presente che **più sono consistenti** i tuoi dati, **meno codice** dobbiamo scrivere. 



## Risorse interne:

- 01-base/09-manage_users/02-users_validations



## Risorse esterne

- [mixandgo: Models - Validations: Presence](https://school.mixandgo.com/targets/214)
- [mixandgo: Models - Validations: Confirmation](https://school.mixandgo.com/targets/215)
- [mixandgo: Models - Validations: Format and length](https://school.mixandgo.com/targets/216)
- [activerecord-validations](https://guides.rubyonrails.org/active_record_validations.html)
- [activerecord-validations](https://web-crunch.com/understanding-ruby-on-rails-activerecord-validations/)
- [Form validations with HTML5 and modern Rails](https://www.jorgemanrubia.com/2019/02/16/form-validations-with-html5-and-modern-rails/)
- [Stackoverflow - How to do email validation in Ruby on Rails?](https://stackoverflow.com/questions/38611405/how-to-do-email-validation-in-ruby-on-rails)
- [email validation with gem](https://stormconsultancy.co.uk/blog/techtips/validating-email-addresses-in-rails/)
- [Ruby Email validation with regex](http://www.syntaxbook.com/post/122134-ruby-email-validation-with-regex)
- [a Ruby regex (regular expression) editor](https://rubular.com/)
- [get-information-about-types-of-failed-validations](https://blog.bigbinary.com/2016/05/03/rails-5-adds-a-way-to-get-information-about-types-of-failed-validations.html)




## Presenza (Presence)


***code n/a - .../app/models/user.rb - line:2***

```ruby
  validates :email, presence: true
```


Verifichiamo
 
```ruby
$ rails c
> u = User.new
> u.valid?
=> false
> u.errors
> u.errors.messages
=> {:email=>["can't be blank"]}
```


***code n/a - .../app/models/person.rb - line:1***

```ruby
class Person < ApplicationRecord
  validates :first_name, presence: true,
  validates :last_name, presence: true,
end
```

Verifichiamo
 
```ruby
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



## Campo di conferma (es: password confirmation)

Per validare la conferma basta inserire `confirmation: true`

In questo caso aggiungiamo la verifica della conferma per l'email.

***code n/a - .../app/models/user.rb - line:2***

```ruby
  validates :email, presence: true, confirmation: true
```


Verifichiamo come funziona nella rails console.
 
```ruby
$ rails c
> u = User.new
> u.email = "foo"
> u.email_confirmation = "bar"
> u.valid?
=> false
> u.errors.messages
=> {:email_confirmation=>["doesn't match Email"]}
```

Però questo non verifica la presenza del campo `email_confirmation`.

```ruby
> u.email_confirmation = nil
> u.valid?
=> true
```

Aggiungiamo anche questa verifica.

***code n/a - .../app/models/user.rb - line:2***

```ruby
  validates :email, presence: true, confirmation: true
  validates :email_confirmation, presence: true
```

Verifichiamo come funziona nella rails console.
 
```ruby
$ rails c
> u = User.new
> u.email = "foo"
> u.valid?
=> false
> u.errors.messages
=> {:email_confirmation=>["can't be blank"]}
```



## Lunghezza e formato (Format and Lenght)

Assicuriamoci che:

- ci siano **solo lettere** (no spaces or any other characters). [Format validation]
- che il nome sia più lungo di 3 caratteri e più corto di 50. [Lenght validation]

***code n/a - .../app/models/user.rb - line:4***

```ruby
  validates :name, format: { with: /\A[a-zA-Z]+\z/ },
    lenght: { minimum: 3, maximum: 50 }
```


Verifichiamo come funziona nella rails console.
 
```ruby
$ rails c
> u = User.new
> u.name = "aa"
> u.valid?
=> false
> u.errors.messages
=> {:name=>["is invalid", "is too short (minimum is 3 characters)"]}
> u.name = "a" * 51
> u.valid?
=> false
> u.errors.messages
=> {:name=>["is invalid", "is too long (maximum is 50 characters)"]}
```


Altro esempio.

```ruby
class Person < ApplicationRecord
  validates :bio, length: { maximum: 1000,
                            too_long: "%{count} characters is the maximum allowed" }
  validates :bio, length: { maximum: 500 }
end
```



## Email

Per le email ci sono molte regex che cercano di coprire tutte le possibili emails; questo non copre tutte le possibili emails false e rischia di bloccare alcune strane emails valide.


Se proviamo a testare la validità di un indirizzo email ... questo primo tentativo non verifica tutte le emails invalide ed esclude alcune emails valide 

```ruby
validates :email, format: { with:/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "only allows letters" }
```

Tanto vale aprire di più il controllo ed usare il seguente regex:

```ruby
validates :email, format: { with: /^.+@.+…+$/, message: "invalid email address" }
```

This checks that it’s of the form “removed_email_address@domain.invalid”, but performs no further validation.


Un programmatore Rails esperto potrebbe usare la costante built into URI in the standard ruby library

```ruby
validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
```

che corrisponde a 

```ruby
validates :email, format: { with: \A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z } 
```

come si evince da questo sito https://www.rubydoc.info/stdlib/uri/URI/MailTo


Oppure, Avendo installato Devise possiamo usare la loro stringa regex.

```ruby
  format: Devise.email_regexp
```

The Device regex is quite simple. This will not check if the email is valid, it will just check if your string contains just one "@" char and there is no whitespace. 





## Raggruppiamo il tutto


Possiamo unire su una stessa riga più colonne a cui applichiamo la stessa validazione.
Ad esempio se vogliamo che sia obbligatorio sia il "first_name" sia il "last_name" possiamo:

```ruby
class Person < ApplicationRecord
  validates :first_name, :last_name, presence: true,
end
```

avere un campo su una riga non vuol dire che non possa essere presente su un'altra riga.
In questo esempio la colonna email voglio che sia obbligatoria come il "name" ma anche che sia unica:

```ruby
class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
```


Nel MODEL inseriamo le varie validazioni possibili

```ruby
class User < ApplicationRecord

  validates :name, presence: true,
                   length: { maximum: 140 },
                   length: { minimum: 2 }

  validates :password, presence: true,
                       length: { in: 6..20 }

  validates :registration_number, length: { is: 6 }
end
```



```ruby
validates :terms, acceptance: true
validates :password, confirmation: true
validates :username, exclusion: { in: %w(admin superuser) }
validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
validates :age, inclusion: { in: 0..9 }
validates :first_name, length: { maximum: 30 }
validates :age, numericality: true
validates :username, presence: true

validates :gender, inclusion: %w(male female)
validates :password, length: 6..20

validate :username, :uniqueness => {:case_sensitive => false}
```
