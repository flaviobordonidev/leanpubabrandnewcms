# <a name="top"></a> Cap 3.1 - Login con Devise - installazione

Ogni utente ha un *SUO* ambiente di lavoro personalizzato.<br/>
Per far questo dobbiamo *autenticare* l'utente tramite una pagina di *login* che richiede `utente` e `password`. <br/>
Questa autenticazione la gestiamo con la gemma ***devise***.



## Risorse interne

- 99-rails_references/authentication/02-devise



# Risorse esterne

- [l'ultima versione della gemma](https://rubygems.org/gems/devise)
- [tutorial github della gemma](https://github.com/plataformatec/devise)
- [Heroku: using the cli](https://devcenter.heroku.com/articles/using-the-cli)



## Apriamo il branch "Login Devise Install"

```bash
$ git checkout -b ldi
```



## Installiamo la gemma devise

> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/devise)
>
> facciamo riferimento al [tutorial github della gemma](https://github.com/plataformatec/devise)

***codice 01 - .../Gemfile - line:51***

```ruby
# Flexible authentication solution for Rails with Warden 
gem 'devise', '~> 4.8', '>= 4.8.1'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/01_01-Gemfile.rb)


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```



## Lo script

Eseguiamo il `rails generator` per eseguire lo script di installazione di `devise`.

```bash
$ rails g devise:install
```

> E' importante leggere ed eseguire le varie azioni proposte.

Esempio:
  
```ruby
ubuntu@ubuntufla:~/ubuntudream (ldi)$rails g devise:install
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
ubuntu@ubuntufla:~/ubuntudream (ldi)$
```

Completiamo i 4 punti riportati sul testo che appare dopo *devise:install*.



### Punto 1

relativo alla parte di settaggio sia in sviluppo che in produzione.

Lato sviluppo.

***codice 02 - .../config/environments/development.rb - line:44***

```ruby
  # Devise config
  #config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.default_url_options = { host: '192.168.64.3', port: 3000 }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/01_02-config-environments-development.rb)

Lato produzione.<br/>
Dobbiamo trovare l'host del nostro server di produzione (heroku, render.com, ...)

Nel nostro caso è quello di `render.com`.<br/> 

Tutte le applicazioni su render.com sono eseguite su `https://nome_applicazione.onrender.com/`.
Nel nostro caso sarà `https://ubuntudream.onrender.com/` e quindi l'host di produzione sarà: `ubuntudream.onrender.com`

Adesso che abbiamo il nome dell'host su heroku lo possiamo usare nel file di configurazione.

***codice 03 - .../config/environments/production.rb - line:71***

```ruby
  # Devise config
  config.action_mailer.default_url_options = { host: 'ubuntudream.onrender.com', port: 3000 }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/01_03-config-environments-production.rb)

> Attenzione!
> Dobbiamo ricordarci di cambiare questo settaggio quando su render.com punteremo al dominio definitivo.
> (Per dominio definitivo intendiamo quello che compreremo; ad esempio: ubuntudream.com)



### punto 2.

Abbiamo già impostato la *root* sul file *routes* ed al momento la lasciamo così.

***codice 04 - .../config/routes.rb - line:16***

```ruby
  root 'mockups#page_a'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/01_04-config-routes.rb)



### punto 3.

Mettiamo su *layouts/application* la visualizzazione dei messaggi di avviso.

***codice n/a - .../app/views/layouts/application.html.erb - line: 13***

```html+erb
    <p class="notice"><%= notice %></p>
    <p class="alert"><%= alert %></p>
```

miglioriamoli un poco.

***codice n/a - .../app/views/layouts/application.html.erb - line: 14***

```html+erb
    <p class="alert alert-info"><%= notice %></p>
    <p class="alert alert-warning"><%= alert %></p>
```

visualizziamoli solo quando servono

***codice 05 - .../app/views/layouts/application.html.erb - line: 14***

```html+erb
    <% if notice %><p class="alert alert-info"><%= notice %></p><% end %>
    <% if alert %><p class="alert alert-warning"><%= alert %></p><% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/01_05-views-layouts-application.html.erb)

Successivamente implementeremo un partial più completo `<%= render 'layouts/flash_messages' %>` ma per il momento va bene così.



### punto 4.

Nel punto 4 dovremmo copiare le *views* di devise sulla app per permettere la personalizzazione.

> Attenzione!
> Questa operazione la posticipiamo a dopo la creazione della tabella `users`.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Install gem devise"
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/01_00-authentication-devise_install-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/03-user-authentication/02_00-devise-users-seeds-it.md)
