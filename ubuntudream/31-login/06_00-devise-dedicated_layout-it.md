# <a name="top"></a> Cap 3.4 - Implementiamo un layout personalizzato per il login

La views di login ha generalmente uno stile diverso dalle altre pagine quindi disponiamo un layout specifico per lei.

Inoltre impostiamo il mockup login.



## Attiviamo i controllers personalizzabili di devise

Attiviamo i **controllers** di devise per il model *User* in modo da poter indicare un **layout specifico** per loro.

> E' arrivato il momento di effettuare il passaggio numero 4 dello script di installazione devise che avevamo lasciato in sospeso.

```bash
$ rails generate devise:views users
$ rails generate devise:controllers users
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream (siso)$rails generate devise:views users
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
ubuntu@ubuntufla:~/ubuntudream (siso)$rails generate devise:controllers users
      create  app/controllers/users/confirmations_controller.rb
      create  app/controllers/users/passwords_controller.rb
      create  app/controllers/users/registrations_controller.rb
      create  app/controllers/users/sessions_controller.rb
      create  app/controllers/users/unlocks_controller.rb
      create  app/controllers/users/omniauth_callbacks_controller.rb
===============================================================================

Some setup you must do manually if you havent yet:

  Ensure you have overridden routes for generated controllers in your routes.rb.
  For example:

    Rails.application.routes.draw do
      devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
    end

===============================================================================
ubuntu@ubuntufla:~/ubuntudream (siso)$
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
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}, controllers: {sessions: 'users/sessions'}
  resources :users
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/04_01-config-routes.rb)



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

Nella cartella *views/layouts* creiamo una nuova view che chiamiamo *entrance* e al suo interno copiamo tutto il codice che al momento è sulla view *edu_demo*.

***codice 02 - .../app/views/layout/entrance.html.erb - line: 1***

```html+erb
<!DOCTYPE html>
<html>
  <head>
    <title>Ubuntudream - Login</title>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/04_02-views-layout-entrance.html.erb)

> Al momento il layout *entrance* è una copia identica del layout *edu_demo* ma andando avanti le due view si differenzieranno. Ad esempio il layout *entrance* non avrà la barra di menu.



## Indichiamo a devise di usare il nuovo layout *entrance*

Per indicare a devise di usare il nostro nuovo layout dobbiamo aggiornare il controller. 
Ed è per questo che precedentemente abbiamo usato `rails generate devise:controllers users`, così adesso abbiamo in chiaro il controller di devise che gestisce il *sign_in/login* e il *sign_out/logout*.

***codice 03 - .../app/controllers/users/sessions_controller.rb - line: 6***

```ruby
  layout 'entrance'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/04_03-controllers-users-sessions_controller.rb)

Aggiungendo `layout 'entrance'` indichiamo a tutte le azioni di *sessions_controller* di usare il nuovo layout. 

> Se lo avessimo voluto usare solo per il *sign_in/login* avremmo decommentato l'azione ***new*** inserendo al suo interno `render layout: 'entrance'`.



## Verifichiamo preview

```bash
$ rails s -b 192.168.64.3
```

- http://192.168.64.3:3000
- http://192.168.64.3:3000/login

> Nella pagina di ***login*** il tab del browser ha il nome "Ubuntudream - Login".



## Inseriamo mockups/login

Implementiamo la pagina di login preparata nel mockup: `views/mockups/login`.
Per prima cosa copiamo tutto il codice del mockup in fondo al codice del form. Poi un po' alla volta sostituiamo i campi del mockup con quelli "attivi" della nostra applicazione.

***code 04 - .../app/views/users/sessions/new.html.erb - line: 1***

```html+erb
<!-- **************** MAIN CONTENT START **************** -->
<main>
	<section class="p-0 d-flex align-items-center position-relative overflow-hidden">
	
		<div class="container-fluid">
			<div class="row">
				<!-- left -->
				<div class="col-12 col-lg-6 d-md-flex align-items-center justify-content-center bg-primary bg-opacity-10 vh-lg-100">
					<div class="p-3 p-lg-5">
						<!-- Title -->
						<div class="text-center">
							<h2 class="fw-bold">Benvenuto a UbuntuDream</h2>
							<p class="mb-0 h6 fw-light">Lavoriamo un po' con la nostra immaginazione ^_^</p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/04_04-views-users-session-new.html.erb)



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "New layout entrance for login"
```




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


## In produzione

Andiamo su render.com e premiamo il bottone ^_^



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/04_00-devise-login_logout-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/08-authentication_i18n/01_00-devise_i18n-it.md)
