# <a name="top"></a> Cap 7.5 - Implementiamo un layout personalizzato per il login

La views di login ha generalmente uno stile diverso dalle altre pagine quindi disponiamo un layout specifico per lei.



## Attiviamo i controllers personalizzabili di devise

Attiviamo i **controllers** di devise per il model *User* in modo da poter indicare un **layout specifico** per loro.

> E' arrivato il momento di effettuare il passaggio numero 4 dello script di installazione devise che avevamo lasciato in sospeso.

```bash
$ rails generate devise:views users
$ rails generate devise:controllers users
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (siso) $ rails generate devise:views users
      invoke  Devise::Generators::SharedViewsGenerator
      create    app/views/users/shared
      create    app/views/users/shared/_error_messages.html.erb
      create    app/views/users/shared/_links.html.erb
      invoke  form_for
      create    app/views/users/confirmations
      create    app/views/users/confirmations/new.html.erb
      create    app/views/users/passwords
      create    app/views/users/passwords/edit.html.erb
      create    app/views/users/passwords/new.html.erb
      create    app/views/users/registrations
      create    app/views/users/registrations/edit.html.erb
      create    app/views/users/registrations/new.html.erb
      create    app/views/users/sessions
      create    app/views/users/sessions/new.html.erb
      create    app/views/users/unlocks
      create    app/views/users/unlocks/new.html.erb
      invoke  erb
      create    app/views/users/mailer
      create    app/views/users/mailer/confirmation_instructions.html.erb
      create    app/views/users/mailer/email_changed.html.erb
      create    app/views/users/mailer/password_change.html.erb
      create    app/views/users/mailer/reset_password_instructions.html.erb
      create    app/views/users/mailer/unlock_instructions.html.erb
user_fb:~/environment/bl7_0 (siso) $ rails generate devise:controllers users
      create  app/controllers/users/confirmations_controller.rb
      create  app/controllers/users/passwords_controller.rb
      create  app/controllers/users/registrations_controller.rb
      create  app/controllers/users/sessions_controller.rb
      create  app/controllers/users/unlocks_controller.rb
      create  app/controllers/users/omniauth_callbacks_controller.rb
===============================================================================

Some setup you must do manually if you haven't yet:

  Ensure you have overridden routes for generated controllers in your routes.rb.
  For example:

    Rails.application.routes.draw do
      devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
    end

===============================================================================
user_fb:~/environment/bl7_0 (siso) $ 
```

Questo ci crea le seguenti nuove cartelle e files:

- la sottocartella */app/views/users/* con tutte le **views** gestite da devise. 
- la sottocartella */app/controller/users/* con tutti i **controllers** gestiti da devise.

> Se avessimo già effettuato il passaggio numero 4, il `rails generate devise:views`, avremmo dovuto copiare le views da *devise/sessions* a *users/sessions*. 
> Questo perché adesso il controller è stato cambiato e non usa più le views di default in *devise/sessions*.



## Aggiorniamo gli instradamenti

Aggiungiamo il parametro `controllers: { sessions: 'users/sessions' }` a *devise_for :users*, questo indica a devise di usare i nuovi controllers (e non quelli di default).


***codice 01 - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}, controllers: { sessions: 'users/sessions' }
  resources :users
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/05_01-config-routes.rb)



## Come sarabbero gli instradamenti anche con *registerable*

Se avessimo attivo il *:registerable* avremmo dovuto inserire l'instradamento anche per *users/registrations*. 
In quel caso avremmo indicato entrambi i nuovi controllers a cui si deve riferire devise:

- sessions: 'users/sessions'
- registrations: 'users/registrations'

quindi il parametro sarebbe stato: `controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}`

***codice n/a - .../config/routes.rb - line: 2***

```ruby
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'}
  resources :users
```



## Creiamo il nuovo layout *entrance*

Nella cartella *views/layouts* creiamo una nuova view che chiamiamo *entrance* e al suo interno copiamo tutto il codice che al momento è sulla view *application* (la view del layout di default).

***codice 02 - .../app/views/layout/entrance.html.erb - line: 1***

```html+erb
<!DOCTYPE html>
<html>
  <head>
    <title>ENTRANCE TO Bl70</title>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/05_02-views-layout-entrance.html.erb)

> Per distinguere le due views di layout abbiamo aggiunto *ENTRANCE TO* al *<title>* e il paragraph `<p>ENTRANCE</p>` subito dopo il *<body>*. 
> Ma andando avanti con il tutorial le due view si differenzieranno sensibilmente.



## Indichiamo a devise di usare il nuovo layout *entrance*

Per indicare a devise di usare il nostro nuovo layout dobbiamo aggiornare il controller. 
Ed è per questo che precedentemente abbiamo usato `rails generate devise:controllers users`. 
Così adesso abbiamo in chiaro il controller di devise che gestisce il *sign_in/login* e il *sign_out/logout*. 

***codice 03 - .../app/controllers/users/sessions_controller.rb - line: 6***

```ruby
  layout 'entrance'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/05_03-controllers-users-sessions_controller.rb)

Aggiungendo `layout 'entrance'` indichiamo a tutte le azioni di *sessions_controller* di usare il nuovo layout. 

> Se lo avessimo voluto usare solo per il *sign_in/login* avremmo decommentato l'azione ***new*** inserendo al suo interno `render layout: 'entrance'`.



## Verifichiamo preview

```bash
$ sudo service postgresql start
$ rails s -b 192.168.64.3
```

- https://mycloud9path.amazonaws.com/
- https://mycloud9path.amazonaws.com/login

> Nella pagina di ***login*** il tab del browser ha il nome "ENTRANCE TO Bl70"



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "New layout entrance for login"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku siso:main
$ heroku run rails db:migrate
```

> Possiamo anche non eseguire `$ heroku run rails db:migrate` perché non tocchiamo il database



## Chiudiamo il branch

se abbiamo finito le modifiche e va tutto bene:

```bash
$ git checkout main
$ git merge siso
$ git branch -d siso
```



## Facciamo un backup su Github

Dal nostro branch main di Git facciamo un backup di tutta l'applicazione sulla repository remota Github.

```bash
$ git push origin main
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_00-devise-login_logout-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/08-authentication_i18n/01_00-devise_i18n-it.md)
