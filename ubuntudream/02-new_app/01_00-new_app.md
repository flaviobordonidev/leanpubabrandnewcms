# <a name="top"></a> Cap 2.1 - Nuova app rails

Creiamo la nuova applicazione Ubuntudream.



## Risorse interne

- [code_references/new_rails_app]()



## Creiamo una nuova applicazione Rails con database postgreSQL

La installiamo includendo da subito il database postgreSQL perché è quello che abbiamo in produzione su Render.

> Attenzione!
> Se creo una nuova applicazione con l'opzione `--database=postgresql` devo installare prima `sudo apt install libpq-dev`.

```shell
$ cd ~
$ rails --version
# installiamo la libreria postgreSQL di sviluppo
$ sudo apt install libpq-dev
# creiamo la nuova applicazione Rails con il database postgreSQL
$ rails new ubuntudream --database=postgresql
```

Esempio:

```shell
ubuntu@ub22fla:~$ cd ~
ubuntu@ub22fla:~$ pwd
/home/ubuntu
ubuntu@ub22fla:~$ rails --version
Rails 7.1.3

ubuntu@ub22fla:~$ sudo apt install libpq-dev
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Suggested packages:
  postgresql-doc-16
The following NEW packages will be installed:
  libpq-dev
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 138 kB of archives.
After this operation, 592 kB of additional disk space will be used.
Get:1 https://apt.postgresql.org/pub/repos/apt jammy-pgdg/main arm64 libpq-dev arm64 16.1-1.pgdg22.04+1 [138 kB]
Fetched 138 kB in 2s (65.9 kB/s)     
Selecting previously unselected package libpq-dev.
(Reading database ... 80334 files and directories currently installed.)
Preparing to unpack .../libpq-dev_16.1-1.pgdg22.04+1_arm64.deb ...
Unpacking libpq-dev (16.1-1.pgdg22.04+1) ...
Setting up libpq-dev (16.1-1.pgdg22.04+1) ...
Processing triggers for man-db (2.10.2-1) ...
Scanning processes...                                
Scanning linux images...                                              
Running kernel seems to be up-to-date.
No services need to be restarted.
No containers need to be restarted.
No user sessions are running outdated binaries.
No VM guests are running outdated hypervisor (qemu) binaries on this host.

ubuntu@ub22fla:~$ rails new ubuntudream --database=postgresql
      create  
      create  README.md
      create  Rakefile
      create  .ruby-version
      create  config.ru
      create  .gitignore
      create  .gitattributes
      create  Gemfile
         run  git init -b main from "."
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
      create  Dockerfile
      create  .dockerignore
      create  bin/docker-entrypoint
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
      create  config/initializers/new_framework_defaults_7_1.rb
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
      remove  config/initializers/new_framework_defaults_7_1.rb
         run  bundle install
Fetching gem metadata from https://rubygems.org/...........
Resolving dependencies...
Installing pg 1.5.4 with native extensions
Bundle complete! 14 Gemfile dependencies, 82 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
         run  bundle lock --add-platform=x86_64-linux
Writing lockfile to /home/ubuntu/ubuntudream/Gemfile.lock
         run  bundle binstubs bundler
       rails  importmap:install
       apply  /home/ubuntu/.rvm/gems/ruby-3.3.0/gems/importmap-rails-2.0.1/lib/install/install.rb
  Add Importmap include tags in application layout
      insert    app/views/layouts/application.html.erb
  Create application.js module as entrypoint
      create    app/javascript/application.js
  Use vendor/javascript for downloaded pins
      create    vendor/javascript
      create    vendor/javascript/.keep
  Ensure JavaScript files are in the Sprocket manifest
      append    app/assets/config/manifest.js
  Configure importmap paths in config/importmap.rb
      create    config/importmap.rb
  Copying binstub
      create    bin/importmap
         run  bundle install
Bundle complete! 14 Gemfile dependencies, 82 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
       rails  turbo:install stimulus:install
       apply  /home/ubuntu/.rvm/gems/ruby-3.3.0/gems/turbo-rails-1.5.0/lib/install/turbo_with_importmap.rb
  Import Turbo
      append    app/javascript/application.js
  Pin Turbo
      append    config/importmap.rb
         run  bundle install
Bundle complete! 14 Gemfile dependencies, 82 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
Run turbo:install:redis to switch on Redis and use it in development for turbo streams
       apply  /home/ubuntu/.rvm/gems/ruby-3.3.0/gems/stimulus-rails-1.3.3/lib/install/stimulus_with_importmap.rb
  Create controllers directory
      create    app/javascript/controllers
      create    app/javascript/controllers/index.js
      create    app/javascript/controllers/application.js
      create    app/javascript/controllers/hello_controller.js
  Import Stimulus controllers
      append    app/javascript/application.js
  Pin Stimulus
  Appending: pin "@hotwired/stimulus", to: "stimulus.min.js"
      append    config/importmap.rb
  Appending: pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
      append    config/importmap.rb
  Pin all controllers
  Appending: pin_all_from "app/javascript/controllers", under: "controllers"
      append    config/importmap.rb
         run  bundle install
Bundle complete! 14 Gemfile dependencies, 82 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
ubuntu@ub22fla:~$ 
```



## Verifichiamo quanto spazio disco ci resta

```bash
$ df -hT /dev/sda1
```

Esempio:

```bash
ubuntu@ub22fla:~$ df -hT /dev/sda1
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/sda1      ext4   20G  3.4G   16G  18% /
```

Abbiamo ancora **16GB** disponibili.



## Apriamo l'applicazione localmente

Per aprire la nuova applicazione entriamo nella cartella e facciamo partire il web server

```bash
$ cd ubuntudream
$ rails s -b 192.168.64.4
```

Abbiamo un errore di connessione al database che non esiste.

```shell
ActiveRecord::NoDatabaseError
We could not find your database: ubuntudream_development. Which can be found in the database configuration file located at config/database.yml.
To resolve this issue:
- Did you create the database for this app, or delete it? You may need to create your database.
- Has the database name changed? Check your database.yml config has the correct database name.
To create your database, run:
bin/rails db:create
```

Il web server potrebbe anche partire.
In quel caso vedremo l'errore aprendo la nostra app dal browser, inserendo nell'url:

- http://192.168.64.4:3000/

```shell
ActiveRecord::NoDatabaseError
We could not find your database: ubuntudream_development. Available database configurations can be found in config/database.yml.
To resolve this error:
- Did you not create the database, or did you delete it? To create the database, run:
bin/rails db:create
- Has the database name changed? Verify that config/database.yml contains the correct database name.
Create database
```

Lo risolviamo nel prossimo capitolo.



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/05_00-authorization-more_roles-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/02_00-eg_posts_pagination-it.md)
