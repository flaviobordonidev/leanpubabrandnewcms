# <a name="top"></a> Cap 1.1 - New app Instaclone

Tratto da mix_and_go. Un clone di instagram



## Risorse interne



## Risorse esterne

- [L3: Hotwire - Planning](https://school.mixandgo.com/targets/262)
- [L3: Hotwire - Authentication with Devise](https://school.mixandgo.com/targets/261)
- [L3: Hotwire - Adding sign in / sign out links](https://school.mixandgo.com/targets/263)



## Creiamo una nuova app

```bash
$ rails new instaclone
$ cd instaclone
```


## Progettiamo la nuova app

Vogliamo fare un'app che assomiglia ad instagram. Disegnamo come l'immaginiamo.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/01_fig01-planning_sketch.png)



## Installiamo la gemma `devise`

Installiamo la gemma `devise` senza passare per il file "Gemfile" ma diamo il comando direttamente da bash.

```bash
$ bundle add devise
```

Con devise abbiamo quattro nuovi "rails generate"

- rails generate devise
- rails generate devise:controllers
- rails generate devise:install
- rails generate devise:views


Vediamo tutti i "generate" possibili:

```bash
$ rails generate

ubuntu@ubuntufla:~/hotwireexample $rails generate
Usage: rails generate GENERATOR [args] [options]

General options:
  -h, [--help]     # Print generator's options and usage
  -p, [--pretend]  # Run but do not make any changes
  -f, [--force]    # Overwrite files that already exist
  -s, [--skip]     # Skip files that already exist
  -q, [--quiet]    # Suppress status output

Please choose a generator below.

Rails:
  application_record
  benchmark
  channel
  controller
  generator
  helper
  integration_test
  jbuilder
  job
  mailbox
  mailer
  migration
  model
  resource
  responders_controller
  scaffold
  scaffold_controller
  system_test
  task

ActiveRecord:
  active_record:application_record
  active_record:devise
  active_record:multi_db

Devise:
  devise
  devise:controllers
  devise:install
  devise:views

Mongoid:
  mongoid:devise

Responders:
  responders:install

Stimulus:
  stimulus

TestUnit:
  test_unit:channel
  test_unit:generator
  test_unit:install
  test_unit:mailbox
  test_unit:plugin

ubuntu@ubuntufla:~/hotwireexample $
```

Usiamo il "generate devise:install" per impostare le configurazioni iniziali 

```bash
$ rails g devise:install
```

Esempio:

```bash
ubuntu@ubuntufla:~/hotwireexample $rails g devise:install
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
===============================================================================

Depending on your application configuration some manual setup may be required:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

     * Required for all applications. *

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"
     
     * Not required for API-only Applications *

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

     * Not required for API-only Applications *

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views
       
     * Not required *

===============================================================================
ubuntu@ubuntufla:~/hotwireexample $
```



## Completiamo configurazione di devise

Seguiamo le istruzioni.
Il passo 1

***code: 01 - .../config/environments/development.rb - line:44***

```ruby
  # requested by device
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/01_01-config-environments-development.rb)


Il passo 2

***code: 02 - .../config/routes.rb - line:5***

```ruby
   root "site#index"
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/01_02-config-routes.rb)


Il passo 3

***code: 03 - .../views/layouts/application.html.erb - line:5***

```html+erb
    <p class="notice"><%= notice %></p>
    <p class="alert"><%= alert %></p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/01_03-views-layouts-application.html.erb)


Il passo 4 è opzionale ma lo facciamo.
Serve per poter personalizzare i templates / le views con cui viene devise.

> Attenzione! questo passaggio può essere più utile posticiparlo come abbiamo visto nel libro "01-base".
> Ma per instaclone possiamo effettuarlo subito.

```bash
$ rails g devise:views
```




## Creiamo il "devise model"

Usiamo il "generate devise". Vediamo tutte le opzioni:

```bash
ubuntu@ubuntufla:~/hotwireexample $rails g devise
Usage:
  rails generate devise NAME [options]

Options:
      [--skip-namespace], [--no-skip-namespace]              # Skip namespace (affects only isolated engines)
      [--skip-collision-check], [--no-skip-collision-check]  # Skip collision check
      [--force-plural], [--no-force-plural]                  # Forces the use of the given model name
      [--model-name=MODEL_NAME]                              # ModelName to be used
  -o, --orm=NAME                                             # Orm to be invoked
                                                             # Default: active_record
      [--routes], [--no-routes]                              # Generate routes
                                                             # Default: true

ActiveRecord options:
  [--primary-key-type=PRIMARY_KEY_TYPE]  # The type for primary key

Runtime options:
  -f, [--force]                    # Overwrite files that already exist
  -p, [--pretend], [--no-pretend]  # Run but do not make any changes
  -q, [--quiet], [--no-quiet]      # Suppress status output
  -s, [--skip], [--no-skip]        # Skip files that already exist

Generates a model with the given NAME (if one does not exist) with devise configuration plus a migration file and devise routes.
ubuntu@ubuntufla:~/hotwireexample $
```

Creiamo il "devise model" User

```bash
$ rails g devise User
```

Eseguiamo il migrate


```bash
$ rails db:migrate
```

Su routes si è aggiunta la riga `devise_for :users`. Vediamo i nuovi paths:

```bash
$ rails routes | grep devise

ubuntu@ubuntufla:~/instaclone $rails routes | grep devise
          new_user_session GET      /users/sign_in(.:format)            devise/sessions#new
              user_session POST     /users/sign_in(.:format)            devise/sessions#create
      destroy_user_session DELETE   /users/sign_out(.:format)           devise/sessions#destroy
          new_user_password GET     /users/password/new(.:format)       devise/passwords#new
        edit_user_password GET      /users/password/edit(.:format)      devise/passwords#edit
              user_password PATCH   /users/password(.:format)           devise/passwords#update
                            PUT     /users/password(.:format)           devise/passwords#update
                            POST    /users/password(.:format)           devise/passwords#create
  cancel_user_registration GET      /users/cancel(.:format)             devise/registrations#cancel
      new_user_registration GET     /users/sign_up(.:format)            devise/registrations#new
    edit_user_registration GET      /users/edit(.:format)               devise/registrations#edit
          user_registration PATCH   /users(.:format)                    devise/registrations#update
                            PUT     /users(.:format)                    devise/registrations#update
                            DELETE  /users(.:format)                    devise/registrations#destroy
                            POST    /users(.:format)                    devise/registrations#create
ubuntu@ubuntufla:~/instaclone $
```



## Creiamo il site_controller e relativa view

Creiamo direttamente i files.

***code 04 - .../app/controllers/site_controller.rb - line:1***

```ruby
class SiteController < ApplicationController
  def index; end
end
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/01_04-controllers-site_controller.rb)


