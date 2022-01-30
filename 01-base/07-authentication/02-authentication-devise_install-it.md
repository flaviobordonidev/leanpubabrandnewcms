# <a name="top"></a> Cap 7.2 - Login con Devise - installazione

Implementiamo la parte di autenticazione, ossia la parte di login, con la gemma ***devise***.
Aggiungiamo la gemma ***devise*** alla nostra applicazione per implementare la parte di autenticazione.
Devise permette di autenticare l'utente per mezzo di un login con user e password. 
Un utente si logga per avere il *SUO* ambiente di lavoro personalizzato.



## Risorse interne

- 99-rails_references/authentication/02-devise



# Risorse esterne

- [l'ultima versione della gemma](https://rubygems.org/gems/devise)
- [tutorial github della gemma](https://github.com/plataformatec/devise)



## Apriamo il branch "Login Devise Install"

```bash
$ git checkout -b ldi
```



## Installiamo la gemma devise

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/devise)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/plataformatec/devise)

***codice 01 - .../Gemfile - line: 31***

```ruby
# Flexible authentication solution for Rails with Warden 
gem 'devise', '~> 4.7', '>= 4.7.1'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_01-Gemfile.rb)

Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Lo script

Eseguiamo lo script di installazione di devise su rails (anche noto con il nome di *generator*).
Il *generator* installerà un inizializzatore che descrive tutte le opzioni di configurazione di Devise. 
E' importante leggere e seguire le varie azioni proposte.

```bash
$ rails g devise:install
```

Esempio:
  
```bash
ec2-user:~/environment/myapp (ldi) $ rails g devise:install
Running via Spring preloader in process 8570
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================
```

Completiamo i 4 punti riportati sul testo che appare dopo *devise:install*.



### Punto 1

relativo alla parte di settaggio sia in sviluppo che in produzione.

***codice 02 - .../config/environments/development.rb - line: 39***

```ruby
  # Devise config
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_02-config-environments-development.rb)

Nel prossimo passaggio dobbiamo mettere l'host di produzione. Nel nostro caso quello di heroku. 
Per trovare il nome host su heroku usiamo il comando:

```bash
$ heroku domains
```

Esempio:
  
```bash
user_fb:~/environment/bl6_0 (ldi) $ heroku domains
=== bl6-0 Heroku Domain
bl6-0.herokuapp.com
```

Adesso che abbiamo il nome dell'host su heroku lo possiamo usare nel file di configurazione.

***codice 03 - .../config/environments/production.rb - line: 69***

```ruby
  # Devise config
  config.action_mailer.default_url_options = { host: 'bl6-0.herokuapp.com', port: 3000 }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_03-config-environments-production.rb)

> Attenzione!
>
> Dobbiamo ricordarci di cambiare questo settaggio quando su Heroku punteremo al dominio definitivo. 
>
> (https://devcenter.heroku.com/articles/using-the-cli).



### punto 2.

Abbiamo già impostato la root sul root file e per il momento lo lasciamo così.

***codice 04 - .../config/routes.rb - line: 3***

```ruby
  root 'mockups#page_a'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_04-config-routes.rb)



### punto 3.

Mettiamo su layouts/application la visualizzazione dei messaggi di avviso

***codice 05 - .../app/views/layouts/application.html.erb - line: 13***

```html+erb
    <p class="notice"><%= notice %></p>
    <p class="alert"><%= alert %></p>
```

miglioriamoli un poco, quando installeremo bootstrap saranno ancora meglio.

***codice 05 - .../app/views/layouts/application.html.erb - line: 13***

```html+erb
    <p class="alert alert-info"><%= notice %></p>
    <p class="alert alert-warning"><%= alert %></p>
```

visualizziamoli solo quando servono

***codice 05 - .../app/views/layouts/application.html.erb - line: 13***

```html+erb
    <% if notice %><p class="alert alert-info"><%= notice %></p><% end %>
    <% if alert %><p class="alert alert-warning"><%= alert %></p><% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_05-views-layouts-application.html.erb)

Successivamente implementeremo un partial più completo **<%= render 'layouts/flash_messages' %>** ma per il momento va bene così.



### punto 4.

Copiamo le views di devise sulla app per permettere la personalizzazione.
Questa operazione la posticipiamo a dopo la creazione della tabella *users*.



## archiviamo su git

```bash
$ git add -A
$ git commit -m "Install gem devise"
```



## Chiudiamo il branch

Lo chiudiamo in seguito



## Facciamo un backup su Github

Lo facciamo in seguito. Dopo la chiusura del branch.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/01-devise_story-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/03-devise-users-seeds-it.md)
