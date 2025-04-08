# <a name="top"></a> Cap 2.1 - Nuova app rails

Creiamo la nuova applicazione Ubuntudream.



## Risorse interne

- [code_references/new_rails_app]()



## Creiamo una nuova applicazione Rails con database postgreSQL

La installiamo includendo da subito il database postgreSQL perché è quello che abbiamo in produzione su Render.

```shell
$ cd ~
# creiamo la nuova applicazione Rails con il database postgreSQL
$ rails new ubuntudreamfive -a propshaft --database=postgresql 
```

> Attenzione!
> Affinché funzioni l'opzione `--database=postgresql` deve essere installata la libreria libpq-dev: `sudo apt install libpq-dev`.

> l'opzione `-a propshaft` installa il nuovo gestore dell'asset-pipeline `propshaft` al posto di sprocket perché sarà di default su rails 8.0.

Esempio:

[Codice 01 - shell - linea: 1]()

```shell
ubuntu@ub22fla:~ $cd ~
ubuntu@ub22fla:~ $pwd
/home/ubuntu
ubuntu@ub22fla:~ $rails --version
Rails 7.1.3

ubuntu@ub22fla:~ $rails new ubuntudreamfive -a propshaft --database=postgresql
      create  
      create  README.md
      create  Rakefile
      create  .ruby-version
      create  config.ru
      create  .gitignore
      create  .gitattributes
      create  Gemfile
         run  git init -b main from "."
Initialized empty Git repository in /home/ubuntu/ubuntudreamfive/.git/
      create  app
      create  app/assets/config/manifest.js
      create  app/assets/stylesheets/application.css
```

[...continua - linea: 119]()

```shell
         run  bundle install
Fetching gem metadata from https://rubygems.org/...........
Resolving dependencies...
Fetching propshaft 0.8.0
Installing propshaft 0.8.0
Fetching selenium-webdriver 4.18.1
Installing selenium-webdriver 4.18.1
Bundle complete! 14 Gemfile dependencies, 81 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
         run  bundle lock --add-platform=x86_64-linux
Writing lockfile to /home/ubuntu/ubuntudreamfive/Gemfile.lock
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
  Configure importmap paths in config/importmap.rb
      create    config/importmap.rb
  Copying binstub
      create    bin/importmap
         run  bundle install
Bundle complete! 14 Gemfile dependencies, 81 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
       rails  turbo:install stimulus:install
       apply  /home/ubuntu/.rvm/gems/ruby-3.3.0/gems/turbo-rails-2.0.3/lib/install/turbo_with_importmap.rb
  Import Turbo
      append    app/javascript/application.js
  Pin Turbo
      append    config/importmap.rb
         run  bundle install
Bundle complete! 14 Gemfile dependencies, 81 gems now installed.
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
Bundle complete! 14 Gemfile dependencies, 81 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
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

Abbiamo ancora *16GB* disponibili.



## Apriamo l'applicazione localmente

Per aprire la nuova applicazione entriamo nella cartella e facciamo partire il web server

```bash
$ cd ubuntudreamfive
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
