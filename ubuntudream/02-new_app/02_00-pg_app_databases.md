# <a name="top"></a> Cap 1.2 - PostgreSQL Databases per myapp

Creiamo i databases su postgreSQL in modo da attivare la connessione con la nostra applicazione Rails sia lato sviluppo che lato test.



## Risorse interne:

- [code_references/postgresql]()



## Verifichiamo connessione

Anche se lo abbiamo già visto nel preview, verifichiamo anche da terminale che non c'è comunicazione con il database.

```shell
$ rails db:migrate
```

Esempio:

```shell
ubuntu@ub22fla:~/ubuntudream$ rails db:migrate
bin/rails aborted!
ActiveRecord::NoDatabaseError: We could not find your database: ubuntudream_development. Available database configurations can be found in config/database.yml. (ActiveRecord::NoDatabaseError)

To resolve this error:

- Did you not create the database, or did you delete it? To create the database, run:

    bin/rails db:create

- Has the database name changed? Verify that config/database.yml contains the correct database name.


Caused by:
PG::ConnectionBad: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  database "ubuntudream_development" does not exist (PG::ConnectionBad)

Tasks: TOP => db:migrate
(See full trace by running task with --trace)
ubuntu@ub22fla:~/ubuntudream$ 
```

Prende errore perché manca il database lato sviluppo: `ubuntudream_development`.



## Vediamo il nome dei databases

L'errore già ci ha detto il nome del database con cui la nostra app cerca di collegarsi (`ubuntudream_development`) ma vediamo il file nella nostra app in cui sono definiti i collegamenti ai databases.

[Codice 01 - .../config/database.yml - linea: 22](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-new_app/02_01-config-database.yml)

```yaml
development:
  <<: *default
  database: ubuntudream_development
```

*...continua - linea: 56*

```yaml
test:
  <<: *default
  database: ubuntudream_test
```

*...continua - linea: 80*

```yaml
production:
  <<: *default
  database: ubuntudream_production
  username: ubuntudream
  password: <%= ENV["UBUNTUDREAM_DATABASE_PASSWORD"] %>
```

> Per vedere i files della nostra app ci colleghiamo con VS Code tramite SSH alla nostra VM come abbiamo visto nei capitoli precedenti ed apriamo la cartella/directory *ubuntudream*.



## Creiamo i databases

Creiamo i databases per development e test usando il comando `createdb` di postgreSQL.

```shell
$ createdb ubuntudream_development
$ createdb ubuntudream_test
```

> Se psql è stoppato lo possiamo attivare con `sudo service postgresql start`.


Esempio:

```shell
ubuntu@ub22fla:~/ubuntudream$ createdb ubuntudream_development
ubuntu@ub22fla:~/ubuntudream$ createdb ubuntudream_test
```

Nella creazione dei databases non ho dei messaggi di conferma sul terminale. Possiamo però verificare che adesso c'è comunicazione.

```shell
$ rails db:migrate
```

```shell
ubuntu@ub22fla:~/ubuntudream$ rails db:migrate
```

Come per la creazione dei databases, anche per il `db:migrate` non ho messaggi di conferma sul terminale. Sappiamo che c'è comunicazione perché il comando adesso non da nessun errore.



## Verifichiamo preview

Adesso proviamo di nuovo il preview

```shell
$ rails s -b 192.168.64.4
```

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/07_fig03-preview_working.png)

Funziona ^_^!



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/02-new_app/03_00-gemfile_ruby_version.md)
