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

Il *generator* imposterà una *"application policy"* (file con le varie regole di aturizzazione) con alcune impostazioni predefinite.

```bash
$ rails g pundit:install


user_fb:~/environment/bl6_0 (pi) $ rails g pundit:install
Running via Spring preloader in process 4686
      create  app/policies/application_policy.rb
```

Questo ci crea il seguente codice

***codice 03 - .../app/policies/application_policy.rb - line: 1***

```ruby
class ApplicationPolicy
  attr_reader :user, :record
```

[tutto il codice](#01-15-02_03all)

Dopo aver generato la "application policy", riavviamo il server Rails in modo che Rails possa rilevare ogni classe nella nuova directory ".../app/policies".

E con questo abbiamo predisposto l'ambiente di pundit. Nel prossimo capitolo inizieremo ad usarlo per le autorizzazioni.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s
```

apriamolo il browser sull'URL:

* https://mycloud9path.amazonaws.com/users

Creando un nuovo utente o aggiornando un utente esistente vediamo i nuovi messaggi tradotti.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "install pundit"
```



## Publichiamo su heroku

```bash
$ git push heroku pi:master
```

Non serve `heroku run rails db:migrate` perché non abbbiamo fatto modifiche al database.



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout master
$ git merge pi
$ git branch -d pi
```



## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin master
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02-users_form_i18n-it.md)
