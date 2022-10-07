# <a name="top"></a> Cap 1.1 - Nuova app rails

Creiamo la nuova applicazione Ubuntudream.



## Risorse interne

- [code_references/new_rails_app]()



## Risorse esterne

- [Getting Started with Ruby on Rails on Render](https://render.com/docs/deploy-rails)



## Creiamo l'applicazione

In produzione Render utilizza postgreSQL quindi lo installiamo anche localmente.
Un'alternativa era quella di caricare la gemma "pg" solo per l'ambiente di produzione. Ma è preferibile usare nell'ambiente di sviluppo le stesse risorse usate in produzione.

```bash
$ cd ~/
$ rails --version
$ rails new ubuntudream --database=postgresql
```

> Possiamo gestire postgreSQL localmente nell'ambiente di sviluppo e test perché lo abbiamo già installato nei capitoli precedenti. Dobbiamo solo farlo partire. 

Esempio:

```bash
ubuntu@ubuntufla:~ $cd ~/
ubuntu@ubuntufla:~ $ls
bl7_0  eduport  instaclone  prorb_db_queries  simple_blog
ubuntu@ubuntufla:~ $rails --version
Rails 7.0.3.1
ubuntu@ubuntufla:~ $rails new ubuntudream --database=postgresql
      create  
      create  README.md
      create  Rakefile
      create  .ruby-version
      create  config.ru
      create  .gitignore
      create  .gitattributes
      create  Gemfile
         run  git init from "."
Initialized empty Git repository in /home/ubuntu/ubuntudream/.git/
      create  app
      create  app/assets/config/manifest.js
      create  app/assets/stylesheets/application.css
      create  app/channels/application_cable/channel.rb
      create  app/channels/application_cable/connection.rb
      create  app/controllers/application_controller.rb
      create  app/helpers/application_helper.rb
      create  app/jobs/application_job.rb
      create  app/mailers/application_mailer.rb
      create  app/models/application_record.rb
      create  app/views/layouts/application.html.erb
      create  app/views/layouts/mailer.html.erb
      create  app/views/layouts/mailer.text.erb
      create  app/assets/images
      create  app/assets/images/.keep
      create  app/controllers/concerns/.keep
      create  app/models/concerns/.keep
      create  bin
      create  bin/rails
      create  bin/rake
      create  bin/setup
      create  config
      create  config/routes.rb
      create  config/application.rb
      create  config/environment.rb
      create  config/cable.yml
      create  config/puma.rb
      create  config/storage.yml
      create  config/environments
      create  config/environments/development.rb
      create  config/environments/production.rb
      create  config/environments/test.rb
      create  config/initializers
      create  config/initializers/assets.rb
      create  config/initializers/content_security_policy.rb
      create  config/initializers/cors.rb
      create  config/initializers/filter_parameter_logging.rb
      create  config/initializers/inflections.rb
      create  config/initializers/new_framework_defaults_7_0.rb
      create  config/initializers/permissions_policy.rb
      create  config/locales
      create  config/locales/en.yml
      create  config/master.key
      append  .gitignore
      create  config/boot.rb
      create  config/database.yml
      create  db
      create  db/seeds.rb
      create  lib
      create  lib/tasks
      create  lib/tasks/.keep
      create  lib/assets
      create  lib/assets/.keep
      create  log
      create  log/.keep
      create  public
      create  public/404.html
      create  public/422.html
      create  public/500.html
      create  public/apple-touch-icon-precomposed.png
      create  public/apple-touch-icon.png
      create  public/favicon.ico
      create  public/robots.txt
      create  tmp
      create  tmp/.keep
      create  tmp/pids
      create  tmp/pids/.keep
      create  tmp/cache
      create  tmp/cache/assets
      create  vendor
      create  vendor/.keep
      create  test/fixtures/files
      create  test/fixtures/files/.keep
      create  test/controllers
      create  test/controllers/.keep
      create  test/mailers
      create  test/mailers/.keep
      create  test/models
      create  test/models/.keep
      create  test/helpers
      create  test/helpers/.keep
      create  test/integration
      create  test/integration/.keep
      create  test/channels/application_cable/connection_test.rb
      create  test/test_helper.rb
      create  test/system
      create  test/system/.keep
      create  test/application_system_test_case.rb
      create  storage
      create  storage/.keep
      create  tmp/storage
      create  tmp/storage/.keep
      remove  config/initializers/cors.rb
      remove  config/initializers/new_framework_defaults_7_0.rb
         run  bundle install
Fetching gem metadata from https://rubygems.org/...........
Resolving dependencies.......
Using rake 13.0.6
Using concurrent-ruby 1.1.10
Using i18n 1.12.0
Using minitest 5.16.3
Using tzinfo 2.0.5
Fetching activesupport 7.0.4
Installing activesupport 7.0.4
Using builder 3.2.4
Using erubi 1.11.0
Using racc 1.6.0
Using nokogiri 1.13.8 (x86_64-linux)
Using rails-dom-testing 2.0.3
Using crass 1.0.6
Using loofah 2.19.0
Using rails-html-sanitizer 1.4.3
Fetching actionview 7.0.4
Installing actionview 7.0.4
Using rack 2.2.4
Using rack-test 2.0.2
Fetching actionpack 7.0.4
Installing actionpack 7.0.4
Using nio4r 2.5.8
Using websocket-extensions 0.1.5
Using websocket-driver 0.7.5
Fetching actioncable 7.0.4
Installing actioncable 7.0.4
Using globalid 1.0.0
Fetching activejob 7.0.4
Installing activejob 7.0.4
Fetching activemodel 7.0.4
Installing activemodel 7.0.4
Fetching activerecord 7.0.4
Installing activerecord 7.0.4
Using marcel 1.0.2
Using mini_mime 1.1.2
Fetching activestorage 7.0.4
Installing activestorage 7.0.4
Using mail 2.7.1
Using digest 3.1.0
Using timeout 0.3.0
Using net-protocol 0.1.3
Using strscan 3.0.4
Using net-imap 0.2.3
Using net-pop 0.1.1
Using net-smtp 0.3.1
Fetching actionmailbox 7.0.4
Installing actionmailbox 7.0.4
Fetching actionmailer 7.0.4
Installing actionmailer 7.0.4
Fetching actiontext 7.0.4
Installing actiontext 7.0.4
Using public_suffix 5.0.0
Using addressable 2.8.1
Using bindex 0.8.1
Using msgpack 1.5.6
Using bootsnap 1.13.0
Using bundler 2.3.12
Using matrix 0.4.2
Using regexp_parser 2.5.0
Using xpath 3.2.0
Using capybara 3.37.1
Using childprocess 4.1.0
Using io-console 0.5.11
Using reline 0.3.1
Using irb 1.4.1
Fetching debug 1.6.2
Installing debug 1.6.2 with native extensions
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.6.0
Fetching railties 7.0.4
Installing railties 7.0.4
Using importmap-rails 1.1.5
Using jbuilder 2.11.5
Using pg 1.4.3
Fetching puma 5.6.5
Installing puma 5.6.5 with native extensions
Fetching rails 7.0.4
Installing rails 7.0.4
Using rexml 3.2.5
Using rubyzip 2.3.2
Using websocket 1.2.9
Using selenium-webdriver 4.4.0
Using sprockets 4.1.1
Using sprockets-rails 3.4.2
Using stimulus-rails 1.1.0
Using turbo-rails 1.1.1
Using web-console 4.2.0
Using webdrivers 5.0.0
Bundle complete! 15 Gemfile dependencies, 74 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
         run  bundle binstubs bundler
       rails  importmap:install
Add Importmap include tags in application layout
      insert  app/views/layouts/application.html.erb
Create application.js module as entrypoint
      create  app/javascript/application.js
Use vendor/javascript for downloaded pins
      create  vendor/javascript
      create  vendor/javascript/.keep
Ensure JavaScript files are in the Sprocket manifest
      append  app/assets/config/manifest.js
Configure importmap paths in config/importmap.rb
      create  config/importmap.rb
Copying binstub
      create  bin/importmap
       rails  turbo:install stimulus:install
Import Turbo
      append  app/javascript/application.js
Pin Turbo
      append  config/importmap.rb
Enable redis in bundle
        gsub  Gemfile
         run  bundle install
Fetching gem metadata from https://rubygems.org/..........
Resolving dependencies...
Using rake 13.0.6
Using concurrent-ruby 1.1.10
Using i18n 1.12.0
Using minitest 5.16.3
Using tzinfo 2.0.5
Using activesupport 7.0.4
Using builder 3.2.4
Using erubi 1.11.0
Using racc 1.6.0
Using nokogiri 1.13.8 (x86_64-linux)
Using rails-dom-testing 2.0.3
Using crass 1.0.6
Using loofah 2.19.0
Using rails-html-sanitizer 1.4.3
Using actionview 7.0.4
Using rack 2.2.4
Using rack-test 2.0.2
Using actionpack 7.0.4
Using nio4r 2.5.8
Using websocket-extensions 0.1.5
Using websocket-driver 0.7.5
Using actioncable 7.0.4
Using globalid 1.0.0
Using activejob 7.0.4
Using activemodel 7.0.4
Using activerecord 7.0.4
Using marcel 1.0.2
Using mini_mime 1.1.2
Using activestorage 7.0.4
Using mail 2.7.1
Using digest 3.1.0
Using timeout 0.3.0
Using net-protocol 0.1.3
Using strscan 3.0.4
Using net-imap 0.2.3
Using net-pop 0.1.1
Using net-smtp 0.3.1
Using actionmailbox 7.0.4
Using actionmailer 7.0.4
Using actiontext 7.0.4
Using public_suffix 5.0.0
Using addressable 2.8.1
Using bindex 0.8.1
Using msgpack 1.5.6
Using bootsnap 1.13.0
Using bundler 2.3.12
Using matrix 0.4.2
Using regexp_parser 2.5.0
Using xpath 3.2.0
Using capybara 3.37.1
Using childprocess 4.1.0
Using io-console 0.5.11
Using reline 0.3.1
Using irb 1.4.1
Using debug 1.6.2
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.6.0
Using railties 7.0.4
Using importmap-rails 1.1.5
Using jbuilder 2.11.5
Using pg 1.4.3
Using puma 5.6.5
Using rails 7.0.4
Using redis 4.8.0
Using rexml 3.2.5
Using rubyzip 2.3.2
Using websocket 1.2.9
Using selenium-webdriver 4.4.0
Using sprockets 4.1.1
Using sprockets-rails 3.4.2
Using stimulus-rails 1.1.0
Using turbo-rails 1.1.1
Using web-console 4.2.0
Using webdrivers 5.0.0
Bundle complete! 16 Gemfile dependencies, 75 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
Switch development cable to use redis
        gsub  config/cable.yml
Create controllers directory
      create  app/javascript/controllers
      create  app/javascript/controllers/index.js
      create  app/javascript/controllers/application.js
      create  app/javascript/controllers/hello_controller.js
Import Stimulus controllers
      append  app/javascript/application.js
Pin Stimulus
Appending: pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true"
      append  config/importmap.rb
Appending: pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
      append  config/importmap.rb
Pin all controllers
Appending: pin_all_from "app/javascript/controllers", under: "controllers"
      append  config/importmap.rb
ubuntu@ubuntufla:~ $
```

> Siccome nelle precedenti app abbiamo installato `redis` nella VM (virtual machine) Ubuntu multipass, nell'installazione di una nuova app lo configura e fa anche lo *Switch development cable to use redis*.

> Oppure è semplicemente dovuto alla nuova versione di Rails ^_^



## Verifichiamo quanto spazio disco ci resta

```bash
$ df -hT /dev/vda1
```

Esempio:

```bash
ubuntu@ubuntufla:~ $df -hT /dev/vda1
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/vda1      ext4   20G  7.2G   13G  38% /
```

Abbiamo ancora **13GB** disponibili.



## Apriamo l'applicazione localmente

Per aprire la nuova applicazione entriamo nella cartella e facciamo partire il web server

```bash
$ cd ubuntudream
$ rails s -b 192.168.64.3
```

Abbiamo un errore di connessione al database che non esiste.

```
ActiveRecord::NoDatabaseError
We could not find your database: ubuntudream_development. Which can be found in the database configuration file located at config/database.yml.
To resolve this issue:
- Did you create the database for this app, or delete it? You may need to create your database.
- Has the database name changed? Check your database.yml config has the correct database name.
To create your database, run:
bin/rails db:create
```

Lo risolviamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/05_00-authorization-more_roles-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/02_00-eg_posts_pagination-it.md)
