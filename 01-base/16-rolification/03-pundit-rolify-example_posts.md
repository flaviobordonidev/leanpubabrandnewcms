# Definiamo i ruoli includendo gli articoli




## Scenario da sistemare

Assegnamo dei ruoli da console

Implementiamo l'autorizzazione permettendo solo agli autori e all'amministratore di fare le modifiche.

Con rolify assegnamo dei ruoli ai vari utenti

Diamo il ruolo di amministratore all'utente con id=1 per tutta l'applicazione 
Diamo il ruolo di moderatore all'utente con id=2 per la sola tabella **posts** per tutti gli articoli
Diamo il ruolo di autore all'utente con id=3 per la sola tabella **posts** e solo per gli articoli creati da lui
Lasciamo senza ruoli l'utente con id=4

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c

  # Definiamo un ruolo globale
> u1 = User.find(1)
> u1.add_role :admin

> u1.has_role? :admin
=> true
> u1.has_role? :admin, Post
=> true
> u1.has_role? :admin, Post.first
=> true
> u1.has_role? :admin, Post.find(5)
=> true
> u1.has_role? :admin, Post.last
=> true

  # Definiamo un ruolo per una classe
> u2 = User.find(2)
> u2.add_role :moderator, Post

> u2.has_role? :moderator
=> false
> u2.has_role? :moderator, Post
=> true
> u2.has_role? :moderator, Post.first
=> true
> u2.has_role? :moderator, Post.find(5)
=> true
> u2.has_role? :moderator, Post.last
=> true

  # Definiamo un ruolo per una istanza
> u3 = User.find(3)
> u3.add_role :author, Post.find(1)
> u3.add_role :author, Post.find(4)

> u3.has_role? :author
=> false
> u3.has_role? :author, Post
=> false
> u3.has_role? :author, Post.find(1)
=> true
> u3.has_role? :author, Post.find(2)
=> false
> u3.has_role? :author, Post.find(5)
=> false
```

Il primo utente ha il ruolo :admin per tutto (a livello globale).
Il secondo utente ha il ruolo :moderator per tutti gli articoli (a livello di classe Post)
Il terzo utente ha il ruolo di :author solo per il primo ed il quarto articolo (a livello di istanza). Glia bbiamo assegnato questi articoli come se li avesse creati lui.
Il quarto utente non ha nessun ruolo




### Implementiamo il ruolo di autore per i nuovi articoli

Una volta che un utente ha fatto login (e quindi è autenticato tramite devise) ha accesso alla dashboard ma non può editare nessun articolo.
Può però crearne di nuovi. Una volta creati gli assegnamo il ruolo di autore per quegli articoli e quindi quelli sarà autorizzato a modificarli.

In pratica questo viene usato assegnando il ruolo tutte le volte che l'autore crea un nuovo articolo. Quindi inserisco il ruolo durante l'azione "create".

{title=".../app/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=11}
```
  def create
    @post = Post.new(post_params)
      if @post.save
        current_user.add_role :author, @post
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
  end
