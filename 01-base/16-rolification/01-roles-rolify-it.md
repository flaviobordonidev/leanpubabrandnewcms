# <a name="top"></a> Cap 16.1 - Massima flessibilità nei ruoli

> Tutta questa sezione del libro, questa serie di capitoli è totalmente opzionale.

Questo è l'approccio più flessibile nella gestione dei ruoli.
Nella maggior parte delle applicazioni non è richiesto questo livello di flessibilità ma in alcuni casi specifici si possono assegnare dei ruoli ad un utente in maniera maniacalmente minuziosa.
Ad esempio si possono assegnare ruoli per specifici records di tabelle correlate.


## Risorse web

- [Rolify wiki - usage](https://github.com/RolifyCommunity/rolify/wiki/Usage)
- [Rolify wiki](https://github.com/EppO/rolify/wiki)
- [Rolify community](https://github.com/RolifyCommunity/rolify)
- [Sito brasileiro](http://groselhas.maurogeorge.com.br/rolify-com-pundit-para-uma-autorizacao-com-multiplos-papeis.html)
  http://groselhas.maurogeorge.com.br/rolify-com-pundit-para-uma-autorizacao-com-multiplos-papeis.html#sthash.qfwFjKhJ.dpbs

- https://github.com/elabs/pundit
- https://github.com/RolifyCommunity/rolify
- http://eng.joingrouper.com/blog/2014/03/20/rails-the-missing-parts-policies/
- http://railsapps.github.io/rails-authorization.html
- https://github.com/RolifyCommunity/rolify/wiki


- [sitepoint - Straightforward Rails Authorization with Pundit](https://www.sitepoint.com/straightforward-rails-authorization-with-pundit/)
- [Pundit](https://github.com/elabs/pundit)
- [Rails Authorization With Pundit](https://www.youtube.com/watch?v=qruGD_8ry7k)



## Apriamo il branch *Roles Rolify*

```bash
$ git checkout -b rr
```



## Installiamo la gemma rolify

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/rolify)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/RolifyCommunity/rolify)

***codice n/a - .../Gemfile - line 43***

```ruby
# Very simple Roles library
gem 'rolify', '~> 5.2'
```

[tutto il codice: Gemfile](#beginning-authentication-authorization-rolification-02a-Gemfile)

Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Creiamo le classi per rolify

Creiamo le classi "Role" e "User" per definire i ruoli. Sono le classi di default e la classe "User" combina con la scelta "user" di default di devise.

```bash
$ rails g rolify Role User

# ===============================================================================
# 
# An initializer file has been created here: config/initializers/rolify.rb, you 
# can change rolify settings to match your needs. 
# Defaults values are commented out.
# 
# A Role class has been created in app/models (with the name you gave as 
# argument otherwise the default is role.rb), you can add your own business logic 
# inside.
# 
# Inside your User class (or the name you gave as argument otherwise the default 
# is user.rb), rolify method has been inserted to provide rolify methods.
```

lo script:
- crea il nuovo modello role.rb
- aggiunge del codice nel modello user.rb 
- crea config/initializers/rolify.rb
- crea il seguente migrate

***codice n/a - .../db/migrate/xxx_rolify_create_roles.rb - line: 1***

```ruby
class RolifyCreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end
    
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:users_roles, [ :user_id, :role_id ])
  end
end
```

eseguiamo il migrate

```bash
$ sudo service postgresql start
$ rails db:migrate
```

l'impostazione base è terminata possiamo già usare rolify.



## Aggiungiamo degli utenti da console 

```bash
$ rails c
> User.create(name: 'A', email: 'ann@test.abc', password: 'password', password_confirmation: 'password')
> User.create(name: 'B', email: 'bob@test.abc', password: 'password', password_confirmation: 'password')
> User.create(name: 'C', email: 'carl@test.abc', password: 'password', password_confirmation: 'password')
> exit
```



## Associamo e verifichiamo dei ruoli da console

Associamo e togliamo un ruolo al primo utente disponibile.

```bash
$ rails c
> User.first.add_role :admin
> User.first.remove_role :admin
```

vediamo adesso degli scenari di utilizzo



## Scenari di assegnazione ruolo (e di autorizzazione che implementeremo con pundit)

in questo capitolo e nei capitoli successivi faremo degli esempi per i seguenti scenari:

- Scenario con solo admin (come roles-admin)

- Scenario con silver, gold, platinum (come roles-enum)

- Scenario con silver, gold, platinum ed in aggiunta bonus
  - In questo caso oltre il ruolo tipo "enum" (silver o gold o platinum) posso avere in aggiunta un ruolo "bonus" (es: gold e bonus)

- Scenario pass di accesso
  - In questo scenario l'utente 1 ha accesso a cucina, sala e bagno mentre l'utente 2 ha accesso solo a sala e bagno

- Scenario storico di un blog con moderatore (usiamo la tabella example_posts)
  - Non vengono più scritti o modificati articoli ma gli utenti con ruolo di moderatore possono cancellare qualsiasi articolo.

- Scenario storico di un blog con ruolo autore per gli articoli che l'utente scrive
  - In questo scenario l'utente con id=1 è autore di solo due articoli

- Scenario blog con autori
  - ogni utente con o senza ruolo ha accesso alla lettura di tutti gli articoli
  - ogni utente con ruolo di autore ha accesso alla modifica solo dei suoi articoli

- Scenario blog con autori e moderatore
  - ogni utente con o senza ruolo ha accesso alla lettura di tutti gli articoli
  - ogni utente con ruolo di autore ha accesso alla modifica solo dei suoi articoli
  - ogni utente con ruolo di moderatore ha accesso alla modifica di tutti gli articoli

- Scenario forum (usiamo la tabella example_posts come se fosse la tabella forums)
  - ogni utente con o senza ruolo ha accesso alla lettura di tutti gli articoli
  - ogni utente con ruolo di autore ha accesso alla creazione/modifica solo dei suoi articoli
  - ogni utente con ruolo di moderatore ha accesso alla sola eliminazione di tutti gli articoli
  - Un utente che può creare dei suoi articoli e cancellarli deve avere i ruoli sia di autore che di moderatore.

- Scenario articoli aziendali privati (usiamo la tabella example_posts e la tabella companies)
  - Ogni utente che non appartiene a nessuna azienda non può vedere nessun articolo
  - Ogni utente con o senza ruolo, che appartiene ad una o più aziende, ha accesso alla lettura di tutti gli articoli delle aziende a cui appartiene
  - Ogni utente con ruolo moderatore, che appartiene ad una o più aziende, può modificare tutti gli articoli delle aziende a cui appartiene
  - Ogni utente con ruolo autore, che appartiene ad una o più aziende, può modificare solo i suoi articoli delle aziende a cui appartiene



### Scenario con solo admin (come roles-admin)

```bash
$ rails c

  # Definiamo un ruolo globale
> user = User.find(1)
> user.has_role? :admin
=> false
> user.add_role :admin
> user.has_role? :admin
=> true
> user.remove_role :admin
> user.has_role? :admin
=> false
```



### Scenario con silver, gold, platinum (come roles-enum)

```bash
$ rails c

> u1 = User.find(1)
> u1.add_role :silver

> u2 = User.find(2)
> u2.add_role :gold

> u3 = User.find(3)
> u3.add_role :platinum

> u1.has_role? :silver
=> true
> u1.has_role? :gold
=> false
> u1.has_role? :platinum
=> false

> u2.has_role? :silver
=> false
> u2.has_role? :gold
=> true
> u2.has_role? :platinum
=> false

> u3.has_role? :silver
=> false
> u3.has_role? :gold
=> false
> u3.has_role? :platinum
=> true

> u1.remove_role :silver
> u2.remove_role :gold
> u3.remove_role :platinum
```



### Scenario con silver, gold, platinum ed in aggiunta bonus

In questo caso oltre il ruolo tipo "enum" (silver o gold o platinum) posso avere in aggiunta un ruolo "bonus" (es: gold e bonus)

```bash
$ rails c

> u1 = User.find(1)
> u1.add_role :gold
> u1.add_role :bonus

> u2 = User.find(1)
> u2.add_role :gold

> u1.has_role? :silver
=> false
> u1.has_role? :gold
=> true
> u1.has_role? :platinum
=> false
> u1.has_role? :bonus
=> true

> u2.has_role? :silver
=> false
> u2.has_role? :gold
=> true
> u2.has_role? :platinum
=> false
> u2.has_role? :bonus
=> false

> u1.remove_role :silver
> u1.remove_role :bonus
> u2.remove_role :gold
```



### Scenario pass di accesso

In questo scenario l'utente 1 ha accesso a cucina, sala e bagno mentre l'utente 2 ha accesso solo a sala e bagno

```bash
$ rails c

> u1 = User.find(1)
> u1.add_role :cucina
> u1.add_role :sala
> u1.add_role :bagno

> u2 = User.find(1)
> u2.add_role :sala
> u2.add_role :bagno

> u1.has_role? :cucina
=> true
> u1.has_role? :sala
=> true
> u1.has_role? :bagno
=> true
> u1.has_role? :camera_da_letto
=> false

> u2.has_role? :cucina
=> false
> u2.has_role? :sala
=> true
> u2.has_role? :bagno
=> true
> u2.has_role? :camera_da_letto
=> false

> u1.remove_role :cucina
> u1.remove_role :sala
> u1.remove_role :bagno
> u2.remove_role :sala
> u2.remove_role :bagno
```



## Aggiungiamo un ruolo di default agli utenti

https://github.com/plataformatec/devise/wiki/How-To:-Add-a-default-role-to-a-User

```
class User < ActiveRecord::Base
  belongs_to :role
  before_create :set_default_role
  # or 
  # before_validation :set_default_role 

  private
  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end
end
```



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
