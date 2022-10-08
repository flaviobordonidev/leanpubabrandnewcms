# <a name="top"></a> Cap 1.1 - Nuova app rails

***QUESTO è UN PROGETTO TEMPORANEO PER AVERE UN FACILE PORTING SU RAILS DEL TEMA EDUPORT***

***Nel tempo l'applicazione che svilupperemo (nello specifico ubuntudream) sarà spostata su una soluzione con `importmap` e `Propshaft`.***


***PROGETTO CANCELLATO PERCHE' ANCHE QUI NON RIESCO A FAR FUNZIONARE FACILMENTE IL JAVASCRIPT DEL TEMA EDUPORT***


Creiamo la nuova applicazione Eduport tramite node js con esbuild.

> Lo scopo di questo progetto è vedere se usando questo approccio più "tradizionale" l'importazione del tema eduport risulti più facile.<br/>
> Nello specifico se la parte javascript riusciamo ad attivarla senza troppi problemi.<br/>
> Se le icone BootStrap sono attive senza troppi problemi.<br/>
>...
>
> Questo perché con *importmap* le icone BootStrap non sono riuscito a farle funzionare e neanche il codice javascript così com'è. Ho dovuto riscrivere tutto basandomi su "stimulus". Chiaro che "stimulus" è il futuro ed il modo migliore ma ci vuole tanto tempo di riprogrammazione. Se non sono costretto a farlo da subito mi concentro su altro e faccio il passaggio piano piano con calma.



## Risorse interne

- [code_references/new_rails_app]()



## Risorse esterne

