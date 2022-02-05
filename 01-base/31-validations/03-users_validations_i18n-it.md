{id: 01-base-10-users_i18n-02-users_validations_i18n}
# Cap 10.2 -- Internazionalizzazione dei messaggi di validazione (Validation messagges i18n)




## Apriamo il branch 

continuiamo con lo stesso branch del capitolo precedente




## verifichiamo da console

Per capire i nomi degli attributi possiamo mandare delle validazioni da console ed usare "user.errors.details"
Quello che ci serve è "user.errors.details" ci dice quale campo ha l'errore di validazione e tutti i nomi degli attributi di quel campo che stanno sbagliando.


Creiamo un nuovo utente con tutti i campi vuoti e testiamo la validazione:

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c
> user = User.new
> user.valid?
> user.errors.details
> user.errors.messages

2.6.3 :004 > user = User.new
 => #<User id: nil, name: "", email: "", created_at: nil, updated_at: nil> 
2.6.3 :005 > user.errors.messages
 => {} 
2.6.3 :006 > user.valid?
  User Exists? (0.7ms)  SELECT 1 AS one FROM "users" WHERE "users"."name" = $1 LIMIT $2  [["name", ""], ["LIMIT", 1]]
  User Exists? (0.2ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", ""], ["LIMIT", 1]]
 => false 
2.6.3 :007 > user.errors.messages
 => {:email=>["il campo email non può essere vuoto", "translation missing: it.activerecord.errors.models.user.attributes.email.invalid"], :password=>["translation missing: it.activerecord.errors.models.user.attributes.password.blank", "translation missing: it.activerecord.errors.models.user.attributes.password.too_short"], :name=>["translation missing: it.activerecord.errors.models.user.attributes.name.blank"]} 
2.6.3 :008 > 
```

Avendo in piedi l'internazionalizzazione possiamo anche usare il messaggio di "translation missing:" per capire il nome degli attributi, perché saranno quelli non ancora tradotti :).


Adesso creiamo un nuovo utente riempiendo il campo email con un valore errato ed il campo password con una password troppo corta e lasciando vuoto il confirmation:

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c
> user = User.new({name: "", email: 'mia.email@ errata.it', password: 'no', password_confirmation: ''})
> user.valid?
> user.errors.messages
> user.errors.details

2.6.3 :001 > user = User.new({name: "", email: 'mia.email@ errata.it', password: 'no', password_confirmation: ''})
 => #<User id: nil, name: "", email: "mia.email@ errata.it", created_at: nil, updated_at: nil> 
2.6.3 :002 > user.valid?
  User Exists? (1.0ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", "mia.email@ errata.it"], ["LIMIT", 1]]
  User Exists? (0.3ms)  SELECT 1 AS one FROM "users" WHERE "users"."name" = $1 LIMIT $2  [["name", ""], ["LIMIT", 1]]
  User Exists? (0.3ms)  SELECT 1 AS one FROM "users" WHERE "users"."email" = $1 LIMIT $2  [["email", "mia.email@ errata.it"], ["LIMIT", 1]]
 => false 
2.6.3 :003 > user.errors.messages
 => {:email=>[": non valida"], :password_confirmation=>["translation missing: it.activerecord.errors.models.user.attributes.password_confirmation.confirmation"], :password=>[": troppo corta"], :name=>["translation missing: it.activerecord.errors.models.user.attributes.name.blank"]} 
2.6.3 :004 > 
```




## Implementiamo le internazionalizzazioni

Avendo visto il nome degli attributi adesso possiamo implementare le traduzioni sui locales.

{id: "01-10-02_01", caption: ".../config/locales/it.yml -- codice 01", format: yaml, line-numbers: true, number-from: 1}
```
it:
[...]
  users:
  [...]
    errors:
      models:
        user:
          attributes:
            name:
              blank: ": campo obbligatorio"
            email:
              blank: ": campo obbligatorio"
              invalid: ": non valida"
            password:
              blank: ": campo obbligatorio"
              too_short: ": troppo corta"
            password_confirmation:
              confirmation: ": non corrisponde con password"
```

{id: "01-10-02_02", caption: ".../config/locales/en.yml -- codice 02", format: yaml, line-numbers: true, number-from: 1}
```
en:
[...]
  users:
  [...]
    errors:
      models:
        user:
          attributes:
            name:
              blank: ": cannot be blank"
            email:
              blank: ": cannot be blank"
              invalid: ": invalid"
            password:
              blank: ": cannot be blank"
              too_short: ": too short"
            password_confirmation:
              confirmation: ": doesn't match with password"
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente con dei valori che non rispettano le validazioni, vediamo i nuovi messaggi tradotti.




## salviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "users validation messages i18n"
```




## Pubblichiamo su Heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku ui:master
```




## Chiudiamo il branch

lo lasciamo aperto per il prossimo capitolo




## Il codice del capitolo




[Codice 01](#01-08b-01_01)

{id="01-08b-01_01all", title=".../app/views/layouts/application.html.erb", lang=HTML+Mako, line-numbers=on, starting-line-number=1}
```

```






---



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## salviamo su git

```bash
$ git add -A
$ git commit -m "users_controllers notice messages i18n"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ui:master
```



## Chiudiamo il branch

Lo lasciamo aperto per il prossimo capitolo



## Facciamo un backup su Github

Lo facciamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
