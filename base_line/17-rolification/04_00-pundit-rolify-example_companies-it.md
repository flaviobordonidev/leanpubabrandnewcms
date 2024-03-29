# <a name="top"></a> Cap 16.4 - Definiamo i ruoli includendo le aziende

Risorse web:

* [Pundit autorizzazione con ruoli multipli](http://groselhas.maurogeorge.com.br/rolify-com-pundit-para-uma-autorizacao-com-multiplos-papeis.html#sthash.9XW2D14b.4ghYl5vd.dpbs)

Nel sistema di gestione aziendale abbiamo 3 ruoli:

* Manager     : può visualizzare tutte le schermate del sistema. 
* Dipendente  : non può creare, modificare o cancellare alcuna azienda. 
* Investitore : deve solo visualizzare le società in cui investe.

Questo è un sistema a più ruoli. Nello specifico dobbiamo essere in grado di definire per ciascuno degli investitori a quali società ha accesso. 
Supponendo che abbiamo le società A, B e C, deve essere possibile dire che l'investitore ha il ruolo di investimento solo nelle società A e C, cioè, ha 2 ruoli diversi


Questo tipo di autorizzazione non si poteva neanche basare su una relazione diretta uno-a-molti tra utente e azienda (che tra l'altro non abbiamo implementato) perché questo funzionerebbe per un solo utente. Aggiungendo il secondo utente si sovrapporrebbe su alcune aziende; è in pratica una relazione molti-a-molti.
Non implementiamo una relazione molti a molti ma sfruttiamo invece la gemma rolify per assegnare un ruolo di "investitore" per alcune aziende e per ritrovare in seguito tutte le aziende per cui quell'utente è autorizzato ad investire. In pratica usiamo lo stesso rolify per gestire una relazione molti-a-molti.





*********************************************************
Simplesmente adicionamos o macro resourcify no model que queremos utilizar na definição dos papeis.

```
class Company < ActiveRecord::Base
  # ...

  resourcify
end
```


user.add_role :investor, company
user.remove_role :investor, company


O Rolify nos fornece um model Role então o que temos que fazer é apenas definir as validações de inclusão no mesmo.

class Role < ActiveRecord::Base

  NAMES = %w{ investor }
  RESOURCE_TYPES = %w{ Company }

  validates :name, inclusion: { in: NAMES }
  validates :resource_type, inclusion: { in: RESOURCE_TYPES }

  # ...
end



Company.with_role(:investor, user)

Assim temos todas as empresas em que o user é investidor, com uma simples chamada de método.


class CompanyPolicy < ApplicationPolicy

  # ...

  class Scope < Scope
    def resolve
      if user.has_role?(:investor, :any)
        scope.with_role(:investor, user)
      else
        scope.all
      end
    end
  end
end

def index
  @companies = policy_scope(Company)
end

*********************************************************







## Recuperiamo le aziende in cui l'utente ha il ruolo di investitore

Rolify ci offre metodi di query per interagire con le nostre risorse che sono dichiarate con **resourcify**. 
Con il metodo **.with_role* siamo in grado di recuperare tutte le società in cui un utente specifico ha il ruolo di investitore.

```
Company.with_role(:investor, user)
```

Quindi abbiamo tutte le società in cui l'utente è un investitore, con una semplice chiamata di metodo.




## Pundit insieme a Rolify

Tornando alle nostre esigenze, dobbiamo elencare solo le società in cui investe l'investitore. 
Pundit ci consente di definire un ambito **scope** in base alle autorizzazioni dell'utente.
Dobbiamo solo definire una classe **Scope** all'interno della nostra CompanyPolicy e implementiamo il metodo **resolve**. 
Dal momento che ereditiamo dallo **Scope** di **ApplicationPolicy** abbiamo già accesso all'utente e al suo **scope**.
Non ci resta che eseguire la query di cui abbiamo bisogno.


O Rolify define também o método #has_role? o utilizamos para verificar se o usuário possui qualquer papel de investor, caso ele possua listamos apenas as empresas em que ele tem acesso, caso não possua nenhum papel de investidor exibimos todas as empresas.

```
class CompanyPolicy < ApplicationPolicy

  # ...

  class Scope < Scope
    def resolve
      if user.has_role?(:investor, :any)
        scope.with_role(:investor, user)
      else
        scope.all
      end
    end
  end
end
```

Rolify definisce anche il metodo **has_role?**. 
Lo usiamo per verificare se l'utente ha un ruolo di investitore; se lo ha elenchiamo solo le società a cui ha accesso, se non ha alcun ruolo di investitore mostriamo tutte le società.

Avendo definito il nostro **scope** non ci resta che chiamarlo nel controller usando **policy_scope**.

```
def index
  @companies = policy_scope(Company)
end
```

Ora, a seconda del ruolo dell'utente, viene visualizzato un elenco con tutte le società o solo con quelle in cui l'utente è un investitore.






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

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/16-rolification/03_00-pundit-rolify-example_posts-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/16-rolification/05_00-authorization-more_roles-it.md)
