# <a name="top"></a> Cap 20.2 - Organizziamo i models (...continua)

Impostiamo i "divisori" visti nel metodo di organizzazione




## Apriamo il branch "Organize Models"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b om
```




## EgPost

Nel model EgPost abbiamo del codice nella:

* sezione "# == Attributes", sottosezione "## Active Storage"
* sezione "# == Attributes", sottosezione "## Action Text"
* sezione "# == Relationships", sottosezione "## association one-to-many"

{id: "01-20-02_01", caption: ".../app/models/eg_post.rb -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
class EgPost < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  # == Attributes ===========================================================

  ## Active Storage
  has_one_attached :header_image
  
  ## Action Text
  has_rich_text :content

  # == Relationships ========================================================

  ## association one-to-many
  belongs_to :user

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
```




## User

Nel model User abbiamo del codice nella:

* sezione "# == Extensions", sottosezione "## devise"
* sezione "# == Attributes", sottosezione "## enum"
* sezione "# == Relationships", sottosezione "## association one-to-many"
* sezione "# == Validations"

{id: "01-20-02_01", caption: ".../app/models/user.rb -- codice 02", format: ruby, line-numbers: true, number-from: 1}
```
class User < ApplicationRecord
  # == Constants ============================================================
  
  # == Extensions ===========================================================

  ## devise
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # == Attributes ===========================================================

  ## enum
  #enum role: [:user, :admin, :moderator, :author]
  enum role: {user: 0, admin: 1, moderator:2, author:3}

  # == Relationships ========================================================

  ## association one-to-many
  has_many :eg_posts

  # == Validations ==========================================================

  validates :name, presence: true,
                  uniqueness: true,
                  length: { maximum: 50 }

  validates :email, presence: true,
                    uniqueness: true,
                    length: { maximum: 50 },
                    format: { with: URI::MailTo::EMAIL_REGEXP } 

  validates :password, presence: true,
                      length: { in: 6..25 }

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================

end
```

La parte di devise è nella sezione "Extensions" e non "Attributes" perché ogni voce non è una singola colonna nella tabella ma è un modulo che attiva più funzionalità e a volte più colonne nella tabella (che vanno abilitate con un migrate).




## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "organize models"
```




## Publichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku om:master
```




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge om
$ git branch -d om
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




[Codice 01](#01-14-02_01)

{id="01-14-02_01all", title="Gemfile", lang=ruby, line-numbers=on, starting-line-number=1}
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
