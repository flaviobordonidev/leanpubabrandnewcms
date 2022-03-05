# <a name="top"></a> Cap 1.6 - Nuova app Rails

Abbiamo preparato tutto l'ambiente e adesso creaimo una nuova app Rails.



## Risorse interne:

- 


## Risorse esterne:



## Creiamo l'applicazione

In produzione Heroku utilizza postgreSQL quindi lo installiamo anche localmente. ( vedi [Heroku devcenter - Getting Started on Heroku with Rails 7.x](https://devcenter.heroku.com/articles/getting-started-with-rails7) )
Possiamo gestire postgreSQL localmente nell'ambiente di sviluppo e test perché lo abbiamo già installato nei capitoli precedenti. Dobbiamo solo farlo partire. 
Un'alternativa era quella di caricare la gemma "pg" solo per l'ambiente di produzione. Ma è preferibile usare nell'ambiente di sviluppo le stesse risorse usate in produzione.

```bash
$ cd ~/
$ rails --version
$ rails new bl7_0 --database=postgresql
```

Il nome "bl7_0" vuol dire " baseline 7.0 " ad indicare che siamo partiti da rails 7.0.x.

> Possiamo anche indicare una specifica versione di rails ad esempio `rails _7.0.1_ new bl7_0 --database=postgresql` ma può essere utile solo in casi particolari. Normalmente è preferibile non forzarla e lasciare quella di default che è la più attuale che trova installata.

Esempio:

```bash
ubuntu@ubuntufla:~$ ls
test
ubuntu@ubuntufla:~$ rails --version
Rails 7.0.2.2
ubuntu@ubuntufla:~$ rails new bl7_0 --database=postgresql
      create  
      create  README.md
      create  Rakefile
      create  .ruby-version
      create  config.ru
      create  .gitignore
      create  .gitattributes
      create  Gemfile
         run  git init from "."
Initialized empty Git repository in /home/ubuntu/bl7_0/.git/
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
Fetching public_suffix 4.0.6
Installing public_suffix 4.0.6
Fetching addressable 2.8.0
Installing addressable 2.8.0
Fetching bindex 0.8.1
Installing bindex 0.8.1 with native extensions
Fetching msgpack 1.4.5
Installing msgpack 1.4.5 with native extensions
Fetching bootsnap 1.10.3
Installing bootsnap 1.10.3 with native extensions
Using bundler 2.3.7
Using matrix 0.4.2
Fetching regexp_parser 2.2.1
Installing regexp_parser 2.2.1
Fetching xpath 3.2.0
Installing xpath 3.2.0
Fetching capybara 3.36.0
Installing capybara 3.36.0
Fetching childprocess 4.1.0
Installing childprocess 4.1.0
Using io-console 0.5.11
Fetching reline 0.3.1
Installing reline 0.3.1
Using irb 1.4.1
Using debug 1.4.0
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.5.4
Using railties 7.0.2.2
Fetching importmap-rails 1.0.3
Installing importmap-rails 1.0.3
Fetching jbuilder 2.11.5
Installing jbuilder 2.11.5
Fetching pg 1.3.3
Installing pg 1.3.3 with native extensions
Fetching puma 5.6.2
Installing puma 5.6.2 with native extensions
Using rails 7.0.2.2
Using rexml 3.2.5
Fetching rubyzip 2.3.2
Installing rubyzip 2.3.2
Fetching selenium-webdriver 4.1.0
Installing selenium-webdriver 4.1.0
Fetching sprockets 4.0.3
Installing sprockets 4.0.3
Fetching sprockets-rails 3.4.2
Installing sprockets-rails 3.4.2
Fetching stimulus-rails 1.0.4
Installing stimulus-rails 1.0.4
Fetching turbo-rails 1.0.1
Installing turbo-rails 1.0.1
Fetching web-console 4.2.0
Installing web-console 4.2.0
Fetching webdrivers 5.0.0
Installing webdrivers 5.0.0
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
Run turbo:install:redis to switch on Redis and use it in development for turbo streams
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
ubuntu@ubuntufla:~$ 
```



## Verifichiamo quanto spazio disco ci resta

```bash
$ df -hT /dev/vda1
```

Esempio:

```bash
ubuntu@ubuntufla:~$ df -hT 
Filesystem     Type      Size  Used Avail Use% Mounted on
udev           devtmpfs  2.0G     0  2.0G   0% /dev
tmpfs          tmpfs     394M  880K  393M   1% /run
/dev/vda1      ext4       20G  3.6G   16G  19% /
tmpfs          tmpfs     2.0G   16K  2.0G   1% /dev/shm
tmpfs          tmpfs     5.0M     0  5.0M   0% /run/lock
tmpfs          tmpfs     2.0G     0  2.0G   0% /sys/fs/cgroup
/dev/loop0     squashfs   68M   68M     0 100% /snap/lxd/21835
/dev/loop2     squashfs   62M   62M     0 100% /snap/core20/1361
/dev/loop1     squashfs   62M   62M     0 100% /snap/core20/1328
/dev/loop3     squashfs   44M   44M     0 100% /snap/snapd/14978
/dev/loop4     squashfs   68M   68M     0 100% /snap/lxd/22526
/dev/vda15     vfat      105M  5.2M  100M   5% /boot/efi
tmpfs          tmpfs     394M     0  394M   0% /run/user/1000
ubuntu@ubuntufla:~$ df -hT /dev/vda1
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/vda1      ext4   20G  3.6G   16G  19% /
ubuntu@ubuntufla:~$ 
```

Abbiamo ancora **16GB** disponibili.



## Apriamo l'applicazione localmente

Per aprire la nuova applicazione entriamo nella cartella e facciamo partire il web server

```bash
$ cd bl7_0
$ rails s -b 192.168.64.3
```

> Se usavamo solo `$ rails s` la pagina web era raggiungibile solo in locale ed invece noi il browser lo apriamo nella pc con macOS. Quindi per renderlo raggiungibile da un altro pc gli facciamo esporre un indirizzo ip e nello specifico lo stesso della VM.

Di default va sulla porta 3000 se volevamo spostarlo sulla porta 8080 avremmo fatto:

```bash
$ rails s -b 192.168.64.3 -p  8080
```

> Possiamo usare solo porte libere. se proviamo sulla porta 80 riceviamo un errore.


Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0$ rails s
=> Booting Puma
=> Rails 7.0.2.2 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.6.2 (ruby 3.1.1-p18) ("Birdie's Version")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 1876
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
Use Ctrl-C to stop
^C- Gracefully stopping, waiting for requests to finish
=== puma shutdown: 2022-03-04 09:48:45 +0100 ===
- Goodbye!
Exiting
ubuntu@ubuntufla:~/bl7_0$ rails s -b 192.168.64.3
=> Booting Puma
=> Rails 7.0.2.2 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.6.2 (ruby 3.1.1-p18) ("Birdie's Version")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 1888
* Listening on http://192.168.64.3:3000
Use Ctrl-C to stop
```



## Verifichiamo preview

Una volta partito il server apriamo un browser sul nostro pc con macOS ed indichiamo nell'URL l'indirizzo IP della VM e la porta *3000* su cui si sta presentando il web server *Puma*.

***URL: http://192.168.64.3:3000***

Ci colleghiamo correttamente ma riceviamo il messaggio di errore *ActiveRecord:NoDatabaseError*.
Questo è semplicemente dovuto alla mancanza del database su PostgreSQL per la nostra applicazione.
Cosa che risolviamo nel prossimo capitolo.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/06_fig01-browser_preview.png)



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/05_00-install_postgresql.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app_with_ubuntu_multipass/07_00-pg_app_databases.md)
