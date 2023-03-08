# <a name="top"></a> Cap 15.2 - Autorizzazione - installiamo Pundit

Per gestire le varie *autorizzazioni* ai vari *ruoli* usiamo la gemma **Pundit**.



## Risorse interne

- [99-rails_references/authentication_authorization_roles/05-pundit]()



## Apriamo il branch "Pundit Install"

```bash
$ git checkout -b pi
```



## Installiamo la gemma

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/pundit)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/varvet/pundit)

***Codice 01 - .../Gemfile - linea:54***

```ruby
# Object oriented authorization for Rails applications
gem 'pundit', '~> 2.2'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/11-authorization/02_01-gemfile.rb)


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Aggiungiamo Pundit ad application_controller

Includiamo Pundit nel nostro application controller.

***Codice 02 - .../app/controllers/application_controller.rb - linea:04***

```ruby
  include Pundit
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/11-authorization/02_02-application_controller.rb)

> Questo ci permette di usare Pundit in tutta la nostra applicazione.



## Lo script

Eseguiamo lo script di implementazione di pundit su rails. Lo script è anche noto con il nome di `generator`.

```bash
$ rails g pundit:install
```

> Questo passaggio è opzionale ma è interessante farlo per avere una `policy` generica che erediteremo nelle classi delle `policies` specifiche per ogni `Model` da autorizzare.

> Il `generator` crea un file con le varie regole di autorizzazione di default chiamato `application policy`.

Esempio:
  
```bash
ubuntu@ubuntufla:~/ubuntudream (pi)$rails g pundit:install
      create  app/policies/application_policy.rb
ubuntu@ubuntufla:~/ubuntudream (pi)$
```

Vediamo il file creato.

***Codice 03 - .../app/policies/application_policy.rb - linea:03***

```ruby
class ApplicationPolicy
  attr_reader :user, :record
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/02_03-policies-application_policy.rb)

Riavviamo il server Rails per rilevare ogni classe nella nuova directory `.../app/policies`.
E con questo abbiamo predisposto l'ambiente di pundit. 
Nel prossimo capitolo inizieremo ad usarlo per le autorizzazioni.

> Nota: <br/>
> Su pundit 2.1 il `generator` creava un file con dentro `class Scope` -> `def resolve` -> `scope.all`.

```ruby
    def resolve
      scope.all
    end
```

> invece su pundit 2.2 abbiamo `class Scope` -> `def resolve` -> `raise NotImplementedError, "You must define #resolve in #{self.class}"`

```ruby
    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end
```


## Verifichiamo preview

Al momento abbiamo fatto solo la preparazione. Verificheremo le autorizzazioni nel prossimo capitolo.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "install pundit"
```



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge pi
$ git branch -d pi
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



## Publichiamo su render.com

Lo fa in automatico




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/01_00-theory-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/03_00-authorization-users-it.md)