```


### Implementiamo le autorizzazioni

Con pundit assegnamo le autorizzazioni ai vari ruoli.

Per la tabella posts
  Il ruolo di amministratore è autorizzato a fare tutto
  Il ruolo di moderatore è autorizzato a cancellare qualsiasi articolo. Non può editarli.
  Il ruolo di autore è autorizzato ad editare e cancellare solo i suoi articoli (quelli creati da lui).
  Un utente loggato che non ha ruoli può solo creare un nuovo articolo.
  Se un utente non è loggato può solo visualizzare gli articoli



### Creiamo la policy

La convenzione pundit per le policies è che abbiano lo stesso nome del "model" con il suffisso "_policy" quindi nel nostro caso abbiamo "post_policy.rb".
Non ci dobbiamo preoccupare che il controller per la modifica degli articoli è incapsulata nel modulo "authors" perché pundit per le policies si riferisce al "model".
Ci occuperemo nel prossimo paragrafo di coinvolgere il controller che ci interessa implementando le autorizzazioni.

{title=".../app/policies/post_policy.rb", lang=ruby, line-numbers=on, starting-line-number=11}
```
  class PostPolicy < ApplicationPolicy
  
    def index?
      true
    end
  
    def show?
      true
    end
    
    def create?
      @user.present?
    end
    
    def update?
      if @user.present?
        @user.has_role? :author or @user.has_role? :admin
      else
        false
      end
    end
  
    def destroy?
      if @user.present?
        @user.has_role? :author, Post.find(1) or @user.has_role? :moderator, Post or @user.has_role? :admin
        u2.has_role? :author, Post or u2.has_role? :moderator, Post or  u2.has_role? :admin
      else
        false
      end
    end
    
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
```


******
    def create?
      #@user.present? ? @user.has_role?(:admin) : false
      if @user.present?
        @user.has_role? :admin
      else
        false
      end
    end
*******




## Scenario storico di un blog con moderatore

In questo scenario usiamo la tabella example_posts che abbiamo creato nei capitoli precedenti.

Non vengono più scritti o modificati articoli ma gli utenti con ruolo di moderatore possono cancellare qualsiasi articolo.

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c

  # Definiamo un ruolo per una classe
> user = User.find(1)
> user.add_role :moderator, Post

> user.has_role? :moderator
=> false
> user.has_role? :moderator, Post
=> true
> user.has_role? :moderator, Post.first
=> true
> user.has_role? :moderator, Post.find(5)
=> true
> user.has_role? :moderator, Post.last
=> true

> user.remove_role :moderator, Post
```

In questo esempio il primo utente ha il ruolo :moderator per tutti gli articoli (a livello di classe Post) ma non a livello globale.




## Scenario storico di un blog con ruolo autore per gli articoli che l'utente scrive

In questo scenario l'utente con id=1 è autore di solo due articoli

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c

  # Definiamo un ruolo per una istanza
> user = User.find(1)
> user.add_role :author, Post.find(1)
> user.add_role :author, Post.find(4)

> user.has_role? :author
=> false
> user.has_role? :author, Post
=> false
> user.has_role? :author, Post.find(1)
=> true
> user.has_role? :author, Post.find(2)
=> false
> user.has_role? :author, Post.find(5)
=> false

> user.remove_role :moderator, Post
```

In pratica questo viene usato assegnando il ruolo tutte le volte che l'autore crea un nuovo articolo. Quindi inserisco il ruolo durante l'azione "create".

{title="/app/controllers/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=11}
```
  def create
    @post = Post.new(post_params)
      if @post.save
        current_user.add_role :author, @post
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
  end
```




## Scenario blog con autori

In questo scenario 
* ogni utente con o senza ruolo ha accesso alla lettura di tutti gli articoli
* ogni utente con ruolo di autore ha accesso alla modifica solo dei suoi articoli


{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c

  # Definiamo un ruolo per una classe
> u1 = User.find(1)
> u1.add_role :moderator, Post

> u2 = User.find(2)
> u2.add_role :moderator, Post.find(4)
> u2.add_role :moderator, Post.find(2)


  # richiamiamo tutti gli articoli che hanno un moderatore
> Post.with_role(:moderator)

  # richiamiamo tutti gli articoli per cui u1 è moderatore
> Post.with_role(:moderator, u1)

  # richiamiamo tutti gli articoli per cui u2 è moderatore
> Post.with_role(:moderator, u2)

  # richiamiamo gli articoli di u1 per cui u1 è moderatore
> u1.posts.with_roles(:moderator, u1)

  # richiamiamo gli articoli di u1 per cui u2 è moderatore
> u1.posts.with_roles(:moderator, u2)

  # richiamiamo gli articoli di u2 per cui u2 è moderatore
> u2.posts.with_roles(:moderator, u2)

  # richiamiamo gli articoli di u2 per cui u1 è moderatore
> u2.posts.with_roles(:moderator, u1)
  
  # togliamo un ruolo ad u1 per l'istanza 2
> u1.remove_role :moderator, Post.find(2)

  # richiamiamo gli articoli di u1 per cui u1 è moderatore
> u1.posts.with_roles(:moderator, u1)

  # togliamo globalmente il ruolo :moderator ad u1 e u2
> u1.remove_role :moderator
> u2.remove_role :moderator

> user.remove_role :moderator, Post
```







