# <a name="top"></a> Cap 1.7 - PostgreSQL Databases per myapp

Creiamo i databases su postgreSQL in modo da attivare la connessione con la nostra applicazione Rails.



## Risorse interne:

- 99-rails_references/Leanpub markua/01-from_lfm_to_markua



## Verifichiamo connessione

Anche se lo abbiamo già visto nel preview, verifichiamo anche da terminale che non c'è comunicazione con il database.

```bash
$ rails db:migrate
```

Esempio:

```bash
user_fb:~/environment $ cd bl7_0/
user_fb:~/environment/bl7_0 (main) $ rails db:migrate
rails aborted!
ActiveRecord::NoDatabaseError: We could not find your database: bl7_0_development. Which can be found in the database configuration file located at config/database.yml.

To resolve this issue:

- Did you create the database for this app, or delete it? You may need to create your database.
- Has the database name changed? Check your database.yml config has the correct database name.

To create your database, run:

        bin/rails db:create


Caused by:
PG::ConnectionBad: FATAL:  database "bl7_0_development" does not exist

Tasks: TOP => db:migrate
(See full trace by running task with --trace)
user_fb:~/environment/bl7_0 (main) $ 
```

Prende errore perché non esistono ancora i databases.



## Vediamo il nome dei databases

L'errore è perché PostgreSQL non trova i databases di svilluppo e di test. 
Questi sono definiti sul file **/config/database.yml**.

***codice 01 - .../config/database.yml - line:24***

```yaml
development:
  <<: *default
  database: bl7_0_development
```

***- line:58***

```yaml
test:
  <<: *default
  database: bl7_0_test
```

***- line:81***

```yaml
production:
  <<: *default
  database: bl7_0_production
  username: bl7_0
  password: <%= ENV['BL7_0_DATABASE_PASSWORD'] %>
```

[tutto il codice](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/07_01-config-database.yml)


Come si vede il nome dei database è dato con la seguente convenzione:

- sviluppo    : "nome applicazione" più suffisso "_development"
- test        : "nome applicazione" più suffisso "_test"
- produzione  : si usa il nome dato sul server remoto. Nel nostro caso sul server di Heroku.




## Creiamo i databases

Creiamo i databases per development e test usando il comando *createdb* di postgreSQL.

```bash
$ sudo service postgresql start
$ createdb bl7_0_development
$ createdb bl7_0_test
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (main) $ sudo service postgresql start
user_fb:~/environment/bl7_0 (main) $ createdb bl7_0_development
user_fb:~/environment/bl7_0 (main) $ createdb bl7_0_test
user_fb:~/environment/bl7_0 (main) $ 
```

Nella creazione dei databases non ho dei messaggi di conferma sul terminale. Possiamo però verificare che adesso c'è comunicazione.

```bash
$ rails db:migrate
```

```bash
user_fb:~/environment/bl7_0 (main) $ rails db:migrate
user_fb:~/environment/bl7_0 (main) $ 
```

Come per la creazione dei databases, anche per il db:migrate non ho messaggi di conferma sul terminale. Sappiamo che c'è comunicazione perché il comando adesso non da nessun errore.



## Verifichiamo i databases creati da linea di comando di pg

Per verificare i databases dalla linea di comando di PostgreSQL:

```bash
$ psql postgres
-> \list
-> \q
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (main) $ psql postgres
psql (10.19 (Ubuntu 10.19-0ubuntu0.18.04.1))
Type "help" for help.

postgres=# \list
                                  List of databases
       Name        |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
-------------------+----------+----------+---------+---------+-----------------------
 bl7_0_development | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 bl7_0_test        | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 postgres          | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0         | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                   |          |          |         |         | postgres=CTc/postgres
 template1         | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                   |          |          |         |         | postgres=CTc/postgres
(5 rows)

postgres=# \q
user_fb:~/environment/bl7_0 (main) $ 
```


oppure


```bash
$ psql --list
```

Esempio:

```bash
user_fb:~/environment/bl7_0 (main) $ psql --list
                                  List of databases
       Name        |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
-------------------+----------+----------+---------+---------+-----------------------
 bl7_0_development | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 bl7_0_test        | ubuntu   | UTF8     | C.UTF-8 | C.UTF-8 | 
 postgres          | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0         | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                   |          |          |         |         | postgres=CTc/postgres
 template1         | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                   |          |          |         |         | postgres=CTc/postgres
(5 rows)

user_fb:~/environment/bl7_0 (main) $ 
```

Avremmo potuto anche creare i databases da linea di comando di postgreSQL:

```bash
$ psql
-> CREATE DATABASE "bl7_0_development";
-> CREATE DATABASE "bl7_0_test";
-> \list
-> \q
```




## Verifichiamo preview

Adesso proviamo di nuovo il preview

```bash
$ sudo service postgresql start
$ rails s
```

![fig01](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/07_fig01-preview_working.png)

Anche se non riceviamo errore sembra non stia funzionando ma è un problema di preview dentro aws Cloud9. 
Basta aprirlo su un nuovo tab del browser e vediamo che funziona tutto!
Clicchiamo sull'icona in alto a destra nel riquadro del preview per aprirlo su un nuovo tab del browser.

Si apre un nuovo tab del browser sull'URL del root_path:

- *https://[mycloud9path].amazonaws.com*

![fig02](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/07_fig02-preview_working_new_tab.png)


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/06-new_app.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/01-new_app/08-ruby_version.md)
