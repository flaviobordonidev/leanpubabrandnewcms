# Models validations

Risorse interne:

* 01-base/09-manage_users/02-users_validations

Risorse web:

* https://guides.rubyonrails.org/active_record_validations.html
* https://web-crunch.com/understanding-ruby-on-rails-activerecord-validations/
* [Form validations with HTML5 and modern Rails](https://www.jorgemanrubia.com/2019/02/16/form-validations-with-html5-and-modern-rails/)
* [Stackoverflow - How to do email validation in Ruby on Rails?](https://stackoverflow.com/questions/38611405/how-to-do-email-validation-in-ruby-on-rails)
* [email validation with gem](https://stormconsultancy.co.uk/blog/techtips/validating-email-addresses-in-rails/)
* [Ruby Email validation with regex](http://www.syntaxbook.com/post/122134-ruby-email-validation-with-regex)
* [a Ruby regex (regular expression) editor](https://rubular.com/)
* https://blog.bigbinary.com/2016/05/03/rails-5-adds-a-way-to-get-information-about-types-of-failed-validations.html




## Presenza

```
class Person < ApplicationRecord
  validates :first_name, presence: true,
  validates :last_name, presence: true,
end
```

Verifichiamo
 
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




## Lunghezza

```
class Person < ApplicationRecord
  validates :bio, length: { maximum: 1000,
                            too_long: "%{count} characters is the maximum allowed" }
  validates :bio, length: { maximum: 500 }
end
```




## Email

Per le email ci sono molte regex che cercano di coprire tutte le possibili emails; questo non copre tutte le possibili emails false e rischia di bloccare alcune strane emails valide.


Se proviamo a testare la validità di un indirizzo email ... questo primo tentativo non verifica tutte le emails invalide ed esclude alcune emails valide 

```
validates :email, format: { with:/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "only allows letters" }
```

Tanto vale aprire di più il controllo ed usare il seguente regex:

```
validates :email, format: { with: /^.+@.+…+$/, message: "invalid email address" }
```

This checks that it’s of the form “removed_email_address@domain.invalid”, but performs no further validation.


Un programmatore Rails esperto potrebbe usare la costante built into URI in the standard ruby library

```
validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
```

che corrisponde a 

```
validates :email, format: { with: \A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z } 
```

come si evince da questo sito https://www.rubydoc.info/stdlib/uri/URI/MailTo


Oppure, Avendo installato Devise preferisco usare la loro esperienza ed appoggiarmi alla loro stringa regex.

```
  format: Devise.email_regexp
```

The Device regex is quite simple. This will not check if the email is valid, it will just check if your string contains just one "@" char and there is no whitespace. 





## Raggruppiamo il tutto


Possiamo unire su una stessa riga più colonne a cui applichiamo la stessa validazione.
Ad esempio se vogliamo che sia obbligatorio sia il "first_name" sia il "last_name" possiamo:

```
class Person < ApplicationRecord
  validates :first_name, :last_name, presence: true,
end
```

avere un campo su una riga non vuol dire che non possa essere presente su un'altra riga.
In questo esempio la colonna email voglio che sia obbligatoria come il "name" ma anche che sia unica:

```
class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
```


Nel MODEL inseriamo le varie validazioni possibili

```
class User < ApplicationRecord

  validates :name, presence: true,
                   length: { maximum: 140 },
                   length: { minimum: 2 }

  validates :password, presence: true,
                       length: { in: 6..20 }

  validates :registration_number, length: { is: 6 }
end
```



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

