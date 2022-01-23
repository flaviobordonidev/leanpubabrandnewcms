# <a name="top"></a> Cap 1.7 -- Nuova app Rails su ambiente aws Cloud9

Abbiamo preparato l'ambiente c9 e adesso creaimo una nuova app Rails

Before you install Rails, you should check to make sure that your system has the proper prerequisites installed. These include:

- Ruby
- SQLite3
- Node.js
- Yarn



## Risorse interne:

- 99-rails_references/gems/rails
- 99-rails_references/yarn/01-yarn



## Risorse esterne:

- https://guides.rubyonrails.org/getting_started.html
- https://cloudsoftfi.com/rails/setup-up-ruby-on-rails-development-on-aws-cloud-9-quick-easy/
- https://www.ruby-lang.org/en/downloads/
- https://devcenter.heroku.com/articles/getting-started-with-rails7



## Aggiorniamo Ruby
Verifichiamo la versione di Ruby
Rails requires Ruby version 2.7.0 or later. It is preferred to use latest Ruby version.

```bash
$ ruby --version
```

Esempio:

```bash
user_fb:~/environment $ ruby --version
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
```

Aggiorniamo all'ultima versione.

> verifichiamo [l'ultima versione di ruby](https://www.ruby-lang.org/en/downloads/)
> The current stable version is 3.1.0. 


```bash
rvm get stable
rvm install ruby-3.1.0
rvm use ruby-3.1.0
```

Esempio:

```bash
user_fb:~/environment $ rvm get stable
Downloading https://get.rvm.io
Downloading https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc
Verifying /home/ubuntu/.rvm/archives/rvm-installer.asc
gpg: Signature made Tue Jul 23 21:59:45 2019 UTC
gpg:                using RSA key 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
gpg: Good signature from "Piotr Kuczynski <piotr.kuczynski@gmail.com>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 7D2B AF1C F37B 13E2 069D  6956 105B D0E7 3949 9BDB
GPG verified '/home/ubuntu/.rvm/archives/rvm-installer'
Downloading https://github.com/rvm/rvm/archive/1.29.12.tar.gz
Downloading https://github.com/rvm/rvm/releases/download/1.29.12/1.29.12.tar.gz.asc
gpg: Signature made Fri Jan 15 18:46:22 2021 UTC
gpg:                using RSA key 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
gpg: Good signature from "Piotr Kuczynski <piotr.kuczynski@gmail.com>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 7D2B AF1C F37B 13E2 069D  6956 105B D0E7 3949 9BDB
GPG verified '/home/ubuntu/.rvm/archives/rvm-1.29.12.tgz'
Upgrading the RVM installation in /home/ubuntu/.rvm/
    RVM PATH line found in /home/ubuntu/.mkshrc /home/ubuntu/.profile /home/ubuntu/.bashrc /home/ubuntu/.zshrc.
    RVM sourcing line found in /home/ubuntu/.profile /home/ubuntu/.bash_profile /home/ubuntu/.zlogin.
Upgrade of RVM in /home/ubuntu/.rvm/ is complete.

Thanks for installing RVM 🙏
Please consider donating to our open collective to help us maintain RVM.

👉  Donate: https://opencollective.com/rvm/donate


RVM reloaded!
user_fb:~/environment $ rvm install ruby-3.1.0
Searching for binary rubies, this might take some time.
No binary rubies available for: ubuntu/18.04/x86_64/ruby-3.1.0.
Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
Checking requirements for ubuntu.
Requirements installation successful.
Installing Ruby from source to: /home/ubuntu/.rvm/rubies/ruby-3.1.0, this may take a while depending on your cpu(s)...
ruby-3.1.0 - #downloading ruby-3.1.0, this may take a while depending on your connection...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 19.1M  100 19.1M    0     0  71.2M      0 --:--:-- --:--:-- --:--:-- 71.0M
No checksum for downloaded archive, recording checksum in user configuration.
ruby-3.1.0 - #extracting ruby-3.1.0 to /home/ubuntu/.rvm/src/ruby-3.1.0.....
ruby-3.1.0 - #configuring..........................................................................
ruby-3.1.0 - #post-configuration..
ruby-3.1.0 - #compiling.............................................................................................
ruby-3.1.0 - #installing....................
ruby-3.1.0 - #making binaries executable...
Installed rubygems 3.3.3 is newer than 3.0.9 provided with installed ruby, skipping installation, use --force to force installation.
ruby-3.1.0 - #gemset created /home/ubuntu/.rvm/gems/ruby-3.1.0@global
ruby-3.1.0 - #importing gemset /home/ubuntu/.rvm/gemsets/global.gems................................................................
ruby-3.1.0 - #generating global wrappers........
ruby-3.1.0 - #gemset created /home/ubuntu/.rvm/gems/ruby-3.1.0
ruby-3.1.0 - #importing gemsetfile /home/ubuntu/.rvm/gemsets/default.gems evaluated to empty gem list
ruby-3.1.0 - #generating default wrappers........
ruby-3.1.0 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
Install of ruby-3.1.0 - #complete 
Ruby was built without documentation, to build it run: rvm docs generate-ri
user_fb:~/environment $ rvm use ruby-3.1.0
Using /home/ubuntu/.rvm/gems/ruby-3.1.0
user_fb:~/environment $ ruby --version
ruby 3.1.0p0 (2021-12-25 revision fb4df44d16) [x86_64-linux]
user_fb:~/environment $ 
```



## Aggiorniamo Node.js
Verifichiamo la versione di Node.js
The version of your Node.js runtime should be printed out. Make sure it's greater than 8.16.0.

```bash
$ node --version
```

Esempio:

```bash
user_fb:~/environment $ node --version
v16.13.1
```

La versione di node.js va bene.



## Aggiorniamo Yarn

Verifichiamo la versione di Yarn
If it says something like "1.22.0", Yarn has been installed correctly.

```bash
$ yarn --version
```

Esempio:

```bash
user_fb:~/environment $ yarn --version

Command 'yarn' not found, but can be installed with:

sudo apt install cmdtest
```

Nel nostro caso Yarn non è installato!

Installaimola.

> verifichiamo [come installare Yarn](https://classic.yarnpkg.com/en/docs/install#mac-stable)
> It is recommended to install Yarn through the npm package manager, which comes bundled with Node.js when you install it on your system.
> Once you have npm installed you can run the following both to install and upgrade Yarn:

```bash
$ npm install --global yarn
```


Esempio:

```bash
user_fb:~/environment $ npm install --global yarn

added 1 package, and audited 2 packages in 2s

found 0 vulnerabilities
npm notice 
npm notice New minor version of npm available! 8.1.2 -> 8.3.1
npm notice Changelog: https://github.com/npm/cli/releases/tag/v8.3.1
npm notice Run npm install -g npm@8.3.1 to update!
npm notice 
user_fb:~/environment $ yarn --version
1.22.17
user_fb:~/environment $ 
```

Adesso anche Yarn è installato.



### Altro modo di installare Yarn

In passato, quando abbiamo installato Yarn per Rails 6, abbiamo usato *curl*.
Per evitare problemi di autorizzazione lo abbiamo installiato con i diritti di root, usando *sudo su -*.

```bash
$ sudo su - 
-> curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
-> echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
-> sudo apt-get -y update && sudo apt-get -y install yarn
-> exit
```

Esempio: 
  
```bash
user_fb:~/environment $ sudo su -
root@ip-172-31-89-200:~# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
OK
root@ip-172-31-89-200:~# echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
deb https://dl.yarnpkg.com/debian/ stable main
root@ip-172-31-89-200:~# sudo apt-get -y update && sudo apt-get -y install yarn
Hit:1 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic InRelease
Get:2 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]                                                 
Get:3 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]                                               
Hit:4 http://security.ubuntu.com/ubuntu bionic-security InRelease                                                                       
Hit:5 https://download.docker.com/linux/ubuntu bionic InRelease                                                                         
Get:6 https://dl.yarnpkg.com/debian stable InRelease [17.1 kB]                                                               
Get:7 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages [752 kB]
Get:8 https://dl.yarnpkg.com/debian stable/main amd64 Packages [9122 B]
Get:9 https://dl.yarnpkg.com/debian stable/main all Packages [9122 B]
Fetched 951 kB in 1s (1246 kB/s)
Reading package lists... Done
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libc-ares2 libhttp-parser2.7.1 nodejs nodejs-doc
The following NEW packages will be installed:
  libc-ares2 libhttp-parser2.7.1 nodejs nodejs-doc yarn
0 upgraded, 5 newly installed, 0 to remove and 18 not upgraded.
Need to get 6496 kB of archives.
After this operation, 30.1 MB of additional disk space will be used.
Get:1 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/universe amd64 nodejs-doc all 8.10.0~dfsg-2ubuntu0.4 [752 kB]
Get:2 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic/main amd64 libc-ares2 amd64 1.14.0-1 [37.1 kB]
Get:3 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic/main amd64 libhttp-parser2.7.1 amd64 2.7.1-2 [20.6 kB]
Get:4 http://us-east-1.ec2.archive.ubuntu.com/ubuntu bionic-updates/universe amd64 nodejs amd64 8.10.0~dfsg-2ubuntu0.4 [4796 kB]
Get:5 https://dl.yarnpkg.com/debian stable/main amd64 yarn all 1.19.1-1 [890 kB]
Fetched 6496 kB in 0s (46.1 MB/s)                         
Selecting previously unselected package nodejs-doc.
(Reading database ... 159112 files and directories currently installed.)
Preparing to unpack .../nodejs-doc_8.10.0~dfsg-2ubuntu0.4_all.deb ...
Unpacking nodejs-doc (8.10.0~dfsg-2ubuntu0.4) ...
Selecting previously unselected package yarn.
Preparing to unpack .../archives/yarn_1.19.1-1_all.deb ...
Unpacking yarn (1.19.1-1) ...
Selecting previously unselected package libc-ares2:amd64.
Preparing to unpack .../libc-ares2_1.14.0-1_amd64.deb ...
Unpacking libc-ares2:amd64 (1.14.0-1) ...
Selecting previously unselected package libhttp-parser2.7.1:amd64.
Preparing to unpack .../libhttp-parser2.7.1_2.7.1-2_amd64.deb ...
Unpacking libhttp-parser2.7.1:amd64 (2.7.1-2) ...
Selecting previously unselected package nodejs.
Preparing to unpack .../nodejs_8.10.0~dfsg-2ubuntu0.4_amd64.deb ...
Unpacking nodejs (8.10.0~dfsg-2ubuntu0.4) ...
Setting up nodejs-doc (8.10.0~dfsg-2ubuntu0.4) ...
Setting up libhttp-parser2.7.1:amd64 (2.7.1-2) ...
Setting up yarn (1.19.1-1) ...
Setting up libc-ares2:amd64 (1.14.0-1) ...
Setting up nodejs (8.10.0~dfsg-2ubuntu0.4) ...
update-alternatives: using /usr/bin/nodejs to provide /usr/bin/js (js) in auto mode
Processing triggers for man-db (2.8.3-2ubuntu0.1) ...
Processing triggers for libc-bin (2.27-3ubuntu1) ...
root@ip-172-31-89-200:~# exit
logout
```



## Installiamo Rails

Per installare Rails carichiamo la corrispondente gemma ruby.

I> verifichiamo [l'ultima versione della gemma](https://rubygems.org/gems/rails)
I>
I> facciamo riferimento al [tutorial della gemma](https://rubyonrails.org/)

Poiché pubblicheremo in produzione la nostra applicazione su Heroku verifichiamo quale versione Rails è supportata su [Heroku devcenter - Getting Started on Heroku with Rails 7.x](https://devcenter.heroku.com/articles/getting-started-with-rails7)

```bash
$ cd ~/environment
$ gem install rails
```

Volendo istallare una versione specifica possiamo indicarla. Ad esempio: *$ gem install rails -v 7.0.1*

Per verificare quale versione di rails abbiamo installato

```bash
$ rails --version
```

Esempio:

```bash
user_fb:~/environment $ gem install rails
Fetching concurrent-ruby-1.1.9.gem
Fetching i18n-1.8.11.gem
Fetching loofah-2.13.0.gem
Fetching activesupport-7.0.1.gem
Fetching nokogiri-1.13.1-x86_64-linux.gem
Fetching crass-1.0.6.gem
Fetching rack-2.2.3.gem
Fetching tzinfo-2.0.4.gem
Fetching method_source-1.0.0.gem
Fetching zeitwerk-2.5.3.gem
Fetching actionpack-7.0.1.gem
Fetching rails-html-sanitizer-1.4.2.gem
Fetching rails-dom-testing-2.0.3.gem
Fetching thor-1.2.1.gem
Fetching activemodel-7.0.1.gem
Fetching erubi-1.10.0.gem
Fetching builder-3.2.4.gem
Fetching activejob-7.0.1.gem
Fetching rack-test-1.1.0.gem
Fetching mini_mime-1.1.2.gem
Fetching actionview-7.0.1.gem
Fetching railties-7.0.1.gem
Fetching actiontext-7.0.1.gem
Fetching globalid-1.0.0.gem
Fetching marcel-1.0.2.gem
Fetching nio4r-2.5.8.gem
Fetching activerecord-7.0.1.gem
Fetching websocket-extensions-0.1.5.gem
Fetching websocket-driver-0.7.5.gem
Fetching activestorage-7.0.1.gem
Fetching actionmailbox-7.0.1.gem
Fetching mail-2.7.1.gem
Fetching actioncable-7.0.1.gem
Fetching rails-7.0.1.gem
Fetching actionmailer-7.0.1.gem
Successfully installed zeitwerk-2.5.3
Successfully installed thor-1.2.1
Successfully installed method_source-1.0.0
Successfully installed concurrent-ruby-1.1.9
Successfully installed tzinfo-2.0.4
Successfully installed i18n-1.8.11
Successfully installed activesupport-7.0.1
Successfully installed nokogiri-1.13.1-x86_64-linux
Successfully installed crass-1.0.6
Successfully installed loofah-2.13.0
Successfully installed rails-html-sanitizer-1.4.2
Successfully installed rails-dom-testing-2.0.3
Successfully installed rack-2.2.3
Successfully installed rack-test-1.1.0
Successfully installed erubi-1.10.0
Successfully installed builder-3.2.4
Successfully installed actionview-7.0.1
Successfully installed actionpack-7.0.1
Successfully installed railties-7.0.1
Successfully installed mini_mime-1.1.2
Successfully installed marcel-1.0.2
Successfully installed activemodel-7.0.1
Successfully installed activerecord-7.0.1
Successfully installed globalid-1.0.0
Successfully installed activejob-7.0.1
Successfully installed activestorage-7.0.1
Successfully installed actiontext-7.0.1
Successfully installed mail-2.7.1
Successfully installed actionmailer-7.0.1
Successfully installed actionmailbox-7.0.1
Successfully installed websocket-extensions-0.1.5
Building native extensions. This could take a while...
Successfully installed websocket-driver-0.7.5
Building native extensions. This could take a while...
Successfully installed nio4r-2.5.8
Successfully installed actioncable-7.0.1
Successfully installed rails-7.0.1
Parsing documentation for zeitwerk-2.5.3
Installing ri documentation for zeitwerk-2.5.3
Parsing documentation for thor-1.2.1
Installing ri documentation for thor-1.2.1
Parsing documentation for method_source-1.0.0
Installing ri documentation for method_source-1.0.0
Parsing documentation for concurrent-ruby-1.1.9
Installing ri documentation for concurrent-ruby-1.1.9
Parsing documentation for tzinfo-2.0.4
Installing ri documentation for tzinfo-2.0.4
Parsing documentation for i18n-1.8.11
Installing ri documentation for i18n-1.8.11
Parsing documentation for activesupport-7.0.1
Installing ri documentation for activesupport-7.0.1
Parsing documentation for nokogiri-1.13.1-x86_64-linux
Installing ri documentation for nokogiri-1.13.1-x86_64-linux
Parsing documentation for crass-1.0.6
Installing ri documentation for crass-1.0.6
Parsing documentation for loofah-2.13.0
Installing ri documentation for loofah-2.13.0
Parsing documentation for rails-html-sanitizer-1.4.2
Installing ri documentation for rails-html-sanitizer-1.4.2
Parsing documentation for rails-dom-testing-2.0.3
Installing ri documentation for rails-dom-testing-2.0.3
Parsing documentation for rack-2.2.3
Installing ri documentation for rack-2.2.3
Parsing documentation for rack-test-1.1.0
Installing ri documentation for rack-test-1.1.0
Parsing documentation for erubi-1.10.0
Installing ri documentation for erubi-1.10.0
Parsing documentation for builder-3.2.4
Installing ri documentation for builder-3.2.4
Parsing documentation for actionview-7.0.1
Installing ri documentation for actionview-7.0.1
Parsing documentation for actionpack-7.0.1
Installing ri documentation for actionpack-7.0.1
Parsing documentation for railties-7.0.1
Installing ri documentation for railties-7.0.1
Parsing documentation for mini_mime-1.1.2
Installing ri documentation for mini_mime-1.1.2
Parsing documentation for marcel-1.0.2
Installing ri documentation for marcel-1.0.2
Parsing documentation for activemodel-7.0.1
Installing ri documentation for activemodel-7.0.1
Parsing documentation for activerecord-7.0.1
Installing ri documentation for activerecord-7.0.1
Parsing documentation for globalid-1.0.0
Installing ri documentation for globalid-1.0.0
Parsing documentation for activejob-7.0.1
Installing ri documentation for activejob-7.0.1
Parsing documentation for activestorage-7.0.1
Installing ri documentation for activestorage-7.0.1
Parsing documentation for actiontext-7.0.1
Installing ri documentation for actiontext-7.0.1
Parsing documentation for mail-2.7.1
Installing ri documentation for mail-2.7.1
Parsing documentation for actionmailer-7.0.1
Installing ri documentation for actionmailer-7.0.1
Parsing documentation for actionmailbox-7.0.1
Installing ri documentation for actionmailbox-7.0.1
Parsing documentation for websocket-extensions-0.1.5
Installing ri documentation for websocket-extensions-0.1.5
Parsing documentation for websocket-driver-0.7.5
Installing ri documentation for websocket-driver-0.7.5
Parsing documentation for nio4r-2.5.8
Installing ri documentation for nio4r-2.5.8
Parsing documentation for actioncable-7.0.1
Installing ri documentation for actioncable-7.0.1
Parsing documentation for rails-7.0.1
Installing ri documentation for rails-7.0.1
Done installing documentation for zeitwerk, thor, method_source, concurrent-ruby, tzinfo, i18n, activesupport, nokogiri, crass, loofah, rails-html-sanitizer, rails-dom-testing, rack, rack-test, erubi, builder, actionview, actionpack, railties, mini_mime, marcel, activemodel, activerecord, globalid, activejob, activestorage, actiontext, mail, actionmailer, actionmailbox, websocket-extensions, websocket-driver, nio4r, actioncable, rails after 46 seconds
35 gems installed
user_fb:~/environment $ rails --version
Rails 7.0.1
user_fb:~/environment $ 
```




## Fissiamo il nuovo ambiente RVM

Se usciamo dalla sessione di aws c9 e rientriamo ci ritroviamo nell'RVM precedente con le vecchie versioni di Ruby e di Rails.
Dobbiamo cambiare il default e possiamo anche eliminare l'ambiente vecchio.

```bash
$ rvm list
  =* ruby-2.6.3 [ x86_64 ]
     ruby-3.1.0 [ x86_64 ]

$ rvm alias create default ruby-3.1.0
$ rvm use ruby-3.1.0
$ rvm remove ruby-2.6.3

$ rvm list
  =* ruby-3.1.0 [ x86_64 ]
```

Esempio:

```bash
user_fb:~/environment $ rails --version
Rails 5.0.0
user_fb:~/environment $ rails --version
Rails 5.0.0
user_fb:~/environment $ ruby --version
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]

user_fb:~/environment $ rvm list
=* ruby-2.6.3 [ x86_64 ]
   ruby-3.1.0 [ x86_64 ]

# => - current
# =* - current && default
#  * - default

user_fb:~/environment $ rvm use ruby-3.1.0
Using /home/ubuntu/.rvm/gems/ruby-3.1.0
user_fb:~/environment $ rails --version                                                                                                                                       
Rails 7.0.1
user_fb:~/environment $ rvm remove ruby-2.6.3
ruby-2.6.3 - #removing rubies/ruby-2.6.3..
ruby-2.6.3 - #removing gems....
ruby-2.6.3 - #removing aliases
ruby-2.6.3 - #removing wrappers....
ruby-2.6.3 - #removing environments....
Now using system ruby.
user_fb:~/environment $ rvm list
   ruby-3.1.0 [ x86_64 ]

# Default ruby not set. Try 'rvm alias create default <ruby>'.

# => - current
# =* - current && default
#  * - default

user_fb:~/environment $ rvm alias create default ruby-3.1.0
Creating alias default for ruby-3.1.0....
user_fb:~/environment $ rvm list
 * ruby-3.1.0 [ x86_64 ]

# => - current
# =* - current && default
#  * - default

user_fb:~/environment $ 
user_fb:~/environment $ rvm use ruby-3.1.0
Using /home/ubuntu/.rvm/gems/ruby-3.1.0
user_fb:~/environment $ rvm list
=* ruby-3.1.0 [ x86_64 ]

# => - current
# =* - current && default
#  * - default

user_fb:~/environment $ 
```



## Creiamo l'applicazione

Passiamo a creare l'applicazione
In produzione Heroku utilizza postgreSQL quindi lo installiamo anche localmente. ( vedi [Heroku devcenter - Getting Started on Heroku with Rails 7.x](https://devcenter.heroku.com/articles/getting-started-with-rails7) )
Possiamo gestire postgreSQL localmente nell'ambiente di sviluppo e test perché su aws cloud9 lo abbiamo già installato nei capitoli precedenti. Dobbiamo solo farlo partire. 
Un'alternativa era quella di caricare la gemma "pg" solo per l'ambiente di produzione. Ma è preferibile usare nell'ambiente di sviluppo le stesse risorse usate in produzione.

```bash
$ cd ~/environment
$ rails _7.0.1_ new bl7_0 --database=postgresql
```

Il nome "bl7_0" vuol dire " baseline 7.0 " ad indicare che siamo partiti da rails 7.0.x.

Esempio:

```bash
user_fb:~/environment $ rails _7.0.1_ new bl7_0 --database=postgresql
      create  
      create  README.md
      create  Rakefile
      create  .ruby-version
      create  config.ru
      create  .gitignore
      create  .gitattributes
      create  Gemfile
         run  git init from "."
Initialized empty Git repository in /home/ubuntu/environment/bl7_0/.git/
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
Resolving dependencies......
Using rake 13.0.6
Using concurrent-ruby 1.1.9
Using i18n 1.8.11
Using minitest 5.15.0
Using tzinfo 2.0.4
Using activesupport 7.0.1
Using builder 3.2.4
Using erubi 1.10.0
Using racc 1.6.0
Using nokogiri 1.13.1 (x86_64-linux)
Using rails-dom-testing 2.0.3
Using crass 1.0.6
Using loofah 2.13.0
Using rails-html-sanitizer 1.4.2
Using actionview 7.0.1
Using rack 2.2.3
Using rack-test 1.1.0
Using actionpack 7.0.1
Using nio4r 2.5.8
Using websocket-extensions 0.1.5
Using websocket-driver 0.7.5
Using actioncable 7.0.1
Using globalid 1.0.0
Using activejob 7.0.1
Using activemodel 7.0.1
Using activerecord 7.0.1
Using marcel 1.0.2
Using mini_mime 1.1.2
Using activestorage 7.0.1
Using mail 2.7.1
Using digest 3.1.0
Using io-wait 0.2.1
Using timeout 0.2.0
Using net-protocol 0.1.2
Using strscan 3.0.1
Fetching net-imap 0.2.3
Installing net-imap 0.2.3
Using net-pop 0.1.1
Using net-smtp 0.3.1
Using actionmailbox 7.0.1
Using actionmailer 7.0.1
Using actiontext 7.0.1
Fetching public_suffix 4.0.6
Installing public_suffix 4.0.6
Fetching addressable 2.8.0
Installing addressable 2.8.0
Fetching bindex 0.8.1
Installing bindex 0.8.1 with native extensions
Fetching msgpack 1.4.2
Installing msgpack 1.4.2 with native extensions
Fetching bootsnap 1.10.1
Installing bootsnap 1.10.1 with native extensions
Using bundler 2.3.3
Using matrix 0.4.2
Fetching regexp_parser 2.2.0
Installing regexp_parser 2.2.0
Fetching xpath 3.2.0
Installing xpath 3.2.0
Fetching capybara 3.36.0
Installing capybara 3.36.0
Fetching childprocess 4.1.0
Installing childprocess 4.1.0
Fetching io-console 0.5.11
Installing io-console 0.5.11 with native extensions
Fetching reline 0.3.1
Installing reline 0.3.1
Using irb 1.4.1
Using debug 1.4.0
Using method_source 1.0.0
Using thor 1.2.1
Using zeitwerk 2.5.3
Using railties 7.0.1
Fetching importmap-rails 1.0.2
Installing importmap-rails 1.0.2
Fetching jbuilder 2.11.5
Installing jbuilder 2.11.5
Fetching pg 1.2.3
Installing pg 1.2.3 with native extensions
Fetching puma 5.5.2
Installing puma 5.5.2 with native extensions
Using rails 7.0.1
Using rexml 3.2.5
Fetching rubyzip 2.3.2
Installing rubyzip 2.3.2
Fetching selenium-webdriver 4.1.0
Installing selenium-webdriver 4.1.0
Fetching sprockets 4.0.2
Installing sprockets 4.0.2
Fetching sprockets-rails 3.4.2
Installing sprockets-rails 3.4.2
Fetching stimulus-rails 1.0.2
Installing stimulus-rails 1.0.2
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
      append  config/importmap.rb
user_fb:~/environment $ 
```



## Apriamo l'applicazione localmente

Per aprire la nuova applicazione entriamo nella cartella e facciamo partire il web server

```bash
$ cd bl7_0
$ rails s
```

Esempio:

```bash
user_fb:~/environment $ cd bl7_0
user_fb:~/environment/bl7_0 (main) $ rails s
=> Booting Puma
=> Rails 7.0.1 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.5.2 (ruby 3.1.0-p0) ("Zawgyi")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 3679
* Listening on http://127.0.0.1:8080
* Listening on http://[::1]:8080
Use Ctrl-C to stop
```

su cloud9 clicchiamo sul link di "Preview" in alto e scegliamo "Preview Running Application"
In basso a destra si apre la finestra di preview con un messaggio di errore " Blocked host: ... " perché manca il permesso di connettersi al web server locale.

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/07_fig01-preview-web_server_connection_error.png)



## Risolviamo problema di connessione

Before running rails server, it’s necessary on some systems (including the cloud IDE) to allow connections to the local web server. To enable this, you should navigate to the file config/environments/development.rb and paste in the two extra lines shown in Listing 1.7 and Figure 1.13.

Permettiamo le connessioni al web server locale.

***codice 01 - .../config/environments/development.rb - line: 63***

```ruby
  # Allow connections to local server.
  config.hosts.clear
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/07_01-config-environments-development.png)

Adesso se clicchiamo sul link di "Preview" in alto e scegliamo "Preview Running Application"
In basso a destra si apre la finestra di preview con un altro messaggio di errore perché manca la connessione al database PostgreSQL.

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/07_fig02-preview-db_error.png)

Per vedere il preview su un tab separato del browser fare click sull'icona di espansione. Quella che quando vai sopra con il cursore apre tip "Pop Out into new windows"

Questo errore lo risolviamo nel prossimo capitolo. 

---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/05-install_postgresql_on_ec2_amazon.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/07-pg_app_databases.md)
