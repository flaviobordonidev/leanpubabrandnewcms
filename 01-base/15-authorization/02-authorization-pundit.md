{id: 01-base-15-authorization-02-authorization-pundit}
# Cap 15.2 -- Autorizzazione - installiamo Pundit

Per gestire le varie autorizzazioni ai vari ruoli usiamo la gemma Pundit.


Risorse interne

* 99-rails_references/authentication_authorization_roles/05-pundit




## Apriamo il branch "Pundit Install"

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout -b pi
```




## Installiamo la gemma

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/pundit)
I>
I> facciamo riferimento al [tutorial github della gemma](https://github.com/varvet/pundit)

{id: "01-15-02_01", caption: ".../Gemfile -- codice 01", format: ruby, line-numbers: true, number-from: 34}
```
# Object oriented authorization for Rails applications
gem 'pundit', '~> 2.1'
```

[tutto il codice](#01-15-02_01all)


Eseguiamo l'installazione della gemma con bundle

{caption: "terminal", format: bash, line-numbers: false}
```
$ bundle install
```




## Aggiungiamo Pundit ad application_controller

Includiamo Pundit nel nostro application controller.

{id: "01-15-02_02", caption: ".../app/controllers/application_controller.rb -- codice 02", format: ruby, line-numbers: true, number-from: 4}
```
  include Pundit
```

[tutto il codice](#01-15-02_02all)

Questo ci permette di usare Pundit in tutta la nostra applicazione.




## Lo script

Questo passaggio è opzionale ma è interessante farlo per avere una policy generica che erediteremo nelle classi delle policies specifiche per ogni Model da autorizzare. Quindi eseguiamo lo script di implementazione di pundit su rails. Lo script (Anche noto con il nome di "generator").
Il "generator" (generatore) imposterà un "application policy" (file con le varie regole di aturizzazione) con alcune impostazioni predefinite utili. 

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g pundit:install


user_fb:~/environment/bl6_0 (pi) $ rails g pundit:install
Running via Spring preloader in process 4686
      create  app/policies/application_policy.rb
```

Questo ci crea il seguente codice

{id: "01-15-02_03", caption: ".../app/policies/application_policy.rb -- codice 03", format: ruby, line-numbers: true, number-from: 1}
```
class ApplicationPolicy
  attr_reader :user, :record
```

[tutto il codice](#01-15-02_03all)

Dopo aver generato la "application policy", riavviamo il server Rails in modo che Rails possa rilevare ogni classe nella nuova directory ".../app/policies".

E con questo abbiamo predisposto l'ambiente di pundit. Nel prossimo capitolo inizieremo ad usarlo per le autorizzazioni.



## archiviamo su git

{caption: "terminal", format: bash, line-numbers: false}
```
$ git add -A
$ git commit -m "install pundit"
```




## Publichiamo su heroku

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push heroku pi:master
```

Non serve "heroku run rails db:migrate" perché non abbbiamo fatto modifiche al database.




## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

{caption: "terminal", format: bash, line-numbers: false}
```
$ git checkout master
$ git merge pi
$ git branch -d pi
```




## Facciamo un backup su Github

Dal nostro branch master di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

{caption: "terminal", format: bash, line-numbers: false}
```
$ git push origin master
```




## Il codice del capitolo




{id: "01-15-02_01all", caption: ".../Gemfile -- codice 01", format: ruby, line-numbers: true, number-from: 1}
```
#TODO
```

[indietro](#01-15-02_01)