## Scenario blog con autori e moderatore

In questo scenario 
* ogni utente con o senza ruolo ha accesso alla lettura di tutti gli articoli
* ogni utente con ruolo di autore ha accesso alla modifica solo dei suoi articoli
* ogni utente con ruolo di moderatore ha accesso alla modifica di tutti gli articoli




## Scenario forum

per questo scenario usiamo la tabella posts come se fosse la tabella forums.
Un utente che può creare dei suoi articoli e cancellarli deve avere i ruoli sia di autore che di moderatore.
In questo scenario 
* ogni utente con o senza ruolo ha accesso alla lettura di tutti gli articoli
* ogni utente con ruolo di autore ha accesso alla creazione/modifica solo dei suoi articoli
* ogni utente con ruolo di moderatore ha accesso alla sola eliminazione di tutti gli articoli




## Scenario articoli aziendali privati

In questo scenario
* Ogni utente che non appartiene a nessuna azienda non può vedere nessun articolo
* Ogni utente con o senza ruolo, che appartiene ad una o più aziende, ha accesso alla lettura di tutti gli articoli delle aziende a cui appartiene
* Ogni utente con ruolo moderatore, che appartiene ad una o più aziende, può modificare tutti gli articoli delle aziende a cui appartiene
* Ogni utente con ruolo autore, che appartiene ad una o più aziende, può modificare solo i suoi articoli delle aziende a cui appartiene

Questo scenario utillizza la tabella example_companies


{caption: "terminal", format: bash, line-numbers: false}
```
$ rails c

  # Definiamo un ruolo globale
> user = User.find(1)
> user.add_role :admin
> user.has_role? :admin
=> true

  # Definiamo un ruolo per una classe
> user = User.find(3)
> user.add_role :moderator, Forum
> user.has_role? :moderator, Forum
=> true
> user.has_role? :moderator, Forum.first
=> true
> user.has_role? :moderator, Forum.last
=> true

  # Definiamo un ruolo per una istanza specifica
> user = User.find(2)
> user.add_role :moderator, Forum.first
> user.has_role? :moderator, Forum.first
=> true
> user.has_role? :moderator, Forum.last
=> false

  # Rimuoviamo un ruolo
> user = User.find(3)
> user.remove_role :moderator
```




A global role overrides resource role request:

user = User.find(4)
user.add_role :moderator # sets a global role
user.has_role? :moderator, Forum.first
=> true
user.has_role? :moderator, Forum.last
=> true


6. Resource roles querying
Starting from rolify 3.0, you can search roles on instance level or class level resources.

Instance level
forum = Forum.first
forum.roles
# => [ list of roles that are only bound to forum instance ]
forum.applied_roles
# => [ list of roles bound to forum instance and to the Forum class ]
Class level
Forum.with_role(:admin)
# => [ list of Forum instances that have role "admin" bound to them ]
Forum.without_role(:admin)
# => [ list of Forum instances that do NOT have role "admin" bound to them ]
Forum.with_role(:admin, current_user)
# => [ list of Forum instances that have role "admin" bound to them and belong to current_user roles ]
Forum.with_roles([:admin, :user], current_user)
# => [ list of Forum instances that have role "admin" or "user" bound to them and belong to current_user roles ]

User.with_any_role(:user, :admin)
# => [ list of User instances that have role "admin" or "user" bound to them ]
User.with_role(:site_admin, current_site)
# => [ list of User instances that have a scoped role of "site_admin" to a site instance ]
User.with_role(:site_admin, :any)
# => [ list of User instances that have a scoped role of "site_admin" for any site instances ]
User.with_all_roles(:site_admin, :admin)
# => [ list of User instances that have a role of "site_admin" and a role of "admin" bound to it ]

Forum.find_roles
# => [ list of roles that are bound to any Forum instance or to the Forum class ]
Forum.find_roles(:admin)
# => [ list of roles that are bound to any Forum instance or to the Forum class, with "admin" as a role name ]
Forum.find_roles(:admin, current_user)
# => [ list of roles that are bound to any Forum instance, or to the Forum class with "admin" as a role name, and belongs to current_user ]








## Fine degli scenari 







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
