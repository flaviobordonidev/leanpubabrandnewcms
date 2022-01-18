# <a name="top"></a> Cap 1.7 - PostgreSQL Databases per myapp

Creiamo i databases su postgreSQL in modo da attivare la connessione con la nostra applicazione Rails.



## Risorse interne:

- 99-rails_references/Leanpub markua/01-from_lfm_to_markua



## Gestiamo l'errore

L'errore è perché PostgreSQL non trova i databases di svilluppo e di test. Questi sono definiti sul file "/config/database.yml". 





{id: "01-01-06_01", caption: ".../config/database.yml -- codice 01", format: yaml, line-numbers: true, number-from: 24}

*.../config/database.yml - codice 01 - line:24*
```yaml
development:
  <<: *default
  database: bl6_0_development
```

{caption: ".../config/database.yml -- codice 01", format: yaml, line-numbers: true, number-from: 58}
```
test:
  <<: *default
  database: bl6_0_test
```

{caption: ".../config/database.yml -- codice 01", format: yaml, line-numbers: true, number-from: 81}
```
production:
  <<: *default
  database: bl6_0_production
  username: bl6_0
  password: <%= ENV['BL6_0_DATABASE_PASSWORD'] %>
```

[tutto il codice](#01-01-06_01all)

Come si vede il nome dei database è dato con la seguente convenzione:

* sviluppo    : "nome applicazione" più suffisso "_development"
* test        : "nome applicazione" più suffisso "_test"
* produzione  : si usa il nome dato sul server remoto. Nel nostro caso sul server di Heroku.




## Verifichiamo connessione

Anche se già visto nel preview, verifichiamo da terminale che non c'è comunicazione con il database.

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails db:migrate


user_fb:~/environment/bl6_0 (master) $ rails db:migrate
rails aborted!
ActiveRecord::NoDatabaseError: FATAL:  database "bl6_0_development" does not exist
...
```

Prende errore perché non esistono ancora i databases.




## Creiamo i databases

Creiamo i databases per development e test usando il comando "createdb" di postgreSQL.

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ createdb bl6_0_development
$ createdb bl6_0_test


user_fb:~/environment/myapp (master) $ sudo service postgresql start
Starting postgresql service:                               [  OK  ]
user_fb:~/environment/myapp (master) $ createdb bl6_0_development
user_fb:~/environment/myapp (master) $ createdb bl6_0_test
user_fb:~/environment/myapp (master) $ 
```

Nella creazione dei databases non ho messaggi di creazione effettuata sul terminale. 

verifichiamo che adesso c'è comunicazione eseguendo

{caption: "terminal", format: bash, line-numbers: false}
```
$ rails db:migrate

user_fb:~/environment/myapp (master) $ rails db:migrate
user_fb:~/environment/myapp (master) $ 
```

Come per la creazione dei databases, anche per il db:migrate non ho messaggi di conferma sul terminale. Sappiamo che c'è comunicazione perché il comando adesso non da nessun errore.




## Verifichiamo i databases creati da linea di comando di pg

Per verificare i databases dalla linea di comando di PostgreSQL:

{caption: "terminal", format: bash, line-numbers: false}
```
$ psql postgres
-> \list
-> \q


user_fb:~/environment/bl6_0 (master) $ psql postgres
psql (10.10 (Ubuntu 10.10-0ubuntu0.18.04.1))
Type "help" for help.

postgres=# \list
                                  List of databases
       Name        |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
-------------------+----------+----------+---------+---------+-----------------------
 bl6_0_development | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 bl6_0_test        | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 postgres          | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0         | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                   |          |          |         |         | postgres=CTc/postgres
 template1         | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                   |          |          |         |         | postgres=CTc/postgres
(5 rows)

postgres=# \q
user_fb:~/environment/bl6_0 (master) $ 
```

oppure


{caption: "terminal", format: bash, line-numbers: false}
```
$ psql --list


user_fb:~/environment/bl6_0 (master) $ psql --list
                                  List of databases
       Name        |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
-------------------+----------+----------+---------+---------+-----------------------
 bl6_0_development | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 bl6_0_test        | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 postgres          | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0         | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                   |          |          |         |         | postgres=CTc/postgres
 template1         | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                   |          |          |         |         | postgres=CTc/postgres
(5 rows)

user_fb:~/environment/bl6_0 (master) $ 
```

Avremmo potuto creare i databases anche da dentro la linea di comando di postgreSQL:

{caption: "terminal", format: bash, line-numbers: false}
```
$ psql
-> CREATE DATABASE "bl6_0_development";
-> CREATE DATABASE "bl6_0_test";
-> \list
-> \q
```




## Verifichiamo preview

{caption: "terminal", format: bash, line-numbers: false}
```
$ sudo service postgresql start
$ rails s
```

![Fig. 01](chapters/01-base/01-new_app/06_fig01-preview_working.png)

Anche se non riceviamo errore sembra non stia funzionando ma è un problema di preview dentro aws Cloud9. Basta aprirlo su una nuovo tab del browser e vediamo che funziona tutto!

![Fig. 02](chapters/01-base/01-new_app/06_fig02-preview_working_new_tab.png)

si apre un nuovo tab del browser sull'URL del root_path:

* https://mycloud9path.amazonaws.com/




## Il codice del capitolo




{id: "01-01-06_01all", caption: ".../config/database.yml -- codice 01", format: yaml, line-numbers: true, number-from: 1}
```
# PostgreSQL. Versions 9.3 and up are supported.
#
# Install the pg driver:
#   gem install pg
# On macOS with Homebrew:
#   gem install pg -- --with-pg-config=/usr/local/bin/pg_config
# On macOS with MacPorts:
#   gem install pg -- --with-pg-config=/opt/local/lib/postgresql84/bin/pg_config
# On Windows:
#   gem install pg
#       Choose the win32 build.
#       Install PostgreSQL and put its /bin directory on your path.
#
# Configure Using Gemfile
# gem 'pg'
#
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: bl6_0_development

  # The specified database role being used to connect to postgres.
  # To create additional roles in postgres see `$ createuser --help`.
  # When left blank, postgres will use the default role. This is
  # the same name as the operating system user that initialized the database.
  #username: bl6_0

  # The password associated with the postgres role (username).
  #password:

  # Connect on a TCP socket. Omitted by default since the client uses a
  # domain socket that doesn't need configuration. Windows does not have
  # domain sockets, so uncomment these lines.
  #host: localhost

  # The TCP port the server listens on. Defaults to 5432.
  # If your server runs on a different port number, change accordingly.
  #port: 5432

  # Schema search path. The server defaults to $user,public
  #schema_search_path: myapp,sharedapp,public

  # Minimum log levels, in increasing order:
  #   debug5, debug4, debug3, debug2, debug1,
  #   log, notice, warning, error, fatal, and panic
  # Defaults to warning.
  #min_messages: notice

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: bl6_0_test

# As with config/credentials.yml, you never want to store sensitive information,
# like your database password, in your source code. If your source code is
# ever seen by anyone, they now have access to your database.
#
# Instead, provide the password as a unix environment variable when you boot
# the app. Read https://guides.rubyonrails.org/configuring.html#configuring-a-database
# for a full rundown on how to provide these environment variables in a
# production deployment.
#
# On Heroku and other platform providers, you may have a full connection URL
# available as an environment variable. For example:
#
#   DATABASE_URL="postgres://myuser:mypass@localhost/somedatabase"
#
# You can use this database configuration with:
#
#   production:
#     url: <%= ENV['DATABASE_URL'] %>
#
production:
  <<: *default
  database: bl6_0_production
  username: bl6_0
  password: <%= ENV['BL6_0_DATABASE_PASSWORD'] %>
```



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/06-new_app.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/08-ruby_version.md)
