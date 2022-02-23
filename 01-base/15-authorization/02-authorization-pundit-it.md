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

***codice 01 - .../Gemfile - line: 54***

```ruby
# Object oriented authorization for Rails applications
gem 'pundit', '~> 2.2'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/02_01-gemfile.rb)


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Aggiungiamo Pundit ad application_controller

Includiamo Pundit nel nostro application controller.

***codice 02 - .../app/controllers/application_controller.rb - line: 5***

```ruby
  include Pundit
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/02_02-application_controller.rb)

> Questo ci permette di usare Pundit in tutta la nostra applicazione.



## Lo script

Questo passaggio è opzionale ma è interessante farlo per avere una policy generica che erediteremo nelle classi delle policies specifiche per ogni Model da autorizzare. 
Quindi eseguiamo lo script di implementazione di pundit su rails. 
Lo script è anche noto con il nome di *generator*.

Il *generator* creerà un file con le varie regole di autorizzazione di default chiamato *"application policy"*.

```bash
$ rails g pundit:install
```

Esempio:
  
```bash
user_fb:~/environment/bl7_0 (pi) $ rails g pundit:install
      create  app/policies/application_policy.rb
user_fb:~/environment/bl7_0 (pi) $ 
```

Vediamo il file creato.

***codice 03 - .../app/policies/application_policy.rb - line: 3***

```ruby
class ApplicationPolicy
  attr_reader :user, :record
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/02_03-policies-application_policy.rb)

Riavviamo il server Rails per rilevare ogni classe nella nuova directory *".../app/policies"*.
E con questo abbiamo predisposto l'ambiente di pundit. 
Nel prossimo capitolo inizieremo ad usarlo per le autorizzazioni.

> Nota: <br/>
> Su pundit 2.1 il *generator* creava un file con dentro *class Scope* -> *def resolve* -> *scope.all*.

```ruby
    def resolve
      scope.all
    end
```

> invece su pundit 2.2 nel file abbiamo  *class Scope* -> *def resolve* -> *raise NotImplementedError*



## Verifichiamo preview

Al momento abbiamo fatto solo la preparazione. Verificheremo le autorizzazioni nel prossimo capitolo.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "install pundit"
```



## Publichiamo su heroku

```bash
$ git push heroku pi:main
```

Non serve `heroku run rails db:migrate` perché non abbbiamo fatto modifiche al database.



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



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/01-theory-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/15-authorization/03-authorization-users-it.md)
