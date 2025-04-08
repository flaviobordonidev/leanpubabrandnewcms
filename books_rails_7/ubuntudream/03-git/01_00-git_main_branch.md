# <a name="top"></a> Cap 4.1 - Inizializiamo git

Creiamo il nostro repository locale su Git.



## Risorse interne

- [01-base/02-git/09_00-credential_and_masterkey]


## Installiamo Git

Git è già impostato da Rails quando creiamo una nuova app, quindi è già pronto all'uso.




## Impostiamo i parametri globali su Git

Impostiamo i dati globali del nostro "account".

> Basta farlo **una sola volta per ogni VM**.
> Quindi se creiamo più applicazioni rails sulla stessa VM, serve solo la prima volta.

```shell
$ git config --global user.email "you@example.com"
$ git config --global user.name "Your Name"
# verifichiamo
$ git config -l
```

Esempio:

```shell
ubuntu@ub22fla:~/ubuntudream$ git config --global user.email "flavio.bordoni.dev@gmail.com"
ubuntu@ub22fla:~/ubuntudream$ git config --global user.name "Flavio Bordoni"
ubuntu@ub22fla:~/ubuntudream$ git config -l
user.email=flavio.bordoni.dev@gmail.com
user.name=Flavio Bordoni
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=git@github-as-ub22fla:flaviobordonidev/ubuntudreambis.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
```



## Archiviamo su Git

Prima di andare su Github dobbiamo fare il primo commit su Git in modo che sia creato il branch principale; ossia il branch `main`.

```shell
$ git add -A
$ git commit -m "first git commit"
```


```shell
ubuntu@ub22fla:~/ubuntudream$ git add -A
ubuntu@ub22fla:~/ubuntudream$ git commit -m "first git commit"
[main (root-commit) 97e0ba0] first git commit
 90 files changed, 1645 insertions(+)
 create mode 100644 .dockerignore
 create mode 100644 .gitattributes
 create mode 100644 .gitignore
 create mode 100644 .ruby-version
 create mode 100644 Dockerfile
 create mode 100644 Gemfile
 create mode 100644 Gemfile.lock
 create mode 100644 README.md
 create mode 100644 Rakefile
 create mode 100644 app/assets/config/manifest.js
 create mode 100644 app/assets/images/.keep
 create mode 100644 app/assets/stylesheets/application.css
 create mode 100644 app/channels/application_cable/channel.rb
 create mode 100644 app/channels/application_cable/connection.rb
 create mode 100644 app/controllers/application_controller.rb
 create mode 100644 app/controllers/concerns/.keep
 create mode 100644 app/controllers/mockups_controller.rb
 create mode 100644 app/controllers/pages_controller.rb
 create mode 100644 app/helpers/application_helper.rb
 create mode 100644 app/helpers/mockups_helper.rb
 create mode 100644 app/helpers/pages_helper.rb
 create mode 100644 app/javascript/application.js
 create mode 100644 app/javascript/controllers/application.js
 create mode 100644 app/javascript/controllers/hello_controller.js
 create mode 100644 app/javascript/controllers/index.js
 create mode 100644 app/jobs/application_job.rb
 create mode 100644 app/mailers/application_mailer.rb
 create mode 100644 app/models/application_record.rb
 create mode 100644 app/models/concerns/.keep
 create mode 100644 app/views/layouts/application.html.erb
 create mode 100644 app/views/layouts/mailer.html.erb
 create mode 100644 app/views/layouts/mailer.text.erb
 create mode 100644 app/views/mockups/test_a.html.erb
 create mode 100644 app/views/pages/home.html.erb
 create mode 100755 bin/bundle
 create mode 100755 bin/docker-entrypoint
 create mode 100755 bin/importmap
 create mode 100755 bin/rails
 create mode 100755 bin/rake
 create mode 100755 bin/setup
 create mode 100644 config.ru
 create mode 100644 config/application.rb
 create mode 100644 config/boot.rb
 create mode 100644 config/cable.yml
 create mode 100644 config/credentials.yml.enc
 create mode 100644 config/database.yml
 create mode 100644 config/environment.rb
 create mode 100644 config/environments/development.rb
 create mode 100644 config/environments/production.rb
 create mode 100644 config/environments/test.rb
 create mode 100644 config/importmap.rb
 create mode 100644 config/initializers/assets.rb
 create mode 100644 config/initializers/content_security_policy.rb
 create mode 100644 config/initializers/filter_parameter_logging.rb
 create mode 100644 config/initializers/inflections.rb
 create mode 100644 config/initializers/permissions_policy.rb
 create mode 100644 config/locales/en.yml
 create mode 100644 config/puma.rb
 create mode 100644 config/routes.rb
 create mode 100644 config/storage.yml
 create mode 100644 db/schema.rb
 create mode 100644 db/seeds.rb
 create mode 100644 lib/assets/.keep
 create mode 100644 lib/tasks/.keep
 create mode 100644 log/.keep
 create mode 100644 public/404.html
 create mode 100644 public/422.html
 create mode 100644 public/500.html
 create mode 100644 public/apple-touch-icon-precomposed.png
 create mode 100644 public/apple-touch-icon.png
 create mode 100644 public/favicon.ico
 create mode 100644 public/robots.txt
 create mode 100644 storage/.keep
 create mode 100644 test/application_system_test_case.rb
 create mode 100644 test/channels/application_cable/connection_test.rb
 create mode 100644 test/controllers/.keep
 create mode 100644 test/controllers/mockups_controller_test.rb
 create mode 100644 test/controllers/pages_controller_test.rb
 create mode 100644 test/fixtures/files/.keep
 create mode 100644 test/helpers/.keep
 create mode 100644 test/integration/.keep
 create mode 100644 test/mailers/.keep
 create mode 100644 test/models/.keep
 create mode 100644 test/system/.keep
 create mode 100644 test/test_helper.rb
 create mode 100644 tmp/.keep
 create mode 100644 tmp/pids/.keep
 create mode 100644 tmp/storage/.keep
 create mode 100644 vendor/.keep
 create mode 100644 vendor/javascript/.keep

ubuntu@ub22fla:~/ubuntudream (main)$ git branch
* main
```

> Notiamo con il comando `git branch` che adesso esiste il branch *main*.



## Aggiungiamo il nome del branch attivo sul prompt

Vedi:

- [code_references/git_github/branc_on_prompt]()
- [code_references/shell_linux/prompt]()



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/01_00-git_main_branch-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-production/02_00-github_initializing-it.md)