***code 05 - .../app/views/site/index.html.erb - line:1***

```html+erb
Welcome
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/instaclone/01-new_app/01_05-views-site-index.html.erb)



## Aggiungiamo utente da web gui

Facciamo partire il server

```bash
$ rails s -b 192.168.64.3
```

Ed andiamo all'url `http://192.168.64.3:3000/users/sign_up` per aggiungere un nuovo utente.

Lo aggiungiamo e riceviamo un errore.

```
NoMethodError in Devise::RegistrationsController#create
undefined method `user_url' for #<Devise::RegistrationsController:0x0000000000c0a8>
Extracted source (around line #231):

            if options.empty?
              recipient.public_send(method, *args)
            else
              recipient.public_send(method, *args, options)
            end
```

Questo è un errore causato da hotwire perché hotwire di default rende tutte le "form submission" con turbo streams, e devise non lo supporta.



## Rendiamo devise compatibile con hotwire

Lo facciamo aggiungentolo nei `navigational_formats`

***code 06 - .../config/initializer/deivse.rb - line:267***

```ruby
  config.navigational_formats = ['*/*', :html, :turbo_stream]
```

Se adesso riproviamo ad aggiungere un nuovo utente da web gui funziona!

> Nota: l'utente era stato comunque creato. Se vuoi usare lo stesso devi cancellarlo da `rails c` con `User.destroy_all`.


Adesso l'applicazione è pronta. Nei prossimi capitoli faremo degli esempi con hotwire.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/08_00-gemfile_ruby_version.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/02-git/02_00-inizializziamo_git.md)
