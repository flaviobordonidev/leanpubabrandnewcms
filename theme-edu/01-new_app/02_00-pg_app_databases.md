# <a name="top"></a> Cap 1.2 - PostgreSQL Databases per myapp

Creiamo i databases su postgreSQL in modo da attivare la connessione con la nostra applicazione Rails sia lato sviluppo che lato test.



## Risorse interne:

- [code_references/postgresql]



## Verifichiamo connessione

Anche se lo abbiamo già visto nel preview, verifichiamo anche da terminale che non c'è comunicazione con il database.

```bash
$ rails db:migrate
```

Esempio:

```bash
ubuntu@ubuntufla:~/ubuntudream $rails db:migrate
rails aborted!
ActiveRecord::NoDatabaseError: We could not find your database: ubuntudream_development. Which can be found in the database configuration file located at config/database.yml.

To resolve this issue:

- Did you create the database for this app, or delete it? You may need to create your database.
- Has the database name changed? Check your database.yml config has the correct database name.

To create your database, run:

        bin/rails db:create


Caused by:
PG::ConnectionBad: FATAL:  database "ubuntudream_development" does not exist

Tasks: TOP => db:migrate
(See full trace by running task with --trace)
ubuntu@ubuntufla:~/ubuntudream $
```

Prende errore perché manca il database lato sviluppo: `ubuntudream_development`.



## Vediamo il nome dei databases

L'errore già ci ha detto il nome del database con cui la nostra app cerca di collegarsi (`ubuntudream_development`) ma vediamo il file nella nostra app in cui sono definiti i collegamenti ai databases.

***codice 01 - .../config/database.yml - line:24***

```yaml
development:
  <<: *default
  database: ubuntudream_development
```

***codice 01 - ...continua - line:58***

```yaml
test:
  <<: *default
  database: ubuntudream_test
```

***codice 01 - ...continua - line:82***

```yaml
production:
  <<: *default
  database: ubuntudream_production
  username: ubuntudream
  password: <%= ENV["UBUNTUDREAM_DATABASE_PASSWORD"] %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/02_01-config-database.yml)


> Per vedere i files della nostra app ci colleghiamo con VS Code tramite SSH alla nostra VM come abbiamo visto nei capitoli precedenti ed apriamo la cartella/directory *ubuntudream*.



## Creiamo i databases

Creiamo i databases per development e test usando il comando `createdb` di postgreSQL.

```bash
$ sudo service postgresql start
$ createdb ubuntudream_development
$ createdb ubuntudream_test
```

Esempio:

```bash
ubuntu@ubuntufla:~/bl7_0$ sudo service postgresql start
ubuntu@ubuntufla:~/bl7_0$ createdb ubuntudream_development
ubuntu@ubuntufla:~/bl7_0$ createdb ubuntudream_test
ubuntu@ubuntufla:~/bl7_0$ 
```

Nella creazione dei databases non ho dei messaggi di conferma sul terminale. Possiamo però verificare che adesso c'è comunicazione.

```bash
$ rails db:migrate
```

```bash
ubuntu@ubuntufla:~/bl7_0$ rails db:migrate
ubuntu@ubuntufla:~/bl7_0$ 
```

Come per la creazione dei databases, anche per il db:migrate non ho messaggi di conferma sul terminale. Sappiamo che c'è comunicazione perché il comando adesso non da nessun errore.



## Verifichiamo preview

Adesso proviamo di nuovo il preview

```bash
$ rails s -b 192.168.64.3
```

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/07_fig03-preview_working.png)

Funziona ^_^!



---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/01_00-new_app-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/01-new_app/03_00-gemfile_ruby_version.md)