- [Getting Started with Ruby on Rails on Render](https://render.com/docs/deploy-rails)



## Creiamo l'applicazione

In produzione Render utilizza postgreSQL quindi lo installiamo anche localmente.
Un'alternativa era quella di caricare la gemma "pg" solo per l'ambiente di produzione. Ma è preferibile usare nell'ambiente di sviluppo le stesse risorse usate in produzione.
Inoltre impostiamo già anche BootStrap.

```bash
$ cd ~/
$ rails --version
$ rails new eduport_esbuild --database=postgresql -j esbuild --css bootstrap
```

Esempio:

```bash
ubuntu@ubuntufla:~ $rails new eduport_esbuild --database=postgresql -j esbuild --css bootstrap
      create                                                
      create  README.md                                     
      create  Rakefile                                      
      create  .ruby-version                                 
      create  config.ru                                     
      create  .gitignore                                    
      create  .gitattributes                                
      create  Gemfile       
         run  git init from "."
Initialized empty Git repository in /home/ubuntu/eduport_esbuild/.git/
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
Using timeout 0.3.0
Using net-protocol 0.1.3
Fetching net-imap 0.3.1
Installing net-imap 0.3.1
Fetching net-pop 0.1.2
Installing net-pop 0.1.2
Fetching net-smtp 0.3.2
Installing net-smtp 0.3.2
Using actionmailbox 7.0.4
Using actionmailer 7.0.4
Using actiontext 7.0.4
Using public_suffix 5.0.0
Using addressable 2.8.1
Using bindex 0.8.1
Fetching msgpack 1.6.0
Installing msgpack 1.6.0 with native extensions
Using bootsnap 1.13.0
Using bundler 2.3.12
Using matrix 0.4.2
Fetching regexp_parser 2.6.0
Installing regexp_parser 2.6.0
Using xpath 3.2.0
Using capybara 3.37.1
Using childprocess 4.1.0
Using method_source 1.0.0
Using thor 1.2.1
Fetching zeitwerk 2.6.1
Installing zeitwerk 2.6.1
Using railties 7.0.4
Fetching cssbundling-rails 1.1.1
Installing cssbundling-rails 1.1.1
Using io-console 0.5.11
Using reline 0.3.1
Fetching irb 1.4.2
Installing irb 1.4.2
Using debug 1.6.2
Using jbuilder 2.11.5
Fetching jsbundling-rails 1.0.3
Installing jsbundling-rails 1.0.3
Using pg 1.4.3
Using puma 5.6.5
Using rails 7.0.4
Using rexml 3.2.5
Using rubyzip 2.3.2
Using websocket 1.2.9
Fetching selenium-webdriver 4.5.0
Installing selenium-webdriver 4.5.0
Using sprockets 4.1.1
Using sprockets-rails 3.4.2
Using stimulus-rails 1.1.0
Fetching turbo-rails 1.3.0
Installing turbo-rails 1.3.0
Using web-console 4.2.0
Fetching webdrivers 5.2.0
Installing webdrivers 5.2.0
Bundle complete! 16 Gemfile dependencies, 73 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
         run  bundle binstubs bundler
       rails  javascript:install:esbuild
Compile into app/assets/builds
      create  app/assets/builds
      create  app/assets/builds/.keep
      append  app/assets/config/manifest.js
      append  .gitignore
      append  .gitignore
Add JavaScript include tag in application layout
      insert  app/views/layouts/application.html.erb
Create default entrypoint in app/javascript/application.js
      create  app/javascript
      create  app/javascript/application.js
Add default package.json
      create  package.json
Add default Procfile.dev
      create  Procfile.dev
Ensure foreman is installed
         run  gem install foreman from "."
Successfully installed foreman-0.87.2
Parsing documentation for foreman-0.87.2
Done installing documentation for foreman after 1 seconds
1 gem installed
Add bin/dev to start foreman
      create  bin/dev
Install esbuild
         run  yarn add esbuild from "."
yarn add v1.22.17
info No lockfile found.
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
[4/4] Building fresh packages...
success Saved lockfile.
warning Your current version of Yarn is out of date. The latest version is "1.22.19", while you are on "1.22.17".
info To upgrade, run the following command:
$ curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
success Saved 2 new dependencies.
info Direct dependencies
└─ esbuild@0.15.10
info All dependencies
├─ esbuild-linux-64@0.15.10
└─ esbuild@0.15.10
Done in 16.63s.
Add build script
         run  npm set-script build "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets" from "."
npm WARN set-script set-script is deprecated, use 'npm pkg set scripts.scriptname="cmd"' instead.
         run  yarn build from "."
yarn run v1.22.17
$ esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets

  app/assets/builds/application.js      62b 
  app/assets/builds/application.js.map  93b 

Done in 0.17s.
       rails  turbo:install stimulus:install
Import Turbo
      append  app/javascript/application.js
Install Turbo
         run  yarn add @hotwired/turbo-rails from "."
yarn add v1.22.17
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
[4/4] Building fresh packages...
success Saved lockfile.
success Saved 3 new dependencies.
info Direct dependencies
└─ @hotwired/turbo-rails@7.2.0
info All dependencies
├─ @hotwired/turbo-rails@7.2.0
├─ @hotwired/turbo@7.2.0
└─ @rails/actioncable@7.0.4
Done in 3.75s.
Enable redis in bundle
        gsub  Gemfile
         run  bundle install
Fetching gem metadata from https://rubygems.org/..........
Resolving dependencies....
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
Using timeout 0.3.0
Using net-protocol 0.1.3
Using net-imap 0.3.1
Using net-pop 0.1.2
Using net-smtp 0.3.2
Using actionmailbox 7.0.4
Using actionmailer 7.0.4
Using actiontext 7.0.4
Using public_suffix 5.0.0
Using addressable 2.8.1
Using bindex 0.8.1
Using msgpack 1.6.0
Using bootsnap 1.13.0
Using bundler 2.3.12
Using matrix 0.4.2
Using regexp_parser 2.6.0
Using xpath 3.2.0
Using capybara 3.37.1
Using childprocess 4.1.0
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.6.1
Using railties 7.0.4
Using cssbundling-rails 1.1.1
Using io-console 0.5.11
Using reline 0.3.1
Using irb 1.4.2
Using debug 1.6.2
Using jbuilder 2.11.5
Using jsbundling-rails 1.0.3
Using pg 1.4.3
Using puma 5.6.5
Using rails 7.0.4
Using redis 4.8.0
Using rexml 3.2.5
Using rubyzip 2.3.2
Using websocket 1.2.9
Using selenium-webdriver 4.5.0
Using sprockets 4.1.1
Using sprockets-rails 3.4.2
Using stimulus-rails 1.1.0
Using turbo-rails 1.3.0
Using web-console 4.2.0
Using webdrivers 5.2.0
Bundle complete! 17 Gemfile dependencies, 74 gems now installed.
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
Install Stimulus
         run  yarn add @hotwired/stimulus from "."
yarn add v1.22.17
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
[4/4] Building fresh packages...
success Saved lockfile.
success Saved 1 new dependency.
info Direct dependencies
└─ @hotwired/stimulus@3.1.0
info All dependencies
└─ @hotwired/stimulus@3.1.0
Done in 2.92s.
       rails  css:install:bootstrap
Build into app/assets/builds
       exist  app/assets/builds
   identical  app/assets/builds/.keep
File unchanged! The supplied flag value not found!  app/assets/config/manifest.js
Stop linking stylesheets automatically
        gsub  app/assets/config/manifest.js
File unchanged! The supplied flag value not found!  .gitignore
File unchanged! The supplied flag value not found!  .gitignore
Remove app/assets/stylesheets/application.css so build output can take over
      remove  app/assets/stylesheets/application.css
Add stylesheet link tag in application layout
File unchanged! The supplied flag value not found!  app/views/layouts/application.html.erb
      append  Procfile.dev
Add bin/dev to start foreman
   identical  bin/dev
Install Bootstrap with Bootstrap Icons and Popperjs/core
      create  app/assets/stylesheets/application.bootstrap.scss
         run  yarn add sass bootstrap bootstrap-icons @popperjs/core from "."
yarn add v1.22.17
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
[4/4] Building fresh packages...
success Saved lockfile.
success Saved 20 new dependencies.
info Direct dependencies
├─ @popperjs/core@2.11.6
├─ bootstrap-icons@1.9.1
├─ bootstrap@5.2.2
└─ sass@1.55.0
info All dependencies
├─ @popperjs/core@2.11.6
├─ anymatch@3.1.2
├─ binary-extensions@2.2.0
├─ bootstrap-icons@1.9.1
├─ bootstrap@5.2.2
├─ braces@3.0.2
├─ chokidar@3.5.3
├─ fill-range@7.0.1
├─ glob-parent@5.1.2
├─ immutable@4.1.0
├─ is-binary-path@2.1.0
├─ is-extglob@2.1.1
├─ is-glob@4.0.3
├─ is-number@7.0.0
├─ normalize-path@3.0.0
├─ picomatch@2.3.1
├─ readdirp@3.6.0
├─ sass@1.55.0
├─ source-map-js@1.0.2
└─ to-regex-range@5.0.1
Done in 6.26s.
      insert  config/initializers/assets.rb
Appending Bootstrap JavaScript import to default entry point
      append  app/javascript/application.js
Add build:css script
         run  npm set-script build:css "sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules" from "."
npm WARN set-script set-script is deprecated, use 'npm pkg set scripts.scriptname="cmd"' instead.
         run  yarn build:css from "."
yarn run v1.22.17
$ sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules
Done in 4.41s.
ubuntu@ubuntufla:~ $ls
bl7_0  eduport  eduport_esbuild  instaclone  prorb_db_queries  simple_blog  ubuntudream
ubuntu@ubuntufla:~ $cd eduport_esbuild/
ubuntu@ubuntufla:~/eduport_esbuild $
```

> Siccome nelle precedenti app abbiamo installato `redis` nella VM (virtual machine) Ubuntu multipass, nell'installazione di una nuova app lo configura e fa anche lo *Switch development cable to use redis*.

> Oppure è semplicemente dovuto alla nuova versione di Rails ^_^

> Possiamo gestire postgreSQL localmente nell'ambiente di sviluppo e test perché lo abbiamo già installato nei capitoli precedenti. Dobbiamo solo farlo partire. 



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
$ cd eduport_esbuild
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
