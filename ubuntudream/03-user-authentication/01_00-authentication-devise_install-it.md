# <a name="top"></a> Cap 3.1 - Login con Devise - installazione

Ogni utente ha un *SUO* ambiente di lavoro personalizzato.
Per far questo dobbiamo autenticare l'utente per mezzo di un login con user e password.
Questa autenticazione, ossia il login, lo facciamo usando la gemma ***devise***.



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

***codice 01 - .../Gemfile - line: 51***

```ruby
# Flexible authentication solution for Rails with Warden 
gem 'devise', '~> 4.8', '>= 4.8.1'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_01-Gemfile.rb)


Eseguiamo l'installazione della gemma con bundle

```bash
$ bundle install
```

Esempio:
```bash
ubuntu@ubuntufla:~/bl7_0 (ldi)$bundle install
Fetching gem metadata from https://rubygems.org/..........
Resolving dependencies...
Using rake 13.0.6
Using concurrent-ruby 1.1.9
Using i18n 1.10.0
Using minitest 5.15.0
Using tzinfo 2.0.4
Using activesupport 7.0.2.2
Using builder 3.2.4
Using erubi 1.10.0
Using racc 1.6.0
Using nokogiri 1.13.3 (x86_64-linux)
Using rails-dom-testing 2.0.3
Using crass 1.0.6
Using loofah 2.14.0
Using rails-html-sanitizer 1.4.2
Using actionview 7.0.2.2
Using rack 2.2.3
Using rack-test 1.1.0
Using actionpack 7.0.2.2
Using nio4r 2.5.8
Using websocket-extensions 0.1.5
Using websocket-driver 0.7.5
Using actioncable 7.0.2.2
Using globalid 1.0.0
Using activejob 7.0.2.2
Using activemodel 7.0.2.2
Using activerecord 7.0.2.2
Using marcel 1.0.2
Using mini_mime 1.1.2
Using activestorage 7.0.2.2
Using mail 2.7.1
Using digest 3.1.0
Using io-wait 0.2.1
Using timeout 0.2.0
Using net-protocol 0.1.2
Using strscan 3.0.1
Using net-imap 0.2.3
Using net-pop 0.1.1
Using net-smtp 0.3.1
Using actionmailbox 7.0.2.2
Using actionmailer 7.0.2.2
Using actiontext 7.0.2.2
Using public_suffix 4.0.6
Using addressable 2.8.0
Fetching bcrypt 3.1.16
Installing bcrypt 3.1.16 with native extensions
Using bindex 0.8.1
Using msgpack 1.4.5
Using bootsnap 1.10.3
Using bundler 2.3.7
Using matrix 0.4.2
Using regexp_parser 2.2.1
Using xpath 3.2.0
Using capybara 3.36.0
Using childprocess 4.1.0
Using io-console 0.5.11
Using reline 0.3.1
Using irb 1.4.1
Using debug 1.4.0
Fetching orm_adapter 0.5.0
Installing orm_adapter 0.5.0
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.5.4
Using railties 7.0.2.2
Fetching responders 3.0.1
Installing responders 3.0.1
Fetching warden 1.2.9
Installing warden 1.2.9
Fetching devise 4.8.1
Installing devise 4.8.1
Using importmap-rails 1.0.3
Using jbuilder 2.11.5
Using pg 1.3.3
Using puma 5.6.2
Using rails 7.0.2.2
Using rexml 3.2.5
Using rubyzip 2.3.2
Using selenium-webdriver 4.1.0
Using sprockets 4.0.3
Using sprockets-rails 3.4.2
Using stimulus-rails 1.0.4
Using turbo-rails 1.0.1
Using web-console 4.2.0
Using webdrivers 5.0.0
Bundle complete! 16 Gemfile dependencies, 79 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
ubuntu@ubuntufla:~/bl7_0 (ldi)$
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
ubuntu@ubuntufla:~/bl7_0 (ldi)$rails g devise:install
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
===============================================================================

Depending on your applications configuration some manual setup may be required:

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
ubuntu@ubuntufla:~/bl7_0 (ldi)$
```

Completiamo i 4 punti riportati sul testo che appare dopo *devise:install*.



### Punto 1

relativo alla parte di settaggio sia in sviluppo che in produzione.

***codice 02 - .../config/environments/development.rb - line: 44***

```ruby
  # Devise config
  #config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.default_url_options = { host: '192.168.64.3', port: 3000 }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_02-config-environments-development.rb)

Nel prossimo passaggio dobbiamo mettere l'host di produzione. Nel nostro caso quello di heroku. 
Per trovare il nome host su heroku usiamo il comando:

```bash
$ heroku domains
```

Esempio:
  
```bash
user_fb:~/environment/bl7_0 (ldi) $ heroku domains
=== bl7-0 Heroku Domain
bl7-0.herokuapp.com
user_fb:~/environment/bl7_0 (ldi) $
```

Adesso che abbiamo il nome dell'host su heroku lo possiamo usare nel file di configurazione.

***codice 03 - .../config/environments/production.rb - line: 71***

```ruby
  # Devise config
  config.action_mailer.default_url_options = { host: 'bl7-0.herokuapp.com', port: 3000 }
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_03-config-environments-production.rb)

> Attenzione!
> Dobbiamo ricordarci di cambiare questo settaggio quando su Heroku punteremo al dominio definitivo. 
> (https://devcenter.heroku.com/articles/using-the-cli).



### punto 2.

Abbiamo già impostato la *root* sul file *routes* ed al momento la lasciamo così.

***codice 04 - .../config/routes.rb - line: 8***

```ruby
  root 'mockups#page_a'
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_04-config-routes.rb)



### punto 3.

Mettiamo su *layouts/application* la visualizzazione dei messaggi di avviso.

***codice 05 - .../app/views/layouts/application.html.erb - line: 13***

```html+erb
    <p class="notice"><%= notice %></p>
    <p class="alert"><%= alert %></p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_05-views-layouts-application.html.erb)

miglioriamoli un poco, quando installeremo bootstrap saranno ancora meglio.

***codice 06 - .../app/views/layouts/application.html.erb - line: 14***

```html+erb
    <p class="alert alert-info"><%= notice %></p>
    <p class="alert alert-warning"><%= alert %></p>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_06-views-layouts-application.html.erb)

visualizziamoli solo quando servono

***codice 07 - .../app/views/layouts/application.html.erb - line: 14***

```html+erb
    <% if notice %><p class="alert alert-info"><%= notice %></p><% end %>
    <% if alert %><p class="alert alert-warning"><%= alert %></p><% end %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/02_07-views-layouts-application.html.erb)

Successivamente implementeremo un partial più completo **<%= render 'layouts/flash_messages' %>** ma per il momento va bene così.



### punto 4.

Copiamo le *views* di devise sulla app per permettere la personalizzazione.

> Attenzione!
> Questa operazione la posticipiamo a dopo la creazione della tabella *users*.



## Archiviamo su git

```bash
$ git add -A
$ git commit -m "Install gem devise"
```



## Pubblichiamo su Heroku

```bash
$ git push heroku ldi:main
$ heroku run rails db:migrate
```

> Possiamo anche non eseguire `$ heroku run rails db:migrate` perché non tocchiamo il database



## Chiudiamo il branch

Lo chiudiamo in seguito



## Facciamo un backup su Github

Lo facciamo in seguito. Dopo la chiusura del branch.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/01_00-devise_story-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/07-authentication/03_00-devise-users-seeds-it.md)
